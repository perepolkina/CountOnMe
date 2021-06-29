//
//  CountOnMeTests.swift
//  CountOnMeTests
//
//  Created by Halyna on 28/06/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CountOnMeTests: XCTestCase {

    var calculator = Calculator()
    
    override func setUp() {
        super.setUp()
        calculator = Calculator()
    }

    func testGivenLastElementIsSign_WhenTestingExpressionIsCorrect_ThenItIsFalse() {
        XCTAssertFalse(calculator.expressionIsCorrect(elements: ["2", "2", "+"]))
        XCTAssertFalse(calculator.expressionIsCorrect(elements: ["2", "2", "-"]))
        XCTAssertFalse(calculator.expressionIsCorrect(elements: ["2", "2", "*"]))
        XCTAssertFalse(calculator.expressionIsCorrect(elements: ["2", "2", "/"]))
    }
    
    func testGivenHaveEnoughElement_WhenTestingExpressionIsCorrect_ThenItIsTrue() {
        
        XCTAssertTrue(calculator.expressionHaveEnoughElement(elements: ["2", "+", "2"]))
    }
   
    func testGivenHaveEnoughElement_WhenTestingExpressionIsCorrect_ThenItIsFalse() {
        
        XCTAssertFalse(calculator.expressionHaveEnoughElement(elements: ["2", "+"]))
    }
    
    func testGivenCanAddOperatorSign_WhenTestingExpressionIsCorrect_ThenItIsFalse() {
        
        XCTAssertFalse(calculator.canAddOperator(elements: ["2", "+"]))
        XCTAssertFalse(calculator.canAddOperator(elements: ["2", "+", "2", "-"]))
        XCTAssertFalse(calculator.canAddOperator(elements: ["2", "+", "2", "*"]))
        XCTAssertFalse(calculator.canAddOperator(elements: ["2", "+", "2", "/"]))
    }
    
    func testGivenfirstElementIsEmpty_WhenTestingExpressionIsCorrect_ThenItIsTrue() {
        XCTAssertTrue(calculator.firstElementIsEmpty(elements: []))
    }
    
    func testGivenDivisionByZero_WhenTestingExpressionIsCorrect_ThenItIsTrue() {
        XCTAssertTrue(calculator.divisionByZero(number: "0", elements: ["2", "-", "+", "2", "/"]))
    }
    
    func testGivenMathPriority_WhenTestingExpressionHasCorrectResult_ThenItIsCorrect() {
        XCTAssertEqual(calculator.mathPriority(elements: ["2", "+", "2", "/", "2"]), "3.0")
        XCTAssertEqual(calculator.mathPriority(elements: ["3", "+", "3", "*", "2"]), "9.0")
        XCTAssertEqual(calculator.mathPriority(elements: ["3", "+", "3", "*", "2", "-", "2", "/", "2"]), "8.0")
    }
}
