//
//  CustomStack.swift
//  Neobis_iOS_Calculating
//
//  Created by G G on 15.04.2023.
//

import Foundation
import UIKit

class CustomStackView: UIStackView {
    init(subViews: [UIView], axis: NSLayoutConstraint.Axis) {
        super.init(frame: CGRect())
        self.axis = axis
        self.distribution = .fillEqually
        self.spacing = 5
        subViews.forEach { view in
            self.addArrangedSubview(view)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
