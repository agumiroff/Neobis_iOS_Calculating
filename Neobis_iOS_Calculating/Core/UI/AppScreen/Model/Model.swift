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
            if roundedResult > 1 {
                self.roundedResult = Double(round(newValue * 1000) / 1000)
            } else {
                self.roundedResult = Double(round(newValue * 1000000) / 1000000)
            }
        }
    }
    var value: Double
    var operation: Operations
}
