//
//  SettingsViewController.swift
//  SimpleCalculator
//
//  Created by Thayllan Anacleto on 2018-10-13.
//  Copyright © 2018 Thayllan Anacleto. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var btnDefault: UIButton!
    @IBOutlet weak var btnRed: UIButton!
    @IBOutlet weak var btnGreen: UIButton!
    @IBOutlet weak var btnGray: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTheme()
    }
    
    @IBAction func changeThemeToDefault(_ sender: UIButton) {
        
        Theme.current = DefaultTheme()
        setTheme()
        
    }
    
    @IBAction func changeThemeToRed(_ sender: UIButton) {
        
        Theme.current = RedTheme()
        setTheme()
        
    }
    
    @IBAction func changeThemeToGreen(_ sender: UIButton) {
        
        Theme.current = GreenTheme()
        setTheme()
        
    }
    
    @IBAction func changeThemeToGray(_ sender: UIButton) {
        
        Theme.current = GrayTheme()
        setTheme()
        
    }
    
    fileprivate func setTheme() {
        view.backgroundColor = Theme.current.background
        btnDefault.backgroundColor = Theme.current.background
        btnRed.backgroundColor = Theme.current.background
        btnGreen.backgroundColor = Theme.current.background
        btnGray.backgroundColor = Theme.current.background
    }
    
}
