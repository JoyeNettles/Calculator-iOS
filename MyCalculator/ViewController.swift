//
//  ViewController.swift
//  MyCalculator
//
//  Created by Joye Nettles on 7/26/16.
//  Copyright © 2016 Joye to the World. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    
    private var userIsTyping: Bool = false
    
    private var decimalIsPresent: Bool = false
    
    // Will make setting the value in the display label easier because we
    // don't have to worry about making it a string
    private var displayValue:Double{
        get{
            return Double(displayLabel.text!)!
        }
        set{
            displayLabel.text = String(newValue)
        }
    }
    
    @IBAction private func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsTyping{
            let currentText = displayLabel.text!
            displayLabel.text = currentText + digit
        }else{
            displayLabel.text = sender.currentTitle!
        }
        
        userIsTyping = true
    }
    
    @IBAction func clearDisplay(sender: UIButton) {
        displayLabel.text = "0"
        brain.setOperand(0.0)
        resetDefaults()
    }
    
    
    @IBAction private func touchDecimal(sender: UIButton) {
        if userIsTyping{
            if !decimalIsPresent{
                let currentText = displayLabel.text!
                displayLabel.text = currentText + "."
                decimalIsPresent = true
            }
        }else{
            displayLabel.text = "0."
            userIsTyping = true
            decimalIsPresent = true
        }
        
    }
    
    
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(sender: UIButton) {
        // Gives brain what has already been typed
        if(userIsTyping){
            brain.setOperand(displayValue)
            resetDefaults()
        }
        
        // Send brain what it will need to calculate
        if let symbol = sender.currentTitle{
            brain.performOperation(symbol)
        }
        
        // Display result of operation
        displayValue = brain.result
    }
    
    private func resetDefaults(){
        userIsTyping = false
        decimalIsPresent = false
    }
    
}

