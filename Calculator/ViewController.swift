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

    @IBAction func appendDigit(sender: UIButton) {

        let digit = sender.currentTitle!
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
            displayHistory.text = displayHistory.text! + sender.currentTitle! + "->"
            switch operation{
            case "×": performOperation {$0 * $1}
            case "+": performOperation {$0 + $1}
            case "-": performOperation {$1 - $0}
            case "÷": performOperation {$1 / $0}
            case "√": performOperation2 {sqrt($0)}
            case "sin": performOperation2 {sin($0)}
            case "cos": performOperation2 {cos($0)}
            case "C": cleanAll()
            default: break
            }
        }
        
    }
    
    func cleanAll(){
        operandStack.removeAll()
        displayHistory.text = "0"
        display.text = "0"
        userIsInTheMiddleOfTypingANumber = false
        haveDot = false
        
    }
    
    func performOperation2(operation: Double ->Double){
        if operandStack.count >= 1{
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation(operation: (Double,Double) ->Double){
        if operandStack.count >= 2{
            displayValue = operation(operandStack.removeLast(),operandStack.removeLast())
            enter()
        }
       
    }
    
    
    var operandStack =  Array<Double>()
    
    @IBAction func enter() {
        if(haveDot){haveDot = false}
        userIsInTheMiddleOfTypingANumber = false
        operandStack.append(displayValue)
        displayHistory.text = displayHistory.text! + "\(displayValue)" + "->"
        print("operandStack = \(operandStack)")
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

