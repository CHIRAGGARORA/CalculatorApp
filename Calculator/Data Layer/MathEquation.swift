//
//  MathEquation.swift
//  Calculator
//
//  Created by chirag arora on 01/06/23.
//

import Foundation


struct MathEquation {
    
    enum OperationType {
        case add
        case subtract
        case multiply
        case divide
    }
    
    var lhs: Decimal
    var rhs: Decimal?
    var operation: OperationType?
    var result: Decimal?
    
    // MARK: - Execution
    
    var executed: Bool {
        return result != nil
    }
    
    mutating func execute() {
       
        guard
            let rhs = self.rhs,
            let operation = self.operation else {
            return
        }
        
        switch operation {
        case .add:
            result = lhs + rhs
        case .subtract:
            result = lhs - rhs
        case .multiply:
            result = lhs * rhs
        case .divide:
            result = lhs / rhs
            
        
        }
              
        
    }
    
    // MARK: - Negate
    
    mutating func negateLeftHandSide() { // structs cannot change so mutating has to be used
        lhs.negate()
    }
    
    mutating func negateRightHandSide() {  // structs cannot change so mutating has to be used
        rhs?.negate()
    }
    
    // MARK: - Percentage
    
    mutating func applyPercentageToLeftHandSide() {
        lhs = calculatePercentageValue(lhs)
    }
    
    mutating func applyPercentageToRighttHandSide() {
        guard let decimal = rhs else { return }
        
        rhs = calculatePercentageValue(decimal )
    }
    
    private func calculatePercentageValue(_ decimal: Decimal) -> Decimal {
        return decimal/100
    }
    
    // MARK: - String Representation
    
    func generatePrintout() -> String {
        let operationString = generateStringRepresentationOfOperation()
        return lhs.formatted() + " " + operationString + " " + (rhs?.formatted() ?? "") + " = " + (result?.formatted() ?? "")
        
        
    }
    
    func generateStringRepresentationOfOperation() -> String {
        
        
        switch operation {
        case .add: return "+"
        case .subtract: return "-"
        case .multiply: return "*"
        case .divide: return "/"
            
        case .none:
            return ""
        }
    }
    
}
