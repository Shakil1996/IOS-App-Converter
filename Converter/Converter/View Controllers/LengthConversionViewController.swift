//
//  LengthConversionViewController.swift
//  Converter
//
//  Created by shakil on 14/03/19.
//  Copyright © 2019 shakil. All rights reserved.
//

import UIKit

class LengthConversionViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var meterTextField: UITextField! {
        didSet {
            meterTextField.delegate = self
        }
    }
    @IBOutlet weak var mileTextField: UITextField! {
        didSet {
            mileTextField.delegate = self
        }
    }
    @IBOutlet weak var cmTextField: UITextField! {
        didSet {
            cmTextField.delegate = self
        }
    }
    @IBOutlet weak var mmTextField: UITextField! {
        didSet {
            mmTextField.delegate = self
        }
    }
    @IBOutlet weak var yardTextField: UITextField! {
        didSet {
            yardTextField.delegate = self
        }
    }
    @IBOutlet weak var inchTextField: UITextField! {
        didSet {
            inchTextField.delegate = self
        }
    }
    
    var currentConversion: String?
    var currentTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keyboardView = KeyboardView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: (self.view.frame.height)/3))
        keyboardView.delegate = self
        
        meterTextField.inputView = keyboardView
        mileTextField.inputView = keyboardView
        cmTextField.inputView = keyboardView
        mmTextField.inputView = keyboardView
        yardTextField.inputView = keyboardView
        inchTextField.inputView = keyboardView
        
        keyboardView.negationButton.removeFromSuperview()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        currentTextField.resignFirstResponder()
    }
    
    fileprivate func storeNewRecord(_ record: String) {
        if var conversions = UserDefaults.standard.stringArray(forKey: "length") {
            if conversions.count < 5 {
                conversions.append(record)
            } else {
                conversions.removeFirst()
                conversions.append(record)
            }
            UserDefaults.standard.set(conversions, forKey: "length")
        } else {
            UserDefaults.standard.set([record], forKey: "length")
        }
    }
    
    func meterTextFieldChanged(with text: String?) {
        if let text = text, let value = Double(text) {
            let meters = Measurement(value: value, unit: UnitLength.meters)
            let miles = meters.converted(to: .miles).value.roundToDecimal(4)
            let centimeters = meters.converted(to: .centimeters).value.roundToDecimal(4)
            let millimeters = meters.converted(to: .millimeters).value.roundToDecimal(4)
            let yards = meters.converted(to: .yards).value.roundToDecimal(4)
            let inches = meters.converted(to: .inches).value.roundToDecimal(4)
            mileTextField.text = "\(miles)"
            cmTextField.text = "\(centimeters)"
            mmTextField.text = "\(millimeters)"
            yardTextField.text = "\(yards)"
            inchTextField.text = "\(inches)"
            meterTextField.text = text
            
            currentConversion = "\(meters.value.roundToDecimal(4)) meters = \(miles) miles = \(centimeters) centimeters = \(millimeters) millimeters = \(yards) yards = \(inches) inches"
        }
    }
    
    func mileTextFieldChanged(with text: String?) {
        if let text = text, let value = Double(text) {
            let miles = Measurement(value: value, unit: UnitLength.miles)
            let meters = miles.converted(to: .meters).value.roundToDecimal(4)
            let centimeters = miles.converted(to: .centimeters).value.roundToDecimal(4)
            let millimeters = miles.converted(to: .millimeters).value.roundToDecimal(4)
            let yards = miles.converted(to: .yards).value.roundToDecimal(4)
            let inches = miles.converted(to: .inches).value.roundToDecimal(4)
            meterTextField.text = "\(meters)"
            cmTextField.text = "\(centimeters)"
            mmTextField.text = "\(millimeters)"
            yardTextField.text = "\(yards)"
            inchTextField.text = "\(inches)"
            mileTextField.text = text

            currentConversion = "\(miles.value.roundToDecimal(4)) miles = \(meters) meters = \(centimeters) centimeters = \(millimeters) millimeters = \(yards) yards = \(inches) inches"
        }
    }
    
    func centimeterTextFieldChanged(with text: String?) {
        if let text = text, let value = Double(text) {
            let centimeters = Measurement(value: value, unit: UnitLength.centimeters)
            let meters = centimeters.converted(to: .meters).value.roundToDecimal(4)
            let miles = centimeters.converted(to: .miles).value.roundToDecimal(4)
            let millimeters = centimeters.converted(to: .millimeters).value.roundToDecimal(4)
            let yards = centimeters.converted(to: .yards).value.roundToDecimal(4)
            let inches = centimeters.converted(to: .inches).value.roundToDecimal(4)
            meterTextField.text = "\(meters)"
            mileTextField.text = "\(miles)"
            mmTextField.text = "\(millimeters)"
            yardTextField.text = "\(yards)"
            inchTextField.text = "\(inches)"
            cmTextField.text = text

            currentConversion = "\(centimeters.value.roundToDecimal(4)) centimeters = \(miles) miles = \(meters) meters = \(millimeters) millimeters = \(yards) yards = \(inches) inches"
        }
    }
    
    func millimeterTextFieldChanged(with text: String?) {
        if let text = text, let value = Double(text) {
            let millimeters = Measurement(value: value, unit: UnitLength.millimeters)
            let meters = millimeters.converted(to: .meters).value.roundToDecimal(4)
            let miles = millimeters.converted(to: .miles).value.roundToDecimal(4)
            let centimeters = millimeters.converted(to: .centimeters).value.roundToDecimal(4)
            let yards = millimeters.converted(to: .yards).value.roundToDecimal(4)
            let inches = millimeters.converted(to: .inches).value.roundToDecimal(4)
            meterTextField.text = "\(meters)"
            mileTextField.text = "\(miles)"
            cmTextField.text = "\(centimeters)"
            yardTextField.text = "\(yards)"
            inchTextField.text = "\(inches)"
            mmTextField.text = text

            currentConversion = "\(millimeters.value.roundToDecimal(4)) millimeters = \(miles) miles = \(centimeters) centimeters = \(meters) meters = \(yards) yards = \(inches) inches"
        }
    }
    
    func yardTextFieldChanged(with text: String?) {
        if let text = text, let value = Double(text) {
            let yards = Measurement(value: value, unit: UnitLength.yards)
            let meters = yards.converted(to: .meters).value.roundToDecimal(4)
            let miles = yards.converted(to: .miles).value.roundToDecimal(4)
            let centimeters = yards.converted(to: .centimeters).value.roundToDecimal(4)
            let millimeters = yards.converted(to: .millimeters).value.roundToDecimal(4)
            let inches = yards.converted(to: .inches).value.roundToDecimal(4)
            meterTextField.text = "\(meters)"
            mileTextField.text = "\(miles)"
            cmTextField.text = "\(centimeters)"
            mmTextField.text = "\(millimeters)"
            inchTextField.text = "\(inches)"
            yardTextField.text = text

            currentConversion = "\(yards.value.roundToDecimal(4)) yards = \(miles) miles = \(centimeters) centimeters = \(millimeters) millimeters = \(meters) meters = \(inches) inches"
        }
    }
    
    func inchTextFieldChanged(with text: String?) {
        if let text = text, let value = Double(text) {
            let inches = Measurement(value: value, unit: UnitLength.inches)
            let meters = inches.converted(to: .meters).value.roundToDecimal(4)
            let miles = inches.converted(to: .miles).value.roundToDecimal(4)
            let centimeters = inches.converted(to: .centimeters).value.roundToDecimal(4)
            let millimeters = inches.converted(to: .millimeters).value.roundToDecimal(4)
            let yards = inches.converted(to: .yards).value.roundToDecimal(4)
            meterTextField.text = "\(meters)"
            mileTextField.text = "\(miles)"
            cmTextField.text = "\(centimeters)"
            mmTextField.text = "\(millimeters)"
            yardTextField.text = "\(yards)"
            inchTextField.text = text

            currentConversion = "\(inches.value.roundToDecimal(4)) inches = \(miles) miles = \(centimeters) centimeters = \(millimeters) millimeters = \(yards) yards = \(meters) meters"
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
            if let viewcontroller = segue.destination as? HistoryViewController, let records = UserDefaults.standard.stringArray(forKey: "length") {
                viewcontroller.history = records
                viewcontroller.titleString = "Length History"
            }
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        meterTextField.text = nil
        mileTextField.text = nil
        cmTextField.text = nil
        mmTextField.text = nil
        yardTextField.text = nil
        inchTextField.text = nil
        currentConversion = nil
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentTextField = textField
    }

}

