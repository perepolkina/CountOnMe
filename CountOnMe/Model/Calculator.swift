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
    
    func divisionByZero(elements: [String]) -> Bool  {
        return elements[elements.count-2] == "/" && elements[elements.count-1] == "0"
    }
    
    func mathPriority(elements: [String]) -> String {
        print(elements)
        var newexpression = elements.joined()
        print(newexpression)
        let expr =  NSExpression(format: newexpression)
        print(expr)
        if let result = expr.toFloatingPoint().expressionValue(with: nil, context: nil) as? Double {
            print(result)
            newexpression = String(result)
        }
        return newexpression
    }
}

// change format to double Double
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
            print("erreur")
        }
        return self
    }
}


