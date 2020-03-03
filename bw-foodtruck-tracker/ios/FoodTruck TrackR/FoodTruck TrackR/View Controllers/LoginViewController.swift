//
//  LoginViewController.swift
//  FoodTruck TrackR
//
//  Created by patelpra on 2/27/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginSegmentedControl: UISegmentedControl!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    static var isVendor: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
    }
    
    
    private func setupViews() {
        LoginViewController.isVendor = false
        // userType = .customer
        
        passwordTextField.isSecureTextEntry = true
    
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        guard let username = usernameTextField.text, !username.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else { return }
        // userType
        
    }
    
    @IBAction func segControlAction(_ sender: UISegmentedControl) {
        switch loginSegmentedControl.selectedSegmentIndex {
        case 0:
            LoginViewController.isVendor = false
            usernameTextField = nil // Need to change to userType = .customer
        case 1:
            LoginViewController.isVendor = true
            usernameTextField = nil // Need to change to userType = .diner
        default:
            break
        }
    }
}

