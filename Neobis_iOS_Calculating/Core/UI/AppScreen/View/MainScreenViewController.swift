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
    // MARK: - Properties
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
    private var state: State = .initial
    private var calcModel = CalculatorModel(result: .nan, value: .nan, operation: .empty)
    private let row = FirstRowView()
    private lazy var buttons = [CustomButton]()
    private lazy var stacks = [UIView]()
    private lazy var index = 0
    private lazy var operation: Operations = .empty
    private lazy var cancellables = Set<AnyCancellable>()
    
    // MARK: - ViewDidLoad
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
    
    private func setupViews() {
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
    
    private func fillButtonsArray() {
        for index in 3..<Data.arrayOfButtons.count {
            let button = CustomButton(imageName: Data.arrayOfButtons[index].imageName,
                                      buttonColor: Data.arrayOfButtons[index].backgroundColor,
                                      textColor: Data.arrayOfButtons[index].foregroundColor,
                                      operation: Data.arrayOfButtons[index].operation ?? .empty,
                                      value: Data.arrayOfButtons[index].value ?? "")
            
            button.snp.makeConstraints { make in
                make.width.height.equalTo(Constraints.screenWidth * 0.25 - 5)
            }
            button.addTarget(self, action: #selector(buttonDidTap(sender: )), for: .touchUpInside)
            button.tag = index
            buttons.append(button)
        }
    }
    
    private func fillStackArray() {
        for _ in 1...5 {
            var subViews = [UIView]()
            if index + 4 <= buttons.count {
                subViews = Array(buttons[index..<index+4])
                index += 4
            } else {
                subViews = Array(buttons[index..<buttons.count])
            }
            
            let stack = CustomStackView(subViews: subViews,
                                        axis: .horizontal)
            stacks.append(stack)
        }
    }
    
    private func fillMainStack() {
        for index in 1...stacks.count {
            let stack = stacks[stacks.count - index]
            mainStack.addArrangedSubview(stack)
        }
        
        row.subviews.forEach { subview in
            (subview as? CustomButton)!
                .addTarget(self,
                           action: #selector(buttonDidTap(sender:)),
                           for: .touchUpInside)
        }
        
        mainStack.addArrangedSubview(row)
        row.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    private func blockButton(sender: CustomButton) {
        buttons.forEach { button in
            if button.operation == .addition ||
                button.operation == .division ||
                button.operation == .multiplication ||
                button.operation == .substraction {
                button.isEnabled = true
                button.backgroundColor = .orange
                button.tintColor = .white
            }
        }
        
        if sender.operation == .addition ||
            sender.operation == .division ||
            sender.operation == .multiplication ||
            sender.operation == .substraction {
            
            sender.isEnabled = false
            sender.backgroundColor = .white
            sender.tintColor = .black
        }
    }
    
    private func unblockAllButtons() {
        buttons.forEach { button in
            if button.operation == .addition ||
                button.operation == .division ||
                button.operation == .multiplication ||
                button.operation == .substraction {
                button.isEnabled = true
                button.backgroundColor = .orange
                button.tintColor = .white
            }
        }
    }
    
}
// MARK: - Business logic component
extension MainScreenViewController {
    
    @objc private func buttonDidTap(sender: CustomButton) {
        
        if sender.operation == .empty {
            textResult = state == .waitForNewValue ? sender.value : textResult + sender.value
            state = .waitForOperation
            unblockAllButtons()
        }
        
        if sender.operation != .empty {
            let value = Double(textResult) ?? 0
            switch sender.operation {
                
            case .reset:
                unblockAllButtons()
                calcModel.result = .nan
                calcModel.operation = .empty
                textResult = "0"
                state = .waitForNewValue
                
            case .negative:
                calcModel.result = value
                calculate(with: -1, operation: .multiplication)
                
            case .calculate:
                if state == .calculating {
                    calculate(with: calcModel.value,
                              operation: calcModel.operation)
                } else {
                    calcModel.value = value
                    unblockAllButtons()
                    calculate(with: calcModel.value, operation:
                                calcModel.operation)
                    state = .calculating
                }
                
            default:
                if state == .calculating {
                    state = .waitForNewValue
                }
                blockButton(sender: sender)
                
                if state == .waitForNewValue {
                    calcModel.operation = sender.operation
                    return
                }
                
                if calcModel.result.isNaN {
                    calcModel.result = value
                    calcModel.operation = sender.operation
                } else {
                    calculate(with: value, operation: calcModel.operation)
                    calcModel.operation = sender.operation
                }
                state = .waitForNewValue
            }
            
        }
    }
    
    private func calculate(with newValue: Double, operation: Operations) {
        
        switch operation {
        case .division:
            calcModel.result /= newValue
        case .multiplication:
            calcModel.result *= newValue
        case .substraction:
            calcModel.result -= newValue
        case .addition:
            calcModel.result += newValue
        case .percent:
            break
        default:
            break
        }
        textResult = String(calcModel.result)
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

enum State: Equatable {
    case initial
    case waitForNewValue
    case waitForOperation
    case calculating
}
