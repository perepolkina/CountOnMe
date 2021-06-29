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
        print(elements)//delete
        if expressionHaveResult {
            textView.text = ""
        }

        print(elements)//delete
        if elements.count > 1 && calculator.divisionByZero(number: numberText,elements: elements) {
        alertMassege("You cannot divide by zero") // !!!!change nom message
        } else {
            textView.text.append(numberText)
            print(elements)//delete
        }
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        twoAlert(" + ")
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        twoAlert(" - ")
    }

    @IBAction func tappedDivisionButton(_ sender: Any) {
        twoAlert(" / ")
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: Any) {
        twoAlert(" * ")
    }
  
    
    @IBAction func tappedACButton(_ sender: Any) {
        textView.text.removeAll()
    }
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        if calculator.expressionIsCorrect(elements: elements) && !elements.contains("="){
            textView.text.append(" = \(calculator.mathPriority(elements: elements))")
            print(elements)
            //textView.text.removeAll()
            print(elements)
        } else {
            alertMassege("Start a new calculation")
        }
    }

    func alertMassege(_ message: String) {
        let alertVC = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

    func twoAlert(_ element: String) {
        if  calculator.firstElementIsEmpty(elements: elements) {
            alertMassege("Enter number !")
        } else if calculator.canAddOperator(elements: elements) && !elements.contains("="){
            textView.text.append(element)
        } else if calculator.canAddOperator(elements: elements) && elements.contains("="){
            alertMassege("Start a new calculation !")
        } else  {
            alertMassege("An operator is already used !")
        }
    }
    
}

