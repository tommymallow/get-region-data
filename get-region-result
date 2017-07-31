//
//  GetRegionResult.swift
//  Pods
//
//  Created by Tommy Mallow (GMC-GSS-SR MOBILE APP DEVLPR, WEB) on 7/31/17.
//
//

import Foundation
import RealmSwift

public struct GetRegionResult: Equatable {
    
    // MARK: - Properties
    
    public var regionDisplay: String?
    public var countryDisplay: String?
    public var regionCode: String
    
    public var dailylifeList: [GetRegionItem]?
    public var communityList: [GetRegionItem]?
    public var educationregionList:[GetRegionItem]?
    public var compassionregionList:[GetRegionItem]?




    
    // tuple of religious percents
    //public var religionPercents: (christian: Int?, evangelical: Int?, buddist: Int?,  doublyProfessing: Int?, ethnic: Int?, hindu: Int?, muslim: Int?, non: Int?, otherSmall: Int?, unknown: Int?, anaglican: Int?, independant: Int?, protestant: Int?, orthodox: Int?, other: Int?, romanCatholic: Int?)
    
    public init?(dict: NSDictionary){
        regionCode = dict["region"] as? String ?? "" // set it to empty first
        setString(value: &self.regionDisplay, fromDict: dict, forKey: "regiondisplay")
        setString(value: &self.countryDisplay, fromDict: dict, forKey: "countrydisplay")
        
        dailylifeList = storeListArray(fromDictionary: dict , forKey: "dailylife")
        communityList = storeListArray(fromDictionary: dict , forKey: "community")
        educationregionList = storeListArray(fromDictionary: dict , forKey: "educationregion")
        compassionregionList = storeListArray(fromDictionary: dict , forKey: "compassionregion")

    }
    
    
    public init(realmResult result: RLMGetRegion) {
        regionDisplay = result.regionDisplay
        countryDisplay = result.countryDisplay
        regionCode = result.regionCode
        
        dailylifeList = storeRlmList(realmResult: result.dailylifeList)
        communityList = storeRlmList(realmResult: result.communityList)
        educationregionList = storeRlmList(realmResult: result.educationregionList)
        compassionregionList = storeRlmList(realmResult: result.compassionregionList)

    }

    
    // MARK: - Helpers
    
    
    /// Checks the saved region Code with the region Code from the fetched record.
    ///
    /// - Parameter expectregionCode: region Code from fetched record.
    /// - Returns: True if the passed-in region Code matches the saved region Code.
    
    public func isCorrectRegionData(expectRegionCode: String) -> Bool {
            return expectRegionCode == regionCode
    }
    
    
    // MARK: - Private functions
    fileprivate func storeListArray(fromDictionary dict: NSDictionary, forKey column: String) -> [GetRegionItem]? {
        
        if let tempdListArray = dict.object( forKey: column) as? [NSDictionary] {
            var tempArray: [GetRegionItem] = []
            
            for itemDict in tempdListArray {
                if let getRegionItem = GetRegionItem(dict: itemDict) {
                    
                    tempArray.append(getRegionItem)
                }
            }
            
            if tempArray.count > 0 {
                let tempList = tempArray
                return tempList
            }
        }
        
        return nil
        
    }
    
    fileprivate func storeRlmList(realmResult result: List<RLMGetRegionItem>) -> [GetRegionItem]? {
        var tempList = [GetRegionItem]()
        
        for rlmGetRegionItem in result{
            let getRegionItem = GetRegionItem(realmResult: rlmGetRegionItem)
            tempList.append(getRegionItem)
        }
        
        if tempList.count > 0 {
            return (tempList)
        }
        
        return nil
    }
    
    fileprivate func setString(value: inout String?, fromDict dict: NSDictionary, forKey key: String) {
        if let item = dict.object(forKey: key) as? String {
            value = item
        }
    }
    
    
    
    // MARK: - Structure GetRegionItem
    
    public struct GetRegionItem { //needs to be fixed
        
        // MARK: - Properties
        
