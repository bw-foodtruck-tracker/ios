//
//  signupViewController.swift
//  FoodTruckTrackr
//
//  Created by Nicolas Rios on 2/27/20.
//  Copyright © 2020 Nicolas Rios. All rights reserved.
//

import UIKit


class signupViewController: UIViewController {
   
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    
    // come back to file for more coding
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {
        guard let username = usernameTextField.text, !username.isEmpty,
            let password = passwordTextField.text, !password.isEmpty,
        let email = emailTextField.text, !email.isEmpty else { return }
        
        
        
    }
    
    
}
