//
//  SpeedConversionViewController.swift
//  Converter
//
//  Created by shakil on 14/03/19.
//  Copyright © 2019 shakil. All rights reserved.
//

import UIKit

class SpeedConversionViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var metersPerSecondTextField: UITextField! {
        didSet {
            metersPerSecondTextField.delegate = self
        }
    }
    @IBOutlet weak var kilometersPerHourTextField: UITextField! {
        didSet {
            kilometersPerHourTextField.delegate = self
        }
    }
    @IBOutlet weak var milesPerHourTextField: UITextField! {
        didSet {
            milesPerHourTextField.delegate = self
        }
    }
    @IBOutlet weak var knotsTextField: UITextField! {
        didSet {
            knotsTextField.delegate = self
        }
    }

    var currentConversion: String?
    var currentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keyboardView = KeyboardView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: (self.view.frame.height)/3))
        keyboardView.delegate = self
        
        metersPerSecondTextField.inputView = keyboardView
        kilometersPerHourTextField.inputView = keyboardView
        milesPerHourTextField.inputView = keyboardView
        knotsTextField.inputView = keyboardView
        
        keyboardView.negationButton.removeFromSuperview()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        currentTextField.resignFirstResponder()
    }
    
    fileprivate func storeNewRecord(_ record: String) {
        if var conversions = UserDefaults.standard.stringArray(forKey: "speed") {
            if conversions.count < 5 {
                conversions.append(record)
            } else {
                conversions.removeFirst()
                conversions.append(record)
            }
            UserDefaults.standard.set(conversions, forKey: "speed")
        } else {
            UserDefaults.standard.set([record], forKey: "speed")
        }
    }
    
    func metersPerSecondTextFieldEditingChanged(with text: String?) {
        if let text = text, let value = Double(text) {
            let metersPerSecond = Measurement(value: value, unit: UnitSpeed.metersPerSecond)
           let kilometersPerHour =  metersPerSecond.converted(to: .kilometersPerHour).value.roundToDecimal(4)
            let milesPerHour = metersPerSecond.converted(to: .milesPerHour).value.roundToDecimal(4)
            let knots = metersPerSecond.converted(to: .knots).value.roundToDecimal(4)
            kilometersPerHourTextField.text = "\(kilometersPerHour)"
            milesPerHourTextField.text = "\(milesPerHour)"
            knotsTextField.text = "\(knots)"
            metersPerSecondTextField.text = text
            
            currentConversion = "\(metersPerSecond.value.roundToDecimal(4)) metersPerSecond = \(kilometersPerHour) kilometersPerHour = \(milesPerHour) milesPerHour = \(knots) knots"

        }
    }
    
    func kilometersPerHourTextFieldEditingChanged(with text: String?) {
        if let text = text, let value = Double(text) {
            let kilometersPerHour = Measurement(value: value, unit: UnitSpeed.kilometersPerHour)
            let metersPerSecond =  kilometersPerHour.converted(to: .metersPerSecond).value.roundToDecimal(4)
            let milesPerHour = kilometersPerHour.converted(to: .milesPerHour).value.roundToDecimal(4)
            let knots = kilometersPerHour.converted(to: .knots).value.roundToDecimal(4)
            metersPerSecondTextField.text = "\(metersPerSecond)"
            milesPerHourTextField.text = "\(milesPerHour)"
            knotsTextField.text = "\(knots)"
            kilometersPerHourTextField.text = text
            
            currentConversion = "\(kilometersPerHour.value.roundToDecimal(4)) kilometersPerHour = \(metersPerSecond) metersPerSecond = \(milesPerHour) milesPerHour = \(knots) knots"
        }
    }
    
    func milesPerHourTextFieldEditingChanged(with text: String?) {
        if let text = text, let value = Double(text) {
            let milesPerHour = Measurement(value: value, unit: UnitSpeed.milesPerHour)
            let metersPerSecond =  milesPerHour.converted(to: .metersPerSecond).value.roundToDecimal(4)
            let kilometersPerHour = milesPerHour.converted(to: .kilometersPerHour).value.roundToDecimal(4)
            let knots = milesPerHour.converted(to: .knots).value.roundToDecimal(4)
            metersPerSecondTextField.text = "\(metersPerSecond)"
            kilometersPerHourTextField.text = "\(kilometersPerHour)"
            knotsTextField.text = "\(knots)"
            milesPerHourTextField.text = text
            
            currentConversion = "\(milesPerHour.value.roundToDecimal(4)) milesPerHour = \(metersPerSecond) metersPerSecond = \(kilometersPerHour) kilometersPerHour = \(knots) knots"
        }
    }
    
    func knotsTextFieldEditingChanged(with text: String?) {
        if let text = text, let value = Double(text) {
            let knots = Measurement(value: value, unit: UnitSpeed.knots)
            let metersPerSecond =  knots.converted(to: .metersPerSecond).value.roundToDecimal(4)
            let kilometersPerHour = knots.converted(to: .kilometersPerHour).value.roundToDecimal(4)
            let milesPerHour = knots.converted(to: .milesPerHour).value.roundToDecimal(4)
            metersPerSecondTextField.text = "\(metersPerSecond)"
            kilometersPerHourTextField.text = "\(kilometersPerHour)"
            milesPerHourTextField.text = "\(milesPerHour)"
            knotsTextField.text = text
            
            currentConversion = "\(knots.value.roundToDecimal(4)) knots = \(metersPerSecond) metersPerSecond = \(kilometersPerHour) kilometersPerHour = \(milesPerHour) milesPerHour"
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
            if let viewcontroller = segue.destination as? HistoryViewController, let records = UserDefaults.standard.stringArray(forKey: "speed") {
                viewcontroller.history = records
                viewcontroller.titleString = "Speed History"
            }
        }
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        metersPerSecondTextField.text = nil
        kilometersPerHourTextField.text = nil
        milesPerHourTextField.text = nil
        knotsTextField.text = nil
        currentConversion = nil
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentTextField = textField
    }
}

extension SpeedConversionViewController: KeyboardDelegate {
    
    func keyWasTapped(character: String) {
        var text = ""
        if let previousText = currentTextField.text {
            text = previousText + character
        } else {
            text = character
        }
        
        switch currentTextField {
        case metersPerSecondTextField:
            metersPerSecondTextFieldEditingChanged(with: text)
        case kilometersPerHourTextField:
            kilometersPerHourTextFieldEditingChanged(with: text)
        case milesPerHourTextField:
            milesPerHourTextFieldEditingChanged(with: text)
        case knotsTextField:
            knotsTextFieldEditingChanged(with: text)
        default:
            break
        }
    }
    
    func backspaceWasTapped() {
        if var previousText = currentTextField.text {
            previousText.removeLast()
            switch currentTextField {
            case metersPerSecondTextField:
                metersPerSecondTextFieldEditingChanged(with: previousText)
            case kilometersPerHourTextField:
                kilometersPerHourTextFieldEditingChanged(with: previousText)
            case milesPerHourTextField:
                milesPerHourTextFieldEditingChanged(with: previousText)
            case knotsTextField:
                knotsTextFieldEditingChanged(with: previousText)
            default:
                break
            }
        }
    }
    
}
