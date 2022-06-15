//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Chalmers Phua on 6/14/22.
//

import UIKit

class ViewController: UIViewController {
    var currencyManager = CurrencyManager()
    
    @IBOutlet weak var currencyZero: UILabel!
    @IBOutlet weak var currencyZeroTextField: UITextField!
    @IBOutlet weak var currencyOne: UILabel!
    @IBOutlet weak var currencyOneLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyManager.delegate = self
        currencyZeroTextField.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currencyManager.getConversion(currencyManager.currencyArray[row], component)
    }
}

extension ViewController: UITextFieldDelegate {
    @IBAction func convertButton(_ sender: UIButton) {
        currencyZeroTextField.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let amount = currencyZeroTextField.text {
            if Double(amount) != nil {
                currencyManager.amountToBeConverted(Double(amount)!)
            }
            currencyManager.performRequest()
        }
    }
}

extension ViewController: CurrencyManagerDelegate {
    func didUpdate(result: String) {
        DispatchQueue.main.async { [self] in
            currencyZero.text = currencyManager.currencyDictionary[currencyManager.componentZero]
            currencyOne.text = currencyManager.currencyDictionary[currencyManager.componentOne]
            currencyOneLabel.text = result
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
