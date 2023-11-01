//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by chirag arora on 26/05/23.
//

import XCTest
@testable import Calculator

final class MathEquationTests: XCTestCase {

    

    func testAddition() throws {
        var mathEquation = MathEquation(lhs: .zero)
        mathEquation.lhs = 4
        mathEquation.operation = .add
        mathEquation.rhs = 4
        mathEquation.execute()
        
        let expectedResult = Decimal(8)
        XCTAssertTrue(mathEquation.result?.isEqual(to: expectedResult) ?? false) // default value is false
    }

    func testSubtraction() throws {
        var mathEquation = MathEquation(lhs: .zero)
        mathEquation.lhs = 4
        mathEquation.operation = .subtract
        mathEquation.rhs = 4
        mathEquation.execute()
        
        let expectedResult = Decimal(0)
        XCTAssertTrue(mathEquation.result?.isEqual(to: expectedResult) ?? false) // default value is false
    }

    func testMultiplication() throws {
        var mathEquation = MathEquation(lhs: .zero)
        mathEquation.lhs = 4
        mathEquation.operation = .multiply
        mathEquation.rhs = 4
        mathEquation.execute()
        
        let expectedResult = Decimal(16)
        XCTAssertTrue(mathEquation.result?.isEqual(to: expectedResult) ?? false) // default value is false
    }

    func testDivision() throws {
        var mathEquation = MathEquation(lhs: .zero)
        mathEquation.lhs = 4
        mathEquation.operation = .divide
        mathEquation.rhs = 4
        mathEquation.execute()
        
        let expectedResult = Decimal(1)
        XCTAssertTrue(mathEquation.result?.isEqual(to: expectedResult) ?? false) // default value is false
    }

    
    

}
