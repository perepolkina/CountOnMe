//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    var calculator = Calculator()
    
    var elements: [String] {
        return textView.text.split(separator: " ").map { "\($0)" }
    }
    
    var expressionHaveResult: Bool {
        return textView.text.firstIndex(of: "=") != nil
    }
    
    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        if expressionHaveResult {
            textView.text = ""
        }
        
        if elements.count > 1 && calculator.divisionByZero(number: numberText,elements: elements) {
            alertMessage("You cannot divide by zero")
        } else {
            textView.text.append(numberText)
        }
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            threeAlerts(" + ")
        case 2:
            threeAlerts(" - ")
        case 3:
            threeAlerts(" * ")
        case 4:
            threeAlerts(" / ")
        default:
            print("erreur")
        }
    }
    
    @IBAction func tappedACButton(_ sender: Any) {
        textView.text.removeAll()
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        if calculator.expressionIsCorrect(elements: elements) && !elements.contains("="){
            textView.text.append(" = \(calculator.mathPriority(elements: elements))")
        } else {
            alertMessage("Start a new calculation")
        }
    }
    
    func alertMessage(_ message: String) {
        let alertVC = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func threeAlerts(_ element: String) {
        if  calculator.firstElementIsEmpty(elements: elements) {
            alertMessage("Enter number !")
        } else if calculator.canAddOperator(elements: elements) && !elements.contains("="){
            textView.text.append(element)
        } else if calculator.canAddOperator(elements: elements) && elements.contains("="){
            alertMessage("Start a new calculation !")
        } else  {
            alertMessage("An operator is already used !")
        }
    }
}


