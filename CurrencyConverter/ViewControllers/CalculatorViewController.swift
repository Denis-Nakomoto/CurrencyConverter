//
//  CalculatorViewController.swift
//  CurrencyConverter
//
//  Created by Denis Svetlakov on 13.10.2020.

import UIKit

class CalculatorViewController: UIViewController {
    
    var valute: [String: Valute] = [:]
    var leftValueRate = 0.1
    var rightValueRate = 0.1
    var leftNominal = 1
    var rightNominal = 1
    
    @IBOutlet weak var rightTextField: UITextField!
    @IBOutlet weak var leftTextField: UITextField!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var activityIndicatior: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Конвертер валют"
        activityIndicatior.startAnimating()
        getCurrencies()
        leftTextField.delegate = self
        rightTextField.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let currencyVC = segue.destination as? CurrencySelectViewController
        currencyVC?.valute = valute
        if segue.identifier == "leftCurrency" {
            currencyVC?.isLeftCurrency = true
        } else {
            currencyVC?.isLeftCurrency = false
        }
    }
    
    private func getCurrencies() {
        NetworkService.shared.fetchData { (currencies) in
            if let valute = currencies.valute {
                self.valute = valute
                DispatchQueue.main.async {
                    self.activityIndicatior.stopAnimating()
                    self.activityIndicatior.hidesWhenStopped = true
                    self.leftValueRate = valute["BYN"]!.value!
                    self.rightValueRate = valute["USD"]!.value!
                }
            } else {
                print ("Error parsing currencies")
            }
        }
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) { }
}

extension CalculatorViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        leftTextField.resignFirstResponder()
        rightTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let gain = leftValueRate / rightValueRate
        if textField == leftTextField {
            rightTextField.text = String(format: "%.2f", (leftTextField.text?.doubleValue ?? 0.1) * gain / Double(leftNominal))
        } else {
            leftTextField.text = String(format: "%.2f", (rightTextField.text?.doubleValue ?? 0.1) * (1 / gain) / Double(rightNominal))
        }
    }
}

extension String {
    var doubleValue: Double {
        return Double(self) ?? 0.1
    }
}
