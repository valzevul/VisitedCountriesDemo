//
//  VisitedCountriesDemoUITests.swift
//  VisitedCountriesDemoUITests
//
//  Created by Vadim Drobinin on 26/6/15.
//  Copyright © 2015 Vadim Drobinin. All rights reserved.
//

import Foundation
import XCTest

class VisitedCountriesDemoUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        let app = XCUIApplication()
        app.tables.staticTexts["Евразия"].tap()
        app.navigationBars["List of countries"].buttons["Add"].tap()
        
        let textField = app.childrenMatchingType(.Window).elementAtIndex(0).childrenMatchingType(.Unknown).elementAtIndex(0).childrenMatchingType(.Unknown).elementAtIndex(0).childrenMatchingType(.Unknown).elementAtIndex(0).childrenMatchingType(.Unknown).elementAtIndex(0).childrenMatchingType(.Unknown).elementAtIndex(2).childrenMatchingType(.TextField).elementAtIndex(0)
        textField.typeText("Болгария")
        app.typeText("\n")
        
    }
    
    func testExample2() {
        let app = XCUIApplication()
        app.tables.staticTexts["Евразия"].tap()
        app.tables.staticTexts["Франция"].tap()
    }
    
    
}
