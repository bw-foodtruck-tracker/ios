//
//  LoginViewController.swift
//  FoodTruck TrackR
//
//  Created by patelpra on 2/27/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import UIKit

enum UserType: String {
    case customer
    case grubfood
}

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loginSegmentedControl: UISegmentedControl!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    static var isGrubFood: Bool = false
    
    var userType: UserType?
    
    var customerController: CustomerController?
    var grubFoodController: GrubFoodController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViews()
    }
    
    private func setupViews() {
        LoginViewController.isGrubFood = false
        userType = .customer
        
        passwordTextField.isSecureTextEntry = true
    
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        guard let username = usernameTextField.text, !username.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else { return }
        guard let userType = userType else { return }
        
        switch userType {
        case .grubfood:
            grubFoodController?.logIn(user: GrubFoodLogin(username: username, password: password)) { error in
                if let error: NetworkError = error {
                    NSLog("Error returned when trying to log in: \(error)")
                    DispatchQueue.main.async {
                    }
                    return
                } else {
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        case .customer:
            customerController?.logIn(user: CustomerLogin(username: username, password: password)) { error in
                if let error: NetworkError = error {
                    NSLog("Error returned when trying to login: \(error)")
                    DispatchQueue.main.async {
                    }
                    return
                } else {
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    @IBAction func segControlAction(_ sender: UISegmentedControl) {
        switch loginSegmentedControl.selectedSegmentIndex {
        case 0:
            LoginViewController.isGrubFood = false
            userType = .customer
        case 1:
            LoginViewController.isGrubFood = true
            userType = .grubfood
        default:
            break
        }
    }
}

