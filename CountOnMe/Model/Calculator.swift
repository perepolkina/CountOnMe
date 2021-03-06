//
//  Calculator.swift
//  CountOnMe
//
//  Created by Halyna on 26/06/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculator {
    
    // Error check computed variables
    func expressionIsCorrect(elements: [String]) -> Bool {
        return elements.last != "+" && elements.last != "-"
            && elements.last != "*" && elements.last != "/"
    }
    
    func expressionHaveEnoughElement(elements: [String]) -> Bool  {
        return elements.count >= 3
    }
    
    func canAddOperator(elements: [String]) -> Bool  {
        return elements.last != "+" && elements.last != "-"
            && elements.last != "*" && elements.last != "/"
    }
    
    func firstElementIsEmpty(elements: [String]) -> Bool {
        return elements.isEmpty
    }
    
    func divisionByZero(number: String,elements: [String]) -> Bool  {
        return elements[elements.count-1] == "/" && number == "0"
    }
    
    func mathPriority(elements: [String]) -> String {
        // Connect all elements to one string -> "2+2*2-2/2"
        var newExpression = elements.joined()
        
        // convert string to next computation -> (2 + (2 * 2)) - (2 / 2)
        let expr =  NSExpression(format: newExpression)
        // take result NSExpression -> 5
        if let result = expr.toFloatingPoint().expressionValue(with: nil, context: nil) as? Double {
            newExpression = removeZeroFromDecimal(number: result)
        }
        return newExpression
    }
    
    // remove a decimal from a float if the decimal is equal to 0?
    func removeZeroFromDecimal (number: Double) -> String {
        return String(format: "%g", number)
    }
}
    
    // change format to Float
    extension NSExpression {
        func toFloatingPoint() -> NSExpression {
            switch expressionType {
            case .constantValue:
                if let value = constantValue as? NSNumber {
                    return NSExpression(forConstantValue: NSNumber(value: value.doubleValue))
                }
            case .function:
                let newArgs = arguments.map { $0.map { $0.toFloatingPoint() } }
                return NSExpression(forFunction: operand, selectorName: function, arguments: newArgs)
            default:
                print("erreur")// break
            }
            return self
        }
    }
