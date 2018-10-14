//
//  uiButtonExtension.swift
//  SimpleCalculator
//
//  Created by Thayllan Anacleto on 2018-09-26.
//  Copyright © 2018 Thayllan Anacleto. All rights reserved.
//
//  StudentID: 300973606
//  Version: 1.0.0

import Foundation
import UIKit

//Class responsible for doing the animations on the buttons
extension UIButton {
    
    open override func awakeFromNib() {
        
        backgroundColor = Theme.current.background
        
    }
    
    func pulsate() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.1
        pulse.fromValue = 0.96
        pulse.toValue = 1.5
        pulse.autoreverses = true
        pulse.repeatCount = 1
        pulse.initialVelocity = 1.0
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: nil)
        
    }
    
}
