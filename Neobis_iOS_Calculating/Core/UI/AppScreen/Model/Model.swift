//
//  Model.swift
//  Neobis_iOS_Calculating
//
//  Created by G G on 14.04.2023.
//

import Foundation
import UIKit

struct ButtonModel {
    let imageName: String
    let backgroundColor: UIColor
    let foregroundColor: UIColor
    let operation: Operations?
    let value: String?
}


enum Data {
    static let arrayOfButtons = [
        ButtonModel(imageName: "", backgroundColor: .darkGray, foregroundColor: .white, operation: .empty, value: "0"),
        ButtonModel(imageName: "", backgroundColor: .darkGray, foregroundColor: .white, operation: .empty, value: ","),
        ButtonModel(imageName: "", backgroundColor: .orange, foregroundColor: .white, operation: .calculate, value: "="),
        ButtonModel(imageName: "", backgroundColor: .darkGray, foregroundColor: .white, operation: .empty, value: "1"),
        ButtonModel(imageName: "", backgroundColor: .darkGray, foregroundColor: .white, operation: .empty, value: "2"),
        ButtonModel(imageName: "", backgroundColor: .darkGray, foregroundColor: .white, operation: .empty, value: "3"),
        ButtonModel(imageName: "plus", backgroundColor: .orange, foregroundColor: .white, operation: .addition, value: ""),
        ButtonModel(imageName: "", backgroundColor: .darkGray, foregroundColor: .white, operation: .empty, value: "4"),
        ButtonModel(imageName: "", backgroundColor: .darkGray, foregroundColor: .white, operation: .empty, value: "5"),
        ButtonModel(imageName: "", backgroundColor: .darkGray, foregroundColor: .white, operation: .empty, value: "6"),
        ButtonModel(imageName: "minus", backgroundColor: .orange, foregroundColor: .white, operation: .substraction, value: ""),
        ButtonModel(imageName: "", backgroundColor: .darkGray, foregroundColor: .white, operation: .empty, value: "7"),
        ButtonModel(imageName: "", backgroundColor: .darkGray, foregroundColor: .white, operation: .empty, value: "8"),
        ButtonModel(imageName: "", backgroundColor: .darkGray, foregroundColor: .white, operation: .empty, value: "9"),
        ButtonModel(imageName: "multiply", backgroundColor: .orange, foregroundColor: .white, operation: .multiplication, value: ""),
        ButtonModel(imageName: "", backgroundColor: .systemGray2, foregroundColor: .black, operation: .reset, value: "AC"),
        ButtonModel(imageName: "plus.forwardslash.minus", backgroundColor: .systemGray2, foregroundColor: .black, operation: .negative, value: ""),
        ButtonModel(imageName: "percent", backgroundColor: .systemGray2, foregroundColor: .black, operation: .percent, value: ""),
        ButtonModel(imageName: "divide", backgroundColor: .orange, foregroundColor: .white, operation: .division, value: ""),
    ]
    
    
}


