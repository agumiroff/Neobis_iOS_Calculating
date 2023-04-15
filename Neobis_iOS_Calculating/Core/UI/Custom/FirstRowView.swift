//
//  FirstRowView.swift
//  Neobis_iOS_Calculating
//
//  Created by G G on 15.04.2023.
//

import Foundation
import UIKit


class FirstRowView: UIView {
    
    var zeroButton = CustomButton(imageName: Data.arrayOfButtons[0].imageName,
                                  buttonColor: Data.arrayOfButtons[0].backgroundColor,
                                  textColor: Data.arrayOfButtons[0].foregroundColor,
                                  operation: Data.arrayOfButtons[0].operation ?? .empty,
                                  value: "")
    
    var commaButton = CustomButton(imageName: Data.arrayOfButtons[1].imageName,
                                   buttonColor: Data.arrayOfButtons[1].backgroundColor,
                                   textColor: Data.arrayOfButtons[1].foregroundColor,
                                   operation: Data.arrayOfButtons[1].operation ?? .empty,
                                   value: Data.arrayOfButtons[1].value ?? "")
    
    var calculateButton = CustomButton(imageName: Data.arrayOfButtons[2].imageName,
                                       buttonColor: Data.arrayOfButtons[2].backgroundColor,
                                       textColor: Data.arrayOfButtons[2].foregroundColor,
                                       operation: Data.arrayOfButtons[2].operation ?? .empty,
                                       value: Data.arrayOfButtons[2].value ?? "")
    
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 30)
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    init() {
        super.init(frame: CGRect())
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(zeroButton)
        addSubview(commaButton)
        addSubview(calculateButton)
        
        zeroButton.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(Constraints.screenWidth * 0.25 - 5)
        }
        
        zeroButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(5)
            make.width.equalTo(Constraints.screenWidth * 0.5 - 5)
            make.height.equalTo(Constraints.screenWidth * 0.25 - 5)
        }
        
        commaButton.snp.makeConstraints { make in
            make.left.equalTo(zeroButton.snp.right).offset(5)
            make.width.height.equalTo(Constraints.screenWidth * 0.25 - 5)
        }
        
        calculateButton.snp.makeConstraints { make in
            make.left.equalTo(commaButton.snp.right).offset(5)
            make.width.height.equalTo(Constraints.screenWidth * 0.25 - 5)
        }
    }
    
}
