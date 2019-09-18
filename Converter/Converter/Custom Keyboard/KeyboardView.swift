//
//  KeyboardView.swift
//  Converter
//
//  Created by shakil on 18/03/19.
//  Copyright © 2019 shakil. All rights reserved.
//

import UIKit

protocol KeyboardDelegate: class {
    func keyWasTapped(character: String)
    func backspaceWasTapped()
}

class KeyboardView: UIView {

    @IBOutlet var keyboardButtons: [UIButton]!
    @IBOutlet weak var negationButton: UIButton!
    
    weak var delegate: KeyboardDelegate?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    
    func initializeSubviews() {
        let xibFileName = "KeyboardView"
        let view = Bundle.main.loadNibNamed(xibFileName, owner: self, options: nil)?[0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
        
        for button in keyboardButtons {
            button.layer.borderWidth = 1.0
            button.layer.borderColor = UIColor.black.cgColor
        }
        
        negationButton.layer.borderWidth = 1.0
        negationButton.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func keyTapped(sender: UIButton) {
        // When a button is tapped, send that information to the
        // delegate (ie, the view controller)
        self.delegate?.keyWasTapped(character: sender.titleLabel?.text ?? "")
    }
    
    @IBAction func backspaceTapped(_ sender: Any) {
        self.delegate?.backspaceWasTapped()
    }
    
}
