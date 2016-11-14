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
      let tablesQuery = app.tables
      tablesQuery.staticTexts["Евразия"].tap()
      app.navigationBars["List of countries"].buttons["Add"].tap()
      
      let rKey = app.keys["r"]
      rKey.tap()
      rKey.tap()
      
      let eKey = app.keys["e"]
      eKey.tap()
      eKey.tap()
      
      let staticText = tablesQuery.staticTexts["Эстония"]
      staticText.tap()
      app.typeText("Gree")
      
      let greeceStaticText = tablesQuery.staticTexts["Greece"]
      greeceStaticText.tap()
      app.typeText("c")
      staticText.tap()
      app.typeText("e")
      app.otherElements.containing(.navigationBar, identifier:"List of countries").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .table).element.tap()
      app.typeText("\n")
      greeceStaticText.tap()
    }
    
    func testExample2() {
        let app = XCUIApplication()
        app.tables.staticTexts["Евразия"].tap()
        app.tables.staticTexts["Франция"].tap() // Fail
    }
    
    
}
