//
//  FirstViewController.swift
//  Converter
//
//  Created by shakil on 14/03/19.
//  Copyright © 2019 shakil. All rights reserved.
//

import UIKit

// MARK: View Controller for Weight conversions and operations
class WeightConversionViewController: UIViewController, UITextFieldDelegate {

    // This is an IBOutlet for ounce text field, didSet is used to set it's delegate to self(WeightConversionViewController) so the delegate method gets called on relevant actions.
    @IBOutlet weak var ounceTextField: UITextField! {
        didSet {
            ounceTextField.delegate = self
        }
    }
    @IBOutlet weak var poundTextField: UITextField! {
        didSet {
            poundTextField.delegate = self
        }
    }
    @IBOutlet weak var gramTextField: UITextField! {
        didSet {
            gramTextField.delegate = self
        }
    }
    @IBOutlet weak var stoneTextField: UITextField! {
        didSet {
            stoneTextField.delegate = self
        }
    }
    @IBOutlet weak var kgTextField: UITextField! {
        didSet {
            kgTextField.delegate = self
        }
    }
    
    // this variable keeps track of the recent conversion
    var currentConversion: String?

    // this variable keeps track of the current text field
    var currentTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Here we initialize our custom keyboard
        let keyboardView = KeyboardView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: (self.view.frame.height)/3))
        keyboardView.delegate = self
        
        // Each text field's input view is assigned to custom keyboard so that system's default keyboard is replaced with custom keyboard.
        ounceTextField.inputView = keyboardView
        poundTextField.inputView = keyboardView
        gramTextField.inputView = keyboardView
        stoneTextField.inputView = keyboardView
        kgTextField.inputView = keyboardView

        // We hide the negation button from each screen except Temperature conversion screen.
        keyboardView.negationButton.removeFromSuperview()
        
        // this is tap gesture added on view so if user taps outside any textField, we can dismiss keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    // this is where the keyboard is actually dismissed
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        currentTextField.resignFirstResponder()
    }
    
    // store a new record in user defaults
    fileprivate func storeNewRecord(_ record: String) {
        // fetch all records from user defaults
        if var conversions = UserDefaults.standard.stringArray(forKey: "weight") {
            // check if there are less then 5 recores then simply add a new, if already 5 records are there then deleted the first (oldest) record and then add new record
            if conversions.count < 5 {
                conversions.append(record)
            } else {
                conversions.removeFirst()
                conversions.append(record)
            }
            // save record in user defaults
            UserDefaults.standard.set(conversions, forKey: "weight")
        } else {
            // this else case handles when there is no record initially
            UserDefaults.standard.set([record], forKey: "weight")
        }
    }
    
    // this is called whenever a text field text is changed. Here we do the conversions for all the other units, display them in relevant text fields and also keep track of this conversion by storing it in `currentConversion` so that if user wants to store it, we can store it in user defaults
    func ounceTextFieldChanged(with text: String?) {
        if let text = text, let value = Double(text) {
            let ounces = Measurement(value: value, unit: UnitMass.ounces)
            let pounds = ounces.converted(to: .pounds).value.roundToDecimal(4)
            let grams = ounces.converted(to: .grams).value.roundToDecimal(4)
            let kilograms = ounces.converted(to: .kilograms).value.roundToDecimal(4)
            let stones = ounces.converted(to: .stones).value.roundToDecimal(4)
            poundTextField.text = "\(pounds)"
            gramTextField.text = "\(grams)"
            kgTextField.text = "\(kilograms)"
            stoneTextField.text = "\(stones)"
            ounceTextField.text = text
            
            currentConversion = "\(ounces.value.roundToDecimal(4)) ounces = \(pounds) pounds = \(grams) grams = \(kilograms) kilograms = \(stones) stones"
        }
    }
    
    func poundTextFieldChanged(with text: String?) {
        if let text = text, let value = Double(text) {
            let pounds = Measurement(value: value, unit: UnitMass.pounds)
            let ounces = pounds.converted(to: .ounces).value.roundToDecimal(4)
            let grams = pounds.converted(to: .grams).value.roundToDecimal(4)
            let kilograms = pounds.converted(to: .kilograms).value.roundToDecimal(4)
            let stones = pounds.converted(to: .stones).value.roundToDecimal(4)
            ounceTextField.text = "\(ounces)"
            gramTextField.text = "\(grams)"
            kgTextField.text = "\(kilograms)"
            stoneTextField.text = "\(stones)"
            poundTextField.text = text
            
            currentConversion = "\(pounds.value.roundToDecimal(4)) pounds = \(ounces) ounces = \(grams) grams = \(kilograms) kilograms = \(stones) stones"
        }
    }
    
    func gramTextFieldChanged(with text: String?) {
        if let text = text, let value = Double(text) {
            let grams = Measurement(value: value, unit: UnitMass.grams)
            let ounces = grams.converted(to: .ounces).value.roundToDecimal(4)
            let pounds = grams.converted(to: .pounds).value.roundToDecimal(4)
            let kilograms = grams.converted(to: .kilograms).value.roundToDecimal(4)
            let stones = grams.converted(to: .stones).value.roundToDecimal(4)
            ounceTextField.text = "\(ounces)"
            poundTextField.text = "\(pounds)"
            kgTextField.text = "\(kilograms)"
            stoneTextField.text = "\(stones)"
            gramTextField.text = text
            
            currentConversion = "\(grams.value.roundToDecimal(4)) grams = \(pounds) pounds = \(ounces) ounces = \(kilograms) kilograms = \(stones) stones"
        }
    }
    
    func stoneTextFieldChanged(with text: String?) {
        if let text = text, let value = Double(text) {
            let stones = Measurement(value: value, unit: UnitMass.stones)
            let ounces = stones.converted(to: .ounces).value.roundToDecimal(4)
            let pounds = stones.converted(to: .pounds).value.roundToDecimal(4)
            let grams = stones.converted(to: .grams).value.roundToDecimal(4)
            let kilograms = stones.converted(to: .kilograms).value.roundToDecimal(4)
            ounceTextField.text = "\(ounces)"
            gramTextField.text = "\(grams)"
            poundTextField.text = "\(pounds)"
            kgTextField.text = "\(kilograms)"
            stoneTextField.text = text

            currentConversion = "\(stones.value.roundToDecimal(4)) stones = \(pounds) pounds = \(grams) grams = \(ounces) ounces = \(kilograms) kilograms"
        }
    }
    
    func kgTextFieldChanged(with text: String?) {
        if let text = text, let value = Double(text) {
            let kilograms = Measurement(value: value, unit: UnitMass.kilograms)
            let ounces = kilograms.converted(to: .ounces).value.roundToDecimal(4)
            let pounds = kilograms.converted(to: .pounds).value.roundToDecimal(4)
            let grams = kilograms.converted(to: .grams).value.roundToDecimal(4)
            let stones = kilograms.converted(to: .stones).value.roundToDecimal(4)
            ounceTextField.text = "\(ounces)"
            gramTextField.text = "\(grams)"
            poundTextField.text = "\(pounds)"
            stoneTextField.text = "\(stones)"
            kgTextField.text = text
            
            currentConversion = "\(kilograms.value.roundToDecimal(4)) kilograms = \(pounds) pounds = \(grams) grams = \(ounces) ounces = \(stones) stones"
        }
    }
    
    // this is action handler (function) of save button
    @IBAction func saveButtonTapped(_ sender: Any) {
        var alert: UIAlertController!
        // we check if there is any recent conversion or not and if yes then store a new record and present a alert "New record saved", if not then we simply present another alert "No new record to save"
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
    
    // this is delegate method and called whenever a segue is about to present/show, here we can pass values from this view controller to segue destination. In our case we are passing a relevant title and records to destination.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "History" {
            if let viewcontroller = segue.destination as? HistoryViewController, let records = UserDefaults.standard.stringArray(forKey: "weight") {
                viewcontroller.history = records
                viewcontroller.titleString = "Weight History"
            }
        }
    }

    // this is text field delegate method and call when a user tap on clear button. here we clear other text fields, set recent/current coversion to nil.
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        ounceTextField.text = nil
        poundTextField.text = nil
        gramTextField.text = nil
        kgTextField.text = nil
        stoneTextField.text = nil
        
        currentConversion = nil
        
        return true
    }
    
    // this is text Field delegate method and called when a text field editing is begin. here we keep track of the text field being edited (text field which is active at present)
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentTextField = textField
    }
    
}

