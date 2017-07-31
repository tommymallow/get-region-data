//
//  GetRegionCacheManager.swift
//  Pods
//
//  Created by Tommy Mallow (GMC-GSS-INTERN) on 7/25/17.
//
//

import Foundation
import RealmSwift

internal class RegionCacheManager: NSObject, GetRegionDelegate {
    
    // MARK: - Properties
    
    /// Singleton for the class.
    internal static let shared = RegionCacheManager()
    
    public var verbose = false
    
    fileprivate var serialQueue = DispatchQueue(label: "CompassionAppServices.RegionCacheManager.serialQueue")
    
    /// Fetches the Realm object holding the beneficiary detail data.
    fileprivate var regionRealm: Realm? {
        return InsecureDataStore.shared.getInternalRealm(name: regionRealmName)
    }
    
    
    /// List of all RegionProject fetches in progress.
    fileprivate var callbacks = [
        (regionCode: String,
         getRegion: GetRegion,
         getRegionResult: GetRegionResult?,
         callback: ((region: GetRegionResult, expectUpdates: Bool)->()),
         failureCallback: ((regionCode: String)->())
        )
        ]()
    
    
    
    // MARK: - Constants
    
    /// Name of the Realm containing all RegionProject detail data.
    internal let regionRealmName = "RegionProject"
    
    /// Key used for saving/retrieving the update frequency of RegionProject data.
    fileprivate let updateFrequencyKey = "CASConfiguration.getRegionCacheManager.updateFrequency"
    
    // MARK: - Initializers
    
    // Private initializer for singleton.
    fileprivate override init() {
        if let updateFrequencyNumber = UserDefaults.standard.value(forKey: updateFrequencyKey) as? NSNumber {
            updateFrequency = CASCDataUpdateFrequency(rawValue: updateFrequencyNumber.intValue) ?? CASConfiguration.shared.defaultDataUpdateFrequency
        }
        else {
            updateFrequency = CASConfiguration.shared.defaultDataUpdateFrequency
        }
        
        super.init()
        
        InsecureDataStore.shared.addInternalRealm(name: regionRealmName)
    }
    
    // MARK: - Update frequency
    
