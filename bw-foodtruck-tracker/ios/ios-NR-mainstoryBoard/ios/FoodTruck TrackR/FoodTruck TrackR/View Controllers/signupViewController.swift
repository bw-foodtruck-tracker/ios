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
    
    var userType: UserType?
    var customerController: CustomerController?
    var grubFoodController: GrubFoodController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        userType = .customer
        passwordTextField.isSecureTextEntry = true
        
    }
    
    
    @IBAction func signupButtonTapped(_ sender: UIButton) {
        guard let username = usernameTextField.text, !username.isEmpty,
            let password = passwordTextField.text, !password.isEmpty,
            let email = emailTextField.text, !email.isEmpty else { return }
        guard let userType = userType else { return }
        switch userType {
        case .customer:
            customerController?.register(user: CustomerSignup(username: username, password: password, email: email)) { error in
                
                if let error = error {
                    NSLog("User failed to register: \(error)")
                    DispatchQueue.main.async {
                    }
                    return
                } else {
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(title: "Sign Up Successful", message: "Now please log in.", preferredStyle: .alert)
                        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alertController.addAction(alertAction)
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }
        case .grubfood:
            grubFoodController?.register(user: GrubFoodSignup(username: username, password: password, email: email)) { error in
                if let error = error {
                    NSLog("User failed to register: \(error)")
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
}
