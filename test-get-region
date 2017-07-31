//
//  TESTGetRegion.swift
//  FrameworkClasses
//
//  Created by Tommy Mallow on 7/31/17.
//

import Foundation
import XCTest

@testable import CompassionAppServices

class TESTGetRegion: XCTestCase, GetRegionDelegate {
    
    // MARK: - Properties
    
    var sut:            GetRegion!
    var expectation:    XCTestExpectation!
    var result:         GetRegionResult!
    var response:       HTTPURLResponse?
    
    /// Defines the number of seconds to wait for an asynchronous call.
    let asyncTimeout: Double = 7
    let regionDisplay = "Urban"
    let countryDisplay = "Burkina Faso"
    let regionCode = "urbanBF"
    let UUID = "urbanBF"
    let dailyLifeImage = "http://localhost:3001/uploads/urbanBFdailylife.jpg"
    let compassionregionImage = "http://localhost:3001/uploads/bike-1500500547306.png"
    let communityImage = "http://localhost:3001/uploads/bike-1500500547306.png"
    let educationregionImage = "http://localhost:3001/uploads/bike-1500500547306.png"
    let workingthroughthelocalchurch = "The local church, as a spiritual and social institution, is Compassion’s most crucial partner in each community.\n\nMore churches in urban Burkina Faso are working with Compassion to nurture and protect children.\n\nSuch partnerships are vital in implementing Compassion’s holistic, age-appropriate curriculum, which focuses on children’s spiritual, intellectual, socio-emotional and physical development."
    let compassionchilddevelopmentcenter = "Child development centers provide registered children with a place to learn, grow and study.\n\nChildren whose families have never been able to offer them clean water, health care or an education now have access to these necessities.\n\nCompassion-assisted children attend health classes, tutoring sessions and Bible studies at the center.\n\nThey also spend time writing to and praying for their sponsors."

