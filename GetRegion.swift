//
//  GetRegion.swift
//  Pods
//
//  Created by Tommy Mallow (GMC-GSS-INTERN) on 7/31/17.
//

import Foundation

public class GetRegion: NSObject,ConnectionManagerDelegate {
    
    
    /// The Name of the Default Production API Key.
    /// An API Key under this name is required to be registered with ConnectionKeyManager prior to accessing the
    /// initializer using the default API Key Name setting while CASConfiguration.shared.buildConfiguration == .production
    public static let apiKeyNameProd = ConnectionKeyManager.compassionCIProdName
    
    /// The Name of the Default Staging API Key.
    /// An API Key under this name is required to be registered with ConnectionKeyManager prior to accessing the
    /// initializer using the default API Key Name setting while CASConfiguration.shared.buildConfiguration == .staging
    public static let apiKeyNameStage = ConnectionKeyManager.compassionCIStageName
    
    /// The Name of the Default Dev API Key.
    /// An API Key under this name is required to be registered with ConnectionKeyManager prior to accessing the
    /// initializer using the default API Key Name setting while CASConfiguration.shared.buildConfiguration == .development
    public static let apiKeyNameDev = ConnectionKeyManager.compassionCIStageName
    
    // MARK: - Common properties
    
    public var verbosity: VerbosityLevel = .off
    
    internal var connectionManager = ConnectionManager()
    fileprivate unowned var delegate: GetRegionDelegate
    
    /// The response received (if any) from the server
    fileprivate(set) public var response:HTTPURLResponse?
    
    /// Saving the regionCode ID for verifying the returned child data.
    public var regionCode: String!
    
    
    
    // MARK: - Initializers
    // initializer, can return nil if api key is unavailable
    public init?(regionCode: String,
                 delegate:GetRegionDelegate,
                 apiKeyName: String? = nil,
                 verbosity: VerbosityLevel = .off) {
        
        self.delegate = delegate
        self.regionCode = regionCode //GetRegionInformation.map(code: regionCode)
        self.verbosity = verbosity
        
        super.init() //line 50
        
        let configuration = getConfiguration(apiKeyName: apiKeyName)
        
        // key: ZpgTzA5DvFmi
        // check if key is available
        /*
         if ConnectionKeyManager.shared.keyAvailable(name: configuration.validApiKeyName) == nil { //line 55
         delegate.getRegionFailed(self, response: nil)
         
         return nil // keys are not available.  fail the initialization
         }*/
        
        connectionManager.cmdelegate = self
        connectionManager.verbosity = verbosity
        
        
        // get the queue for running the request
        if let queue = ConnectionKeyManager.shared.queue(name: configuration.validApiKeyName) {
            // background
            queue.async {
                
                if let /*apiKey*/ _ = ConnectionKeyManager.shared.key(name: configuration.validApiKeyName),
                    let regionCode = self.regionCode { // line 80
                    
                    let urlString = "\(configuration.baseAddress)\(regionCode)" //  add URL
                    // run the connection
                    if !self.connectionManager.getMessage(fromServer: urlString, headers: nil, beginImmediately: true) {
                        // something broke when we tried to start the call, let the delegate know
                        self.delegate.getRegionFailed(self, response: self.response)
                    }                    
                    
                } else {
                    delegate.getRegionFailed(self, response: self.response)
                }
                
            } // end background queue
        }       else {
            // Failed to get the queue
            self.delegate.getRegionFailed(self, response: self.response)
            return nil
        }
        
    }

    
    // MARK: - Private
    
    /// Parses the configuration and returns the baseAddress and API Key Name based on the build configurations.
    fileprivate func getConfiguration(apiKeyName: String?) -> (baseAddress: String, validApiKeyName: String) {
        let validApiKeyName: String
        let baseAddress: String
        
        switch CASConfiguration.shared.buildConfiguration {
        case .development:
            // NOTE: Below are for Test, not Development.
            baseAddress = "http://localhost:3001/api/getProjectRegion/" // add base URL
            validApiKeyName = apiKeyName ?? GetRegion.apiKeyNameDev
        case .staging:
            baseAddress = "http://localhost:3001/api/getProjectRegion/"
            validApiKeyName = apiKeyName ?? GetRegion.apiKeyNameStage
        case .production:
            baseAddress = "http://localhost:3001/api/getProjectRegion/"
            validApiKeyName = apiKeyName ?? GetRegion.apiKeyNameProd
        }
        
        return (baseAddress: baseAddress, validApiKeyName: validApiKeyName)
    }
    
    
        // MARK: - ConnectionManagerDelegate
        public func operationComplete(connectionManager: ConnectionManager) { // line 136
            var success = false
            
            if let data = connectionManager.receivedData {
                do {
                    let dataJson = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.allowFragments)
                    
                    
                    if let dict = dataJson as? NSDictionary,
                        let regionResponseDictionary = dict.object(forKey: "results") as? NSDictionary { // This "data" section will be changed depends on the caller.
                        // The only dictionary item in the response is an array. Each array item is a
                        // Region Project dictionary. If there is at least one item, return the Region Project dictionary.
                        if regionResponseDictionary.count > 0 {
                            
                            if let regionDict = regionResponseDictionary as NSDictionary?,
                                let result = GetRegionResult(dict: regionDict) {
                                // Verify the result data is what is expected.
//                                if result.isCorrectRegionData(expectRegionCode: regionCode) { // isCorrectRegionData will be in the GetRegionResult
                                    // Got correct data. It will be validated elsewhere.
                                    success = true
                                    delegate.getRegionComplete(self, result: result)
                                //}
                            }
                        }
                    } else {
                        
                    }
                    
                }
                catch {}
            } else {
                
            }
            
            if !success {
                // To be successful, the response must have non-empty data.
                delegate.getRegionFailed(self, response: response)
                print(">>>>>>>>>......... getRegionFailed because of empty data")

            }
        }
        
        public func operationFailed(connectionManager: ConnectionManager) {
        print(">>>>>>>>>.........operationFailed in GetRegion ")
            delegate.getRegionFailed(self, response: response)
        }
        
        public func uploadInProgress(connectionManager: ConnectionManager) {}
        
        public func downloadInProgress(connectionManager: ConnectionManager) {}
        
        public func responseReceived(connectionManager: ConnectionManager, response: HTTPURLResponse) {
            self.response = response
        }
        
}