    internal var updateFrequency: CASCDataUpdateFrequency {
        didSet {
            UserDefaults.standard.set(NSNumber(integerLiteral: updateFrequency.rawValue), forKey: updateFrequencyKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    internal func resetUpdateFrequencyToDefault() {
        UserDefaults.standard.removeObject(forKey: updateFrequencyKey)
        UserDefaults.standard.synchronize()
        
        updateFrequency = CASConfiguration.shared.defaultDataUpdateFrequency
    }
    
    // MARK: - Main functions
    
    /// Finds the  data for the passed-in regionCode, and returns it in the callback.
    ///  Callback immediately if the data is cached already
    ///  Callback after a successful download.
    ///  If the data is older than the updateFrequency, it will callback immediately and again after a successful download.
    ///  Will NOT attempt to redownload if the download fails.
    ///
    /// - Parameters:
    ///   - regionCode: The regionProject's key
    ///   - callback: Callback to return data.
    ///   - failureCallback: Called if the GetRegion fetch fails.
    
    @discardableResult
    internal func getRegion(regionCode: String,
                             callback:@escaping (( _ RegionResult: GetRegionResult, _ expectUpdates: Bool)->()),
                             failureCallback: @escaping ((_ regionCode: String)->())) -> GetRegionResult? {
        // If we have the Realm object and the regionProject record, we can continue.
        // TODO - check if this record is complete and download whatever is missing if not!!!
        
        if let realm = self.regionRealm,
            let rlmGetRegion = realm.objects(RLMGetRegion.self).filter({ $0.regionCode == regionCode }).first {
            
            // Init a regionProject result object to return in the callback.
            let record = GetRegionResult(realmResult: rlmGetRegion)
            
            let expectUpdates = calcExpectUpdatesFlag(lastUpdated: rlmGetRegion.lastUpdated)
            
            if verbose { print("================================================ record.isComplete().regionProjectDetails \(expectUpdates)") }
            
            callback(record, expectUpdates)
            
            if !expectUpdates {
                // Not updating the data this pass.
                return record
            }
        } // end if-let realm, record
        
        serialQueue.async {
            if let getRegion = GetRegion(regionCode: regionCode, delegate: self) {
                self.callbacks.append((regionCode: regionCode,
                                       getRegion: getRegion,
                                       getRegionResult: nil,
                                       callback: callback,
                                       failureCallback: failureCallback))
                
                
            }
        }
        return nil
    }
    
    
    // MARK: - Converter functions
    
    /// Creates a RLMGetRegion object from a GetRegionResult object.
    ///
    /// - Parameter result: A populated GetRegionResult object.
    /// - Returns: A populated rlmGetRegion object.
    internal func createRLMGetRegionObject(fromGetRegionResult result: GetRegionResult?, updatingRegion: RLMGetRegion? = nil) -> RLMGetRegion? {
        guard let r = result else {
            return nil
        }
        
        if r.regionCode == "" {
            return nil
        }
        
        return RLMGetRegion.getRealmRegion(fromRegionResult: r, updatingRegion: updatingRegion)
    }
    
    /// Creates a GetRegionResult object from a RLMBeneficiary object.
    ///
    /// - Parameter rlmGetRegion: A populated RLMBeneficiary object.
    /// - Returns: A populated GetRegionResult object.
    internal func createRLMGetRegionResultObject(fromRLMGetRegion rlmGetRegion: RLMGetRegion) -> GetRegionResult {
        return GetRegionResult(realmResult: rlmGetRegion)
    }
    
    
    
    
    /// Creates a list of Realm (RLMGetRegionItem) objects.
    ///
    /// - Parameter getRegionList: List of all Beneficiary Household Item record to get Realm objects for.
    /// - Returns: Either a populated list of realm objects or nil.
    fileprivate func getRegionRealmList(getRegionList: [GetRegionResult.GetRegionItem]) -> List<RLMGetRegionItem>? {
        let rlmGetRegionList = List<RLMGetRegionItem>()
        
        // Look through every item in the beneficiary household item list and get a Realm object for it.
        for getRegionItem in getRegionList {
            let rlmGetRegionItem = RLMGetRegionItem.getRealmRegionItem(from: getRegionItem)
            
            
            // Add the current Realm object to the list.
            rlmGetRegionList.append(rlmGetRegionItem)
        }
        
        return rlmGetRegionList.count > 0 ? rlmGetRegionList : nil
    }
    
    
    
    // MARK: - Realm DELETE functions
    
    /// Deletes a RLMRegion object from the Realm database.
    ///
    /// - Parameter regionCode: The beneficiary global ID for the region record to delete from the database.
    internal func deleteRegionFromRealm(regionCode: String) {
        guard let realm = self.regionRealm else {
            return
        }
        
        if let r = realm.objects(RLMGetRegion.self).filter({ $0.regionCode == regionCode }).first {
            
            
            realm.beginWrite()
            realm.delete(r)
            let _ = try? realm.commitWrite()
        }
    }
    
    
    
    fileprivate func calcExpectUpdatesFlag(lastUpdated: Date?) -> Bool {
        var expectUpdates: Bool
        
        if updateFrequency == .never {
            expectUpdates = false
        }
        else {
            expectUpdates = true
            
            if let lastUpdated = lastUpdated {
                let elapsed = -lastUpdated.timeIntervalSinceNow
                
                switch updateFrequency {
                case .never:
                    expectUpdates = false
                case .weekly:
                    if elapsed < 60 * 60 * 24 * 7 {
                        expectUpdates = false
                    }
                case .daily:
                    fallthrough
                case .everyLaunch:
                    if elapsed < 60 * 60 * 24 {
                        expectUpdates = false
                    }
                }
            }
        }
        
        return expectUpdates
    }
    
    
    // MARK: - Private
    
    /// Based on the updateFrequency setting and the elapsed time from
    /// the lastUpdated param, determines if an update is needed.
    ///
    /// - Parameter lastUpdated: Date/time a Realm joshuaProject record was updated.
    /// - Returns: Flag indicating if record needs updated.
    
    
    
    func getRegionComplete(_ sender: GetRegion, result: GetRegionResult?) {
        serialQueue.async {
            if let index = self.callbacks.index(where: { $0.getRegion == sender }) {
                self.callbacks[index].getRegionResult = result
                if index < self.callbacks.count && index >= 0 {
                    if let regionResult = self.callbacks[index].getRegionResult,
                        let realm = self.regionRealm {
                        realm.beginWrite()
                        if let rlmGetRegion = self.createRLMGetRegionObject(fromGetRegionResult: regionResult, updatingRegion: realm.object(ofType: RLMGetRegion.self, forPrimaryKey: regionResult.regionCode)) {
                            
                            realm.add(rlmGetRegion, update:true)
                            
                            let _ = try? realm.commitWrite()
                            
                            self.callbacks[index].callback(regionResult, true)
                            self.callbacks.remove(at: index)
                        }
                        let _ = try? realm.commitWrite()
                        
                    }
                }
            }
        }
    }
    
    func getRegionFailed(_ sender: GetRegion, response: HTTPURLResponse?) {
        serialQueue.async {
            if let index = self.callbacks.index(where: { $0.getRegion == sender }) {
                let regionCode = self.callbacks[index].regionCode
                
                self.callbacks[index].failureCallback(regionCode)
                self.callbacks.remove(at: index)
            }
        }
    }
}
