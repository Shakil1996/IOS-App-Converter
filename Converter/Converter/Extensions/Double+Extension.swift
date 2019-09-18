//
//  Double+Extension.swift
//  Converter
//
//  Created by shakil on 15/03/19.
//  Copyright © 2019 shakil. All rights reserved.
//

import Foundation

extension Double {
    
    // MARK: Utility method to round off a decimal value to defined digits.
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}
