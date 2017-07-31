//
//  RLMGetCountry.swift
//  Pods
//
//  Created by Tommy Mallow (GMC-GSS-INTERN) on 7/31/17.
//
//

import Foundation
import RealmSwift

public class RLMGetRegion: Object {
    
    
    //MARK: - first letter in the orginal data is upper case, local var name are lower case
    public dynamic var regionDisplay : String?
    public dynamic var countryDisplay : String?
    public dynamic var regionCode : String = ""
    
    public  var dailylifeList = List<RLMGetRegionItem>()
    public  var communityList = List<RLMGetRegionItem>()
    public  var educationregionList = List<RLMGetRegionItem>()
    public  var compassionregionList = List<RLMGetRegionItem>()

    
    
    // Auit log
    public dynamic var lastUpdated: Date?
    
    //MARK: - Overrides
    
    override public class func primaryKey() -> String? {
        return "regionCode"
    }
    
    
    public static func getRealmRegion(fromRegionResult r: GetRegionResult, updatingRegion: RLMGetRegion? = nil) -> RLMGetRegion { // GetRegionResult is the file where data was retrieved from the web.
        let rlmGetRegion = updatingRegion ?? RLMGetRegion()
        
        if updatingRegion == nil {
            rlmGetRegion.regionCode = r.regionCode
        }
        
        rlmGetRegion.countryDisplay = r.countryDisplay
        rlmGetRegion.regionDisplay = r.regionDisplay
        
        
        
        //Audit log
        rlmGetRegion.lastUpdated = Date()
        
        
        
        return rlmGetRegion

    }
}
// soon tobe changed
/// this needs to be in another file called RLMGetCountryItem
public class RLMGetRegionItem: Object {
    
    // MARK: Properties
    
    public dynamic var UUID: String?
    public dynamic var image: String?
    public dynamic var compassionchilddevelopmentcenter: String?
    public dynamic var workingthroughthelocalchurch: String?
    
    
    public dynamic var issuesandconcerns: String?// Convert to CSV
    public dynamic var localneedsandchallenges: String?// Convert to CSV
    public dynamic var schoolsandeducation: String?// Convert to CSV
    public dynamic var whatcompassionsponsorshipprovides: String?// Convert to CSV
    public dynamic var howcompassionworks: String?// Convert to CSV
    public dynamic var childrenathome: String?// Convert to CSV
    public dynamic var economy: String?// Convert to CSV
    public dynamic var geographyandclimate: String?// Convert to CSV
    
    
    // Audit log
    public dynamic var lastUpdated: Date?
    
    
    
    // MARK: - Overrides
    
    override public class func primaryKey() -> String? {
        return "UUID"
    }
    
    
    
    // MARK: - Public
    
    /// Instantiate a RLMGetCountryItem object from a GetcountryResult.GetCountryItem object.
    ///
    /// - Parameter from: A populated GetcountryResult.GetCountryItem object.
    /// - Returns: A populated RLMGetCountryItem
    public static func getRealmRegionItem(from r: GetRegionResult.GetRegionItem) -> RLMGetRegionItem {
        let rlmGetRegionItem = RLMGetRegionItem()
        
        rlmGetRegionItem.UUID = r.UUID
        rlmGetRegionItem.image = r.image
        rlmGetRegionItem.compassionchilddevelopmentcenter = r.compassionchilddevelopmentcenter
        rlmGetRegionItem.workingthroughthelocalchurch = r.workingthroughthelocalchurch
        
        rlmGetRegionItem.issuesandconcerns = RLMGetRegionItem.createCsvString(array: r.issuesandconcernsArray)
        
        rlmGetRegionItem.localneedsandchallenges = RLMGetRegionItem.createCsvString(array: r.localneedsandchallengesArray)
        rlmGetRegionItem.schoolsandeducation = RLMGetRegionItem.createCsvString(array: r.schoolsandeducationArray)
        rlmGetRegionItem.whatcompassionsponsorshipprovides = RLMGetRegionItem.createCsvString(array: r.whatcompassionsponsorshipprovidesArray)
        rlmGetRegionItem.howcompassionworks = RLMGetRegionItem.createCsvString(array: r.howcompassionworksArray)
        rlmGetRegionItem.childrenathome = RLMGetRegionItem.createCsvString(array: r.childrenathomeArray)
        rlmGetRegionItem.economy = RLMGetRegionItem.createCsvString(array: r.economyArray)
        rlmGetRegionItem.geographyandclimate = RLMGetRegionItem.createCsvString(array: r.geographyandclimateArray)
        
        // Audit log
        rlmGetRegionItem.lastUpdated = Date()
        
        return rlmGetRegionItem
    }
    
    // MARK: - Private
    
    
    /// Create a comma-separated string from a string array.
    ///
    /// - Parameter array: Array of strings.
    /// - Returns: A comma-separated string or nil.
    fileprivate static func createCsvString(array: [String]?) -> String? {
        if let array = array {
            return array.joined(separator: "$..$")

        }
        
        return nil
    }

}
