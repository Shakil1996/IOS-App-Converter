//
//  LiquidsConversionViewController.swift
//  Converter
//
//  Created by shakil on 14/03/19.
//  Copyright © 2019 shakil. All rights reserved.
//

import UIKit

class LiquidsConversionViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var gallonTextField: UITextField! {
        didSet {
            gallonTextField.delegate = self
        }
    }
    @IBOutlet weak var literTextField: UITextField! {
        didSet {
            literTextField.delegate = self
        }
    }
    @IBOutlet weak var pintTextField: UITextField! {
        didSet {
            pintTextField.delegate = self
        }
    }
    @IBOutlet weak var ounceTextField: UITextField! {
        didSet {
            ounceTextField.delegate = self
        }
    }
    @IBOutlet weak var milliliterTextField: UITextField! {
        didSet {
            milliliterTextField.delegate = self
        }
    }
    
    var currentConversion: String?
    var currentTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keyboardView = KeyboardView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: (self.view.frame.height)/3))
        keyboardView.delegate = self
        
        gallonTextField.inputView = keyboardView
        literTextField.inputView = keyboardView
        pintTextField.inputView = keyboardView
        ounceTextField.inputView = keyboardView
        milliliterTextField.inputView = keyboardView
        
        keyboardView.negationButton.removeFromSuperview()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        currentTextField.resignFirstResponder()
    }
    
    fileprivate func storeNewRecord(_ record: String) {
        if var conversions = UserDefaults.standard.stringArray(forKey: "liquid") {
            if conversions.count < 5 {
                conversions.append(record)
            } else {
                conversions.removeFirst()
                conversions.append(record)
            }
            UserDefaults.standard.set(conversions, forKey: "liquid")
        } else {
            UserDefaults.standard.set([record], forKey: "liquid")
        }
    }
    
    func gallonTextFieldChanged(with text: String?) {
        if let text = text, let value = Double(text) {
            let gallons = Measurement(value: value, unit: UnitVolume.gallons)
            let liters = gallons.converted(to: .liters).value.roundToDecimal(4)
            let pints = gallons.converted(to: .pints).value.roundToDecimal(4)
            let fluidOunces = gallons.converted(to: .fluidOunces).value.roundToDecimal(4)
            let milliliters = gallons.converted(to: .milliliters).value.roundToDecimal(4)
            
            literTextField.text = "\(liters)"
            pintTextField.text = "\(pints)"
            ounceTextField.text = "\(fluidOunces)"
            milliliterTextField.text = "\(milliliters)"
            gallonTextField.text = text
            
            currentConversion = "\(gallons.value.roundToDecimal(4)) gallons = \(liters) liters = \(pints) pints = \(fluidOunces) fluidOunces = \(milliliters) milliliters"

        }
    }
    
    func literTextFieldChanged(with text: String?) {
        if let text = text, let value = Double(text) {
            let liters = Measurement(value: value, unit: UnitVolume.liters)
            let gallons = liters.converted(to: .gallons).value.roundToDecimal(4)
            let pints = liters.converted(to: .pints).value.roundToDecimal(4)
            let fluidOunces = liters.converted(to: .fluidOunces).value.roundToDecimal(4)
            let milliliters = liters.converted(to: .milliliters).value.roundToDecimal(4)
            
            gallonTextField.text = "\(gallons)"
            pintTextField.text = "\(pints)"
            ounceTextField.text = "\(fluidOunces)"
            milliliterTextField.text = "\(milliliters)"
            literTextField.text = text
            
            currentConversion = "\(liters.value.roundToDecimal(4)) liters = \(gallons) gallons = \(pints) pints = \(fluidOunces) fluidOunces = \(milliliters) milliliters"
        }
    }
    
    func pintTextFieldChanged(with text: String?) {
        if let text = text, let value = Double(text) {
            let pints = Measurement(value: value, unit: UnitVolume.pints)
            let gallons = pints.converted(to: .gallons).value.roundToDecimal(4)
            let liters = pints.converted(to: .liters).value.roundToDecimal(4)
            let fluidOunces = pints.converted(to: .fluidOunces).value.roundToDecimal(4)
            let milliliters = pints.converted(to: .milliliters).value.roundToDecimal(4)
            gallonTextField.text = "\(gallons)"
            literTextField.text = "\(liters)"
            ounceTextField.text = "\(fluidOunces)"
            milliliterTextField.text = "\(milliliters)"
            pintTextField.text = text
            
            currentConversion = "\(pints.value.roundToDecimal(4)) pints = \(gallons) gallons = \(liters) liters = \(fluidOunces) fluidOunces = \(milliliters) milliliters"

        }
    }
    
    func ounceTextFieldChanged(with text: String?) {
        if let text = text, let value = Double(text) {
            let fluidOunces = Measurement(value: value, unit: UnitVolume.fluidOunces)
            let gallons = fluidOunces.converted(to: .gallons).value.roundToDecimal(4)
            let liters = fluidOunces.converted(to: .liters).value.roundToDecimal(4)
            let pints = fluidOunces.converted(to: .pints).value.roundToDecimal(4)
            let milliliters = fluidOunces.converted(to: .milliliters).value.roundToDecimal(4)
            gallonTextField.text = "\(gallons)"
            literTextField.text = "\(liters)"
            pintTextField.text = "\(pints)"
            milliliterTextField.text = "\(milliliters)"
            ounceTextField.text = text
            
            currentConversion = "\(fluidOunces.value.roundToDecimal(4)) fluidOunces = \(gallons) gallons = \(liters) liters = \(pints) pints = \(milliliters) milliliters"

        }
    }
    
    func milliliterTextFieldChanged(with text: String?) {
        if let text = text, let value = Double(text) {
            let milliliters = Measurement(value: value, unit: UnitVolume.milliliters)
            let gallons = milliliters.converted(to: .gallons).value.roundToDecimal(4)
            let liters = milliliters.converted(to: .liters).value.roundToDecimal(4)
            let pints = milliliters.converted(to: .pints).value.roundToDecimal(4)
            let fluidOunces = milliliters.converted(to: .fluidOunces).value.roundToDecimal(4)
            gallonTextField.text = "\(gallons)"
            literTextField.text = "\(liters)"
            pintTextField.text = "\(pints)"
            ounceTextField.text = "\(fluidOunces)"
            milliliterTextField.text = text
            
            currentConversion = "\(milliliters.value.roundToDecimal(4)) milliliters = \(gallons) gallons = \(liters) liters = \(pints) pints = \(fluidOunces) fluidOunces"

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
            if let viewcontroller = segue.destination as? HistoryViewController, let records = UserDefaults.standard.stringArray(forKey: "liquid") {
                viewcontroller.history = records
                viewcontroller.titleString = "Liquids History"
            }
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        gallonTextField.text = nil
        literTextField.text = nil
        pintTextField.text = nil
        ounceTextField.text = nil
        milliliterTextField.text = nil
        currentConversion = nil
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentTextField = textField
    }
}

extension LiquidsConversionViewController: KeyboardDelegate {
    
    func keyWasTapped(character: String) {
        var text = ""
        if let previousText = currentTextField.text {
            text = previousText + character
        } else {
            text = character
        }
        
        switch currentTextField {
        case gallonTextField:
            gallonTextFieldChanged(with: text)
        case literTextField:
            literTextFieldChanged(with: text)
        case pintTextField:
            pintTextFieldChanged(with: text)
        case ounceTextField:
            ounceTextFieldChanged(with: text)
        case milliliterTextField:
            milliliterTextFieldChanged(with: text)
        default:
            break
        }
    }
    
    func backspaceWasTapped() {
        if var previousText = currentTextField.text {
            previousText.removeLast()
            switch currentTextField {
            case gallonTextField:
                gallonTextFieldChanged(with: previousText)
            case literTextField:
                literTextFieldChanged(with: previousText)
            case pintTextField:
                pintTextFieldChanged(with: previousText)
            case ounceTextField:
                ounceTextFieldChanged(with: previousText)
            case milliliterTextField:
                milliliterTextFieldChanged(with: previousText)
            default:
                break
            }
        }
    }
    
}