    let howcompassionworksArray = ["Compassion began working in Burkina Faso in 2004.", "Currently more than 56,000 children are registered in 221 child development centers.", "Most children attend the center for 8 hours per week.", "Burkina Faso also has 401 mothers and their babies served through the Child Survival Program."]
      let childrenathomeArray = ["Although many urban homes are relatively modernized with electricity and running water, urban poor have little access to these amenities.", "The disparity between the rich and the poor is no more evident than in the cities of Burkina Faso.", "Extended family is very important to the Burkinabe. It is not uncommon for three or more generations to live under one roof."]
    let economyArray = ["In Burkino Faso, about 44 percent of the urban population lives below the poverty line. It is one of the poorest countries in the world.", "With few natural resources the Burkinabe are forced to travel to neighboring countries for seasonal agricultural work and to labor in mines and on plantations."]
    let geographyandclimateArray = ["Burkina Faso is a landlocked country in western Africa.", "The three primary rivers are the Nazinon, the Nakambé and the Mouhoun.", "The climate is tropical, with warm, dry winters and hot, rainy summers."]
    let issuesandconcernsArray = ["In 2009, Ouagadougou was hit by severe flooding, which forced 150,000 people out of their homes. Many families still live in ramshackle shelters in squatter camps on the city’s outskirts.", "Burkina Faso is in the midst of a polio outbreak. Despite aggressive vaccination campaigns, Burkina Faso hosts an unusually contagious strain of the virus.", "Chronic malnutrition is one of the most pervasive health concerns for Burkina Faso children.", "Urban Burkina Faso medical centers are flooded with cases of malnutrition, particularly near the end of the growing season, when food is most scarce and farmers are waiting for harvest." ]
    let localneedsandchallengesArray = ["Persistent drought -\n This serious problem affects most of the crops, and food supplies have been devastated.", "Malnutrition - Compassion centers throughout Burkina Faso report cases of malnutrition among children, especially around the capital city of Ouagadougou.", "Unemployment - Many people in the capital are unemployed because so many have migrated there looking for work.", "Other challenges - Child trafficking is a huge threat. Malaria and meningitis are serious health concerns. Housing is typically inadequate. Children’s school fees are often too costly for many parents."]
    let schoolsandeducationArray = ["Not many Burkinabe receive a formal education. Only about 30 percent of the adult population can read or write.", "Only about one-third of Burkina Faso children are enrolled in elementary school. Most schools are in cities.", "Some tribal practices bar children, particularly girls, from school. Girls under 15 are frequently forced into early marriage and out of the school system.", "Pervasive poverty also dictates that children work, sometimes performing grueling labor in mines, rather than attend school."]
    let whatcompassionsponsorshipprovidesArray = ["regular nutritious meals and snacks", "health checkups and medical care as needed", "education reinforcement, especially for girls. Compassion believes that a child’s place is in a classroom, where he or she can prepare for a better future rather than laboring to help meet their families’ financial needs.", "programs to help partner churches actively combat all forms of abuse and exploitation of children for commercial or economic purposes", "school tuition, which eases parents’ economic burden and ensures children’s education and the promise of a brighter future", "parent education, including training in income-generating activities that will enable them to better meet the needs of their families"]
  
    
    // MARK: - Setup and tear down
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        super.tearDown()
        
    }
    
    
    
    // MARK: - Tests
    
    func testInit_ValidObjectStage() {
        
        
        CASConfiguration.shared.buildConfiguration = .staging
        ConnectionKeyManager.shared.addKey(name: GetRegion.apiKeyNameStage, key: "xx", version: 1, override: true)
        expectation = self.expectation(description: "pass \(#function)")
        
        sut = GetRegion(regionCode: "BF0100", delegate: self)
        
        
        var expecteddailylife = GetRegionResult.GetRegionItem ()
        var expectedcommunity = GetRegionResult.GetRegionItem ()
        var expectededucationregion = GetRegionResult.GetRegionItem ()
        var expectedcompassionregion = GetRegionResult.GetRegionItem ()
        
        
        expecteddailylife.UUID = UUID
        expecteddailylife.image = dailyLifeImage
        expecteddailylife.childrenathomeArray = childrenathomeArray
        expecteddailylife.economyArray = economyArray
        expecteddailylife.geographyandclimateArray = geographyandclimateArray
        
        expectedcommunity.UUID = UUID
        expectedcommunity.image = communityImage
        expectedcommunity.issuesandconcernsArray = issuesandconcernsArray
        expectedcommunity.localneedsandchallengesArray = localneedsandchallengesArray
        
        expectededucationregion.UUID = UUID
        expectededucationregion.image = educationregionImage
        expectededucationregion.compassionchilddevelopmentcenter = compassionchilddevelopmentcenter
        expectededucationregion.schoolsandeducationArray = schoolsandeducationArray
        expectededucationregion.whatcompassionsponsorshipprovidesArray = whatcompassionsponsorshipprovidesArray
        
        expectedcompassionregion.UUID = UUID
        expectedcompassionregion.image = compassionregionImage
        expectedcompassionregion.howcompassionworksArray = howcompassionworksArray
        expectedcompassionregion.workingthroughthelocalchurch = workingthroughthelocalchurch
        
        
        var expecteddailylifeList = [GetRegionResult.GetRegionItem ()]
        var expectedcommunityList = [GetRegionResult.GetRegionItem ()]
        var expectededucationregionList = [GetRegionResult.GetRegionItem ()]
        var expectedcompassionregionList = [GetRegionResult.GetRegionItem ()]
        
        
        
        
        expecteddailylifeList.insert(expecteddailylife, at: 0)
        expectedcommunityList.insert(expectedcommunity, at: 0)
        expectededucationregionList.insert(expectededucationregion, at: 0)
        expectedcompassionregionList.insert(expectedcompassionregion, at: 0)
        
        
        waitForExpectations(timeout: asyncTimeout, handler: nil)
        
        
        // If execution got here, self.result is definitely nil. The test should fail.
        XCTAssertNotNil(self.result, "Result should equal the defined expected result, not nil.)")
      
        XCTAssertEqual(self.result.countryDisplay, countryDisplay, "countryDisplay should be equal")
        XCTAssertEqual(self.result.regionCode, regionCode, "regionCode should be equal")
        
        XCTAssertEqual(self.result.dailylifeList?[0].UUID, expecteddailylifeList[0].UUID, "daily life UUID should be equal")
        XCTAssertEqual(self.result.dailylifeList?[0].image, expecteddailylifeList[0].image, "daily life image should be equal")
        XCTAssertEqual((self.result.dailylifeList?[0].childrenathomeArray)!, expecteddailylifeList[0].childrenathomeArray!, "daily life result should be equal")
        XCTAssertEqual((self.result.dailylifeList?[0].economyArray)!, expecteddailylifeList[0].economyArray!, "daily life result should be equal")
        XCTAssertEqual((self.result.dailylifeList?[0].geographyandclimateArray)!, expecteddailylifeList[0].geographyandclimateArray!, "daily life result should be equal")
        XCTAssertEqual(self.result.communityList?[0].UUID, expectedcommunityList[0].UUID, "community UUID should be equal")
        XCTAssertEqual(self.result.communityList?[0].image, expectedcommunityList[0].image, "community image should be equal")
        XCTAssertEqual((self.result.communityList?[0].issuesandconcernsArray)!, expectedcommunityList[0].issuesandconcernsArray!, "community result should be equal")
        XCTAssertEqual((self.result.communityList?[0].localneedsandchallengesArray)!, expectedcommunityList[0].localneedsandchallengesArray!, "community result should be equal")
        XCTAssertEqual(self.result.educationregionList?[0].UUID, expectededucationregionList[0].UUID, "educationregion UUID should be equal")
        XCTAssertEqual(self.result.educationregionList?[0].image, expectededucationregionList[0].image, "educationregion image should be equal")
        XCTAssertEqual(self.result.educationregionList?[0].compassionchilddevelopmentcenter, expectededucationregionList[0].compassionchilddevelopmentcenter, "educationregion result should be equal")
        XCTAssertEqual((self.result.educationregionList?[0].schoolsandeducationArray)!, expectededucationregionList[0].schoolsandeducationArray!, "educationregion result should be equal")
        XCTAssertEqual((self.result.educationregionList?[0].whatcompassionsponsorshipprovidesArray)!, expectededucationregionList[0].whatcompassionsponsorshipprovidesArray!, "educationregion result should be equal")
        XCTAssertEqual(self.result.compassionregionList?[0].UUID, expectedcompassionregionList[0].UUID, "compassionregion UUID should be equal")
        XCTAssertEqual(self.result.compassionregionList?[0].image, expectedcompassionregionList[0].image, "compassionregion UUID should be equal")
        XCTAssertEqual((self.result.compassionregionList?[0].howcompassionworksArray)!, expectedcompassionregionList[0].howcompassionworksArray!, "compassionregion UUID should be equal")
        XCTAssertEqual(self.result.compassionregionList?[0].workingthroughthelocalchurch, expectedcompassionregionList[0].workingthroughthelocalchurch, "compassionregion UUID should be equal")
        
        
        
        
        
    }
    
    func testInit_ValidObjectProd() {
        let RegionCode = "urbanBF"
        
        CASConfiguration.shared.buildConfiguration = .production
        ConnectionKeyManager.shared.addKey(name: GetRegion.apiKeyNameProd, key: "xx", version: 1, override: true)
        expectation = self.expectation(description: "pass \(#function)")
        
        sut = GetRegion(regionCode: "BF0100", delegate: self)
        
        waitForExpectations(timeout: asyncTimeout, handler: nil)
        
        guard let result = self.result else { XCTFail("Result is Nil"); return }
        
        
        XCTAssertEqual(result.regionCode, RegionCode, "Valid init - beneficiary global IDs should be equal.")
        
    }
    
    func testInit_NoKeySet() {
        expectation = self.expectation(description: "pass \(#function)")
        
        // Ensure the API key name is invalid, thus simulating no API key.
        sut = GetRegion(regionCode: "BF0100", delegate: self, apiKeyName: "not_a_valid_key_name")
        
        waitForExpectations(timeout: asyncTimeout, handler: nil)
        
        XCTAssertNil(result, "No API key set - should be nil.")
        
    }
    
    func testInit_ValidObjectNoNameStage() {
        
        let RegionCode = "urbanBF"
        
        CASConfiguration.shared.buildConfiguration = .staging
        ConnectionKeyManager.shared.addKey(name: GetRegion.apiKeyNameStage, key: "xx", version: 1, override: true)
        expectation = self.expectation(description: "pass \(#function)")
        
        sut = GetRegion(regionCode: "BF0100", delegate: self)
        
        waitForExpectations(timeout: asyncTimeout, handler: nil)
        
        guard let result = self.result else { XCTFail("Result is Nil"); return }
        
        XCTAssertEqual(result.regionCode, RegionCode, "Valid init - beneficiary global IDs should be equal.")
        
    }
    
    
    // MARK: - GetRegionDelegate
    
    func getRegionComplete(_ sender: GetRegion, result: GetRegionResult?) {
        print("Complete")
        self.result = result
        
        expectation.fulfill()
    }
    
    func getRegionFailed(_ sender: GetRegion, response: HTTPURLResponse?) {
        print("Failed")
        self.result = nil
        self.response = response
        
        expectation.fulfill()
    }
}
