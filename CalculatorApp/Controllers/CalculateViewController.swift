//
//  CalculateViewController.swift
//  CalculatorApp
//
//  Created by Muhammet Yiğit on 1.05.2025.
//

import UIKit

class CalculateViewController: UIViewController {
    
    // MARK: - UI Elements
    @IBOutlet var allButtons: [UIButton]!
    @IBOutlet weak var resultLabel: UILabel!
    
    // MARK: - Properties
    var isTypingFinish: Bool = true
    var currentOperation: String?
    var storedNumber: Double?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureButtonCorners(with: allButtons)
        resultLabel.text = "0"
    }
    
    // MARK: - Functions
    func configureButtonCorners(with buttons: [UIButton]) {
        for button in buttons {
            button.layer.cornerRadius = 35
            button.clipsToBounds = true
        }
    }
    
    func formatNumber(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 6
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: number)) ?? String(number)
    }
    
    func convertToDouble(_ text: String) -> Double? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.decimalSeparator = ","
        return formatter.number(from: text)?.doubleValue
    }
    
    func showZeroDivisionAlert() {
        let alert = UIAlertController(
            title: "Math Error",
            message: "You cannot divide a number by 0! Watch the video below for more information.",
            preferredStyle: .alert
        )
        
        let watchAction = UIAlertAction(title: "Watch the Video", style: .default) { _ in
            if let url = URL(string: "https://www.youtube.com/watch?v=NKmGVE85GUU") {
                UIApplication.shared.open(url)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Okay", style: .cancel)
        
        alert.addAction(watchAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
        
        resultLabel.text = "0"
        isTypingFinish = true
        storedNumber = nil
        currentOperation = nil
    }
    
    // MARK: - Actions
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        if sender.tag == 100 {
            if isTypingFinish {
                resultLabel.text = "0,"
                isTypingFinish = false
            } else if !(resultLabel.text?.contains(",") ?? false) {
                resultLabel.text! += ","
            }
            return
        }
        
        if isTypingFinish {
            resultLabel.text = String(sender.tag)
            isTypingFinish = false
        } else {
            resultLabel.text! += String(sender.tag)
        }
    }
    
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            resultLabel.text = "0"
            isTypingFinish = true
            storedNumber = nil
            currentOperation = nil
            
        case 1:
            if let current = convertToDouble(resultLabel.text!) {
                resultLabel.text = formatNumber(current * -1)
            }
            
        case 2:
            if let current = convertToDouble(resultLabel.text!) {
                resultLabel.text = formatNumber(current / 100)
            }
            
        case 3:
            storedNumber = convertToDouble(resultLabel.text!)
            currentOperation = "/"
            isTypingFinish = true
            
        case 4:
            storedNumber = convertToDouble(resultLabel.text!)
            currentOperation = "*"
            isTypingFinish = true
            
        case 5:
            storedNumber = convertToDouble(resultLabel.text!)
            currentOperation = "-"
            isTypingFinish = true
            
        case 6:
            storedNumber = convertToDouble(resultLabel.text!)
            currentOperation = "+"
            isTypingFinish = true
            
        case 7:
            if let operation = currentOperation,
               let firstNumber = storedNumber,
               let secondNumber = convertToDouble(resultLabel.text!) {
                
                var result: Double?
                
                switch operation {
                case "+": result = firstNumber + secondNumber
                case "-": result = firstNumber - secondNumber
                case "*": result = firstNumber * secondNumber
                case "/":
                    if secondNumber == 0 {
                        showZeroDivisionAlert()
                        return
                    } else {
                        result = firstNumber / secondNumber
                    }
                    
                default:
                    break
                }
                
                if let result = result {
                    resultLabel.text = formatNumber(result)
                    
                    let resultText = "\(firstNumber) \(operation) \(secondNumber) = \(result)"
                    
                    let resultModel = ResultModel(text: resultText)
                    ResultHistory.shared.resultHistoryArray.append(resultModel)
                }
                
                isTypingFinish = true
                storedNumber = nil
                currentOperation = nil
            }
            
        default:
            break
        }
        print(ResultHistory.shared.resultHistoryArray)
    }
}
