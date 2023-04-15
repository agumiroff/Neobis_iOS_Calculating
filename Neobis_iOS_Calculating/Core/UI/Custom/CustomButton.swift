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
        attributedTitle.addAttribute(.font, value: UIFont(name: "Helvetica-Bold", size: 30) as Any, range: NSMakeRange(0, attributedTitle.length))
        self.setAttributedTitle(attributedTitle, for: .normal)
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = buttonColor
        configuration.baseForegroundColor = textColor
        configuration.cornerStyle = .capsule
        configuration.image = UIImage(systemName: imageName)
        configuration.preferredSymbolConfigurationForImage = .init(font: UIFont(name: "Helvetica-Bold", size: 30)!, scale: .default)
        self.configuration = configuration
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
