//
//  ViewController.swift
//  Neobis_iOS_Calculating
//
//  Created by G G on 14.04.2023.
//

import UIKit
import SnapKit
import Combine

class MainScreenViewController: UIViewController {
    // MARK: Properties
    private let mainStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.spacing = 5
        return stackView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Helvetica", size: 55)
        label.text = "FFF"
        return label
    }()
    
   
    @Published private var textResult = "0"
    private var result: Double = 0
    let row = FirstRowView()
    private var buttons = [UIView]()
    private var stacks = [UIView]()
    private var i = 0
    private var operation: Operations = .empty
    var cancellables = Set<AnyCancellable>()
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupViews()
        fillButtonsArray()
        fillStackArray()
        fillMainStack()
        
        $textResult
            .map { $0 }
            .assign(to: \.label.text, on: self)
            .store(in: &cancellables)
            
        
    }
    
    func setupViews() {
        view.addSubview(label)
        view.addSubview(mainStack)
        
        label.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.bottom.equalTo(mainStack.snp.top)
        }
        
        mainStack.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
    func fillButtonsArray() {
        for i in 3..<Data.arrayOfButtons.count {
            let button = CustomButton(imageName: Data.arrayOfButtons[i].imageName,
                                      buttonColor: Data.arrayOfButtons[i].backgroundColor,
                                      textColor: Data.arrayOfButtons[i].foregroundColor,
                                      operation: Data.arrayOfButtons[i].operation ?? .empty,
                                      value: Data.arrayOfButtons[i].value ?? "")
            
            button.snp.makeConstraints { make in
                make.width.height.equalTo(Constraints.screenWidth * 0.25 - 5)
            }
            button.addTarget(self, action: #selector(buttonDidTap(sender: )), for: .touchUpInside)
            buttons.append(button)
        }
    }
    
    func fillStackArray() {
        for _ in 1...5 {
            var subViews = [UIView]()
            if i+4 <= buttons.count {
                subViews = Array(buttons[i..<i+4])
                i += 4
            } else {
                subViews = Array(buttons[i..<buttons.count])
            }
            
            let stack = CustomStackView(subViews: subViews)
            stacks.append(stack)
        }
    }
    
    func fillMainStack() {
        for i in 1...stacks.count {
            let stack = stacks[stacks.count - i]
            mainStack.addArrangedSubview(stack)
        }
        
        mainStack.addArrangedSubview(row)
        row.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    @objc func buttonDidTap(sender: CustomButton) {
        operation = sender.operation
        if operation != .empty {
            switch sender.operation {
            case .division:
                print("division")
            case .empty:
                print("empty")
            case .negative:
                textResult = String((Int(textResult) ?? 0) * -1)
            case .percent:
                print("percent")
            case .multiplication:
                print("multiplication")
            case .substraction:
                print("substraction")
            case .addition:
                if result > 0 {
                    result += Double(textResult) ?? 0
                } else {
                    result = textResult == "0" ? result : Double(textResult) ?? 0
                }
            case .reset:
                result = 0
            case .calculate:
                print("calculate")
            }
            self.textResult = String(result)
        } else {
            self.textResult = textResult == "0.0" ? sender.value : textResult + sender.value
        }
    }

}

enum Operations: Int {
    case empty
    case reset
    case negative
    case percent
    case division
    case multiplication
    case substraction
    case addition
    case calculate
}