        public var UUID: String?
        public var image: String?
        public var issuesandconcernsArray: [String]?
        public var localneedsandchallengesArray: [String]?
        public var compassionchilddevelopmentcenter: String?
        public var compassionchilddevelopmentcenterArray: [String]?
        public var schoolsandeducationArray: [String]?
        public var whatcompassionsponsorshipprovidesArray: [String]?
        public var howcompassionworksArray: [String]?
        public var workingthroughthelocalchurch: String?
        public var childrenathomeArray: [String]?
        public var economyArray: [String]?
        public var geographyandclimateArray: [String]?



        
        
        // MARK: - Initializers
        
        public init() {}
        
        public init?(dict: NSDictionary) {
            setString(value: &self.UUID, fromDict: dict, forKey: "UUID")
            setString(value: &self.image,       fromDict: dict, forKey: "image")
            setStringArray(value: &self.issuesandconcernsArray,       fromDict: dict, forKey: "issuesandconcerns")
            setStringArray(value: &self.localneedsandchallengesArray,       fromDict: dict, forKey: "localneedsandchallenges")
            setString(value: &self.compassionchilddevelopmentcenter,       fromDict: dict, forKey: "compassionchilddevelopmentcenter")
            setStringArray(value: &self.schoolsandeducationArray,       fromDict: dict, forKey: "schoolsandeducation")
            setStringArray(value: &self.whatcompassionsponsorshipprovidesArray,       fromDict: dict, forKey: "whatcompassionsponsorshipprovides")
            setStringArray(value: &self.howcompassionworksArray,       fromDict: dict, forKey: "howcompassionworks")
            setString(value: &self.workingthroughthelocalchurch,       fromDict: dict, forKey: "workingthroughthelocalchurch")
            setStringArray(value: &self.childrenathomeArray,       fromDict: dict, forKey: "childrenathome")
            setStringArray(value: &self.economyArray,       fromDict: dict, forKey: "economy")
            setStringArray(value: &self.geographyandclimateArray,       fromDict: dict, forKey: "geographyandclimate")


            
        }
        
        public init(realmResult result: RLMGetRegionItem) {
            UUID  = result.UUID
            image  = result.image
            compassionchilddevelopmentcenter  = result.compassionchilddevelopmentcenter
            workingthroughthelocalchurch  = result.workingthroughthelocalchurch
            
            issuesandconcernsArray = arrayFromCsvString(s: result.issuesandconcerns)
            localneedsandchallengesArray  = arrayFromCsvString(s: result.localneedsandchallenges)
            schoolsandeducationArray  = arrayFromCsvString(s: result.schoolsandeducation)
            whatcompassionsponsorshipprovidesArray  = arrayFromCsvString(s: result.whatcompassionsponsorshipprovides)
            howcompassionworksArray  = arrayFromCsvString(s: result.howcompassionworks)
            childrenathomeArray  = arrayFromCsvString(s: result.childrenathome)
            economyArray  = arrayFromCsvString(s: result.economy)
            geographyandclimateArray  = arrayFromCsvString(s: result.geographyandclimate)

        }
        
        fileprivate func setString(value: inout String?, fromDict dict: NSDictionary, forKey key: String) {
            if let item = dict.object(forKey: key) as? String {
                value = item
            }
        }
        
        fileprivate func setStringArray(value: inout [String]?, fromDict dict: NSDictionary, forKey key: String) {
            if let item = dict.object(forKey: key) as? [String] {
                value = item.count > 0 ? item : nil
            }
        }
        
        //change this separated by symbol later
        fileprivate func arrayFromCsvString(s: String?) -> [String]? {
            if let s = s {
               return s.characters.count > 0 ? s.components(separatedBy: "$..$") : nil
                
            }
            
            return nil
        }
        

    }
    
    
}

// MARK: - Equatable

public func ==(lhs: GetRegionResult, rhs: GetRegionResult) -> Bool {
    if lhs != rhs {
        return false
    }
    
    return true
}

//////////////////end