extension LengthConversionViewController: KeyboardDelegate {
    
    func keyWasTapped(character: String) {
        var text = ""
        if let previousText = currentTextField.text {
            text = previousText + character
        } else {
            text = character
        }
        
        switch currentTextField {
        case meterTextField:
            meterTextFieldChanged(with: text)
        case mileTextField:
            mileTextFieldChanged(with: text)
        case cmTextField:
            centimeterTextFieldChanged(with: text)
        case mmTextField:
            millimeterTextFieldChanged(with: text)
        case yardTextField:
            yardTextFieldChanged(with: text)
        case inchTextField:
            inchTextFieldChanged(with: text)
        default:
            break
        }
    }
    
    func backspaceWasTapped() {
        if var previousText = currentTextField.text {
            previousText.removeLast()
            switch currentTextField {
            case meterTextField:
                meterTextFieldChanged(with: previousText)
            case mileTextField:
                mileTextFieldChanged(with: previousText)
            case cmTextField:
                centimeterTextFieldChanged(with: previousText)
            case mmTextField:
                millimeterTextFieldChanged(with: previousText)
            case yardTextField:
                yardTextFieldChanged(with: previousText)
            case inchTextField:
                inchTextFieldChanged(with: previousText)
            default:
                break
            }
        }
    }
    
}
