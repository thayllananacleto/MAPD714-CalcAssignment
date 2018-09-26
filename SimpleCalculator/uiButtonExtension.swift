//
//  uiButtonExtension.swift
//  SimpleCalculator
//
//  Created by Thayllan Anacleto on 2018-09-26.
//  Copyright © 2018 Thayllan Anacleto. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
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
