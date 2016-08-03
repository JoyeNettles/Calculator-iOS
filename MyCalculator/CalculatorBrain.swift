//
//  CalculatorBrain.swift
//  MyCalculator
//
//  Created by Joye Nettles on 7/26/16.
//  Copyright © 2016 Joye to the World. All rights reserved.
//

import Foundation

class CalculatorBrain{
    
    private var accumulator = 0.0
    
    func setOperand(operand: Double){
        accumulator = operand
        
    }
    
    private var operations: Dictionary<String, Operation>=[
        "π" : Operation.Constant(M_PI),
        "e" : Operation.Constant(M_E),
        "√" : Operation.UnaryOperation(sqrt),
        "abs" : Operation.UnaryOperation(abs),
        "sin" : Operation.UnaryOperation(sin),
        "cos" : Operation.UnaryOperation(cos),
        "tan" : Operation.UnaryOperation(tan),
        "sinh" : Operation.UnaryOperation(sinh),
        "cosh" : Operation.UnaryOperation(cosh),
        "tanh" : Operation.UnaryOperation(tanh),
        "%" : Operation.UnaryOperation({$0 * 0.01}),
        "±" : Operation.UnaryOperation({-$0}),
        "×" : Operation.BinaryOperation({$0 * $1}),
        "−" : Operation.BinaryOperation({$0 - $1}),
        "÷" : Operation.BinaryOperation({$0 / $1}),
        "+" : Operation.BinaryOperation({$0 + $1}),
        "=" : Operation.Equals
    ]

    
    enum Operation{
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    func performOperation(symbol: String){
        // look up the current operation in the dictionary
        // and if you find it then set the accumulator appropriately
        if let operation = operations[symbol]{
            switch operation{
            case .Constant(let value):
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }
        }
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    // Used to store our calc information until it is ready to finish
    struct PendingBinaryOperationInfo{
        var binaryFunction: ((Double, Double)-> Double)
        var firstOperand: Double
    }
    
    //constantly evaluate the functions without having to press equal
    private func executePendingBinaryOperation(){
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    // result of operation
    var result: Double{
        get{
            return accumulator
        }
    }
    
}