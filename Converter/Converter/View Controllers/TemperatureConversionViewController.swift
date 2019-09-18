//
//  SecondViewController.swift
//  Converter
//
//  Created by shakil on 14/03/19.
//  Copyright © 2019 shakil. All rights reserved.
//

import UIKit

class TemperatureConversionViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var celsiusTextField: UITextField! {
        didSet {
            celsiusTextField.delegate = self
        }
    }
    @IBOutlet weak var fahrenheitTextField: UITextField! {
        didSet {
            fahrenheitTextField.delegate = self
        }
    }
    @IBOutlet weak var kelvinTextField: UITextField! {
        didSet {
            kelvinTextField.delegate = self
        }
    }
    
    var currentConversion: String?
    var currentTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keyboardView = KeyboardView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: (self.view.frame.height)/3))
        keyboardView.delegate = self
        
        celsiusTextField.inputView = keyboardView
        fahrenheitTextField.inputView = keyboardView
        kelvinTextField.inputView = keyboardView
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        currentTextField.resignFirstResponder()
    }

    fileprivate func storeNewRecord(_ record: String) {
        if var conversions = UserDefaults.standard.stringArray(forKey: "temperature") {
            if conversions.count < 5 {
                conversions.append(record)
            } else {
                conversions.removeFirst()
                conversions.append(record)
            }
            UserDefaults.standard.set(conversions, forKey: "temperature")
        } else {
            UserDefaults.standard.set([record], forKey: "temperature")
        }
    }
    
    func celsiusTextFieldChanged(with text: String?) {
        if let text = text, let value = Double(text) {
            let celsius = Measurement(value: value, unit: UnitTemperature.celsius)
            let kelvin = celsius.converted(to: .kelvin).value.roundToDecimal(4)
            let fahrenheit = celsius.converted(to: .fahrenheit).value.roundToDecimal(4)
            fahrenheitTextField.text = "\(fahrenheit)"
            kelvinTextField.text = "\(kelvin)"
            celsiusTextField.text = text
            
            currentConversion = "\(celsius.value.roundToDecimal(4)) celsius = \(fahrenheit) fahrenheit = \(kelvin) kelvin"
        }
    }
    
    func fahrenheitTextFieldChanged(with text: String?) {
        if let text = text, let value = Double(text) {
            let fahrenheit = Measurement(value: value, unit: UnitTemperature.fahrenheit)
            let celsius = fahrenheit.converted(to: .celsius).value.roundToDecimal(4)
            let kelvin = fahrenheit.converted(to: .kelvin).value.roundToDecimal(4)
            celsiusTextField.text = "\(celsius)"
            kelvinTextField.text = "\(kelvin)"
            fahrenheitTextField.text = text
            
            currentConversion = "\(fahrenheit.value.roundToDecimal(4)) fahrenheit = \(celsius) celsius = \(kelvin) kelvin"
        }
    }
    
    func kelvinFieldChanged(with text: String?) {
        if let text = text, let value = Double(text) {
            let kelvin = Measurement(value: value, unit: UnitTemperature.kelvin)
            let celsius = kelvin.converted(to: .celsius).value.roundToDecimal(4)
            let fahrenheit = kelvin.converted(to: .fahrenheit).value.roundToDecimal(4)
            fahrenheitTextField.text = "\(fahrenheit)"
            celsiusTextField.text = "\(celsius)"
            kelvinTextField.text = text
            
            currentConversion = "\(kelvin.value.roundToDecimal(4)) kelvin = \(celsius) celsius = \(kelvin) kelvin"
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        var alert: UIAlertController!
        if let record = currentConversion {
            storeNewRecord(record)
            alert = UIAlertController.init(title: "", message: "New record saved", preferredStyle: .alert)
        } else {
            alert = UIAlertController.init(title: "", message: "No new record to save", preferredStyle: .alert)
        }
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "History" {
            if let viewcontroller = segue.destination as? HistoryViewController, let records = UserDefaults.standard.stringArray(forKey: "temperature") {
                viewcontroller.history = records
                viewcontroller.titleString = "Temperature History"
            }
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        fahrenheitTextField.text = nil
        celsiusTextField.text = nil
        kelvinTextField.text = nil
        currentConversion = nil
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentTextField = textField
    }
}

extension TemperatureConversionViewController: KeyboardDelegate {
    
    func keyWasTapped(character: String) {
        var text = ""
        if let previousText = currentTextField.text {
            if character == "NEG" {
                text = "-" + previousText
            } else {
                text = previousText + character
            }
        } else {
            if character == "NEG" {
                text = "-"
            } else {
                text = character
            }
        }
        
        switch currentTextField {
        case celsiusTextField:
            celsiusTextFieldChanged(with: text)
        case kelvinTextField:
            kelvinFieldChanged(with: text)
        case fahrenheitTextField:
            fahrenheitTextFieldChanged(with: text)
        default:
            break
        }
    }
    
    func backspaceWasTapped() {
        if var previousText = currentTextField.text {
            previousText.removeLast()
            switch currentTextField {
            case celsiusTextField:
                celsiusTextFieldChanged(with: previousText)
            case kelvinTextField:
                kelvinFieldChanged(with: previousText)
            case fahrenheitTextField:
                fahrenheitTextFieldChanged(with: previousText)
            default:
                break
            }
        }
    }
    
}
