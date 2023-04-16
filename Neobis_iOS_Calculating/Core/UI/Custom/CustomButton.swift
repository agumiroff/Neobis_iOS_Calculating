//
//  CustomButton.swift
//  Neobis_iOS_Calculating
//
//  Created by G G on 14.04.2023.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    var operation: Operations
    var value: String
    
    init(imageName: String,
         buttonColor: UIColor,
         textColor: UIColor,
         operation: Operations,
         value: String) {
        self.operation = operation
        self.value = value
        super.init(frame: CGRect())
        
        self.setTitle(value, for: .normal)
        let attributedTitle = NSMutableAttributedString(string: value)
        let range = NSRange(location: 0, length: attributedTitle.length)
        attributedTitle.addAttribute(.font, value: UIFont(name: "Helvetica-Bold", size: 30) as Any, range: range)
        self.setAttributedTitle(attributedTitle, for: .normal)
        titleLabel?.textColor = textColor
        tintColor = textColor
        backgroundColor = buttonColor
        layer.cornerRadius = (Constraints.screenWidth * 0.25 - 5)/2
        
        let config = UIImage.SymbolConfiguration(font: UIFont(name: "Helvetica-Bold", size: 30)!)
        let image = UIImage(systemName: imageName, withConfiguration: config)
        setImage(image, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