// MARK: Keyboard Delegate Methods handling
extension WeightConversionViewController: KeyboardDelegate {
    
    // This delegates gets called whenever a key is tapped other then `clear/backspace`. Here we append the typed digit or . to the existing digits or simply insert it if it is blank.
    func keyWasTapped(character: String) {
        var text = ""
        if let previousText = currentTextField.text {
            text = previousText + character
        } else {
            text = character
        }
        
        switch currentTextField {
        case ounceTextField:
            ounceTextFieldChanged(with: text)
        case poundTextField:
            poundTextFieldChanged(with: text)
        case gramTextField:
            gramTextFieldChanged(with: text)
        case kgTextField:
            kgTextFieldChanged(with: text)
        case stoneTextField:
            stoneTextFieldChanged(with: text)
        default:
            break
        }
    }
    
    // This delegates gets called whenever `clear/backspace` key is tapped. Here we simply remove the last digit
    func backspaceWasTapped() {
        if var previousText = currentTextField.text {
            previousText.removeLast()
            switch currentTextField {
            case ounceTextField:
                ounceTextFieldChanged(with: previousText)
            case poundTextField:
                poundTextFieldChanged(with: previousText)
            case gramTextField:
                gramTextFieldChanged(with: previousText)
            case kgTextField:
                kgTextFieldChanged(with: previousText)
            case stoneTextField:
                stoneTextFieldChanged(with: previousText)
            default:
                break
            }
        }
    }
    
}

