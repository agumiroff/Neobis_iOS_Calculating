//
//  Model.swift
//  Neobis_iOS_Calculating
//
//  Created by G G on 14.04.2023.
//

import Foundation

struct CalculatorModel {
    var roundedResult: Double
    var result: Double {
        get {
            return self.roundedResult
        }
        
        set {
            self.roundedResult = Double(round(newValue * 1000) / 1000)
        }
    }
    var value: Double
    var operation: Operations
}
