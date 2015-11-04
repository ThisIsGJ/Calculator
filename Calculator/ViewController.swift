//
//  ViewController.swift
//  Calculator
//
//  Created by zyj0115 on 15/6/19.
//  Copyright © 2015年 JunGuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var displayHistory: UILabel!
    
    var userIsInTheMiddleOfTypingANumber: Bool = false
    var haveDot = false
    var brain = CalculatorBrain()
    var showHistory = [String]()
    
    @IBAction func appendDigit(sender: UIButton) {

        let digit = sender.currentTitle!
        displayHistory.text = displayHistory.text! + digit
        if(digit != "." || !haveDot){
            if(digit == ".") {haveDot = true}
            if userIsInTheMiddleOfTypingANumber {
                display.text = display.text! + digit
            } else {
                display.text = digit
                userIsInTheMiddleOfTypingANumber = true
            }
        }
      
    }

    
    @IBAction func operate(sender: UIButton) {
       
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            displayHistory.text = displayHistory.text! + operation
            if(operation == "C"){
                displayHistory.text = "0"
                display.text = "0"
                userIsInTheMiddleOfTypingANumber = false
                haveDot = false
                brain.opStack.removeAll()
            }else{
                if let result = brain.performOPeration(operation){
                    displayValue = result
                }else{
                    displayValue = 0
                }
            }
        }
        
    }

    
    @IBAction func enter() {
        if(haveDot){haveDot = false}
        userIsInTheMiddleOfTypingANumber = false
        if let result = brain.pushOperand(displayValue){
            displayValue = result
        }else{
            displayValue = 0
        }
    }
    
    var displayValue: Double{
        get {
            if(display.text == "π"){display.text = "\(M_PI)"}
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
        
    }
    
    
    
}

