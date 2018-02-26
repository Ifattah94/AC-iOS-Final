//
//  LoginViewController.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    var loginSuccess = false

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTF.delegate = self
        passwordTF.delegate = self

    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if loginSuccess == true && identifier == "login" {
            return true
        } else { return false}
    }
    
    public static func storyBoardInstance() -> LoginViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        return VC
    }
    
   private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in}
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let emailText = emailTF.text, !emailText.isEmpty else { showAlert(title: "Error", message: "Enter valid email address"); return}
        guard let passwordText = passwordTF.text, !passwordText.isEmpty else {
            showAlert(title: "Error", message: "Enter valid password"); return
        }
        AuthUserService.manager.signIn(withEmail: emailText, andPassword: passwordText) { (user, error) in
            if let error = error {
                self.loginSuccess = false
                self.showAlert(title: "Error", message: error.localizedDescription)
            } else if let user = user {
                self.loginSuccess = true
                self.performSegue(withIdentifier: "login", sender: self)
                print(user)
            }
            
        }
    }
    
    @IBAction func createAccountButtonPressed(_ sender: UIButton) {
        guard let emailText = emailTF.text, !emailText.isEmpty else { showAlert(title: "Error", message: "Enter valid email address"); return}
        guard let passwordText = passwordTF.text, !passwordText.isEmpty else {
            showAlert(title: "Error", message: "Enter valid password"); return
        }
        AuthUserService.manager.createAccount(withEmail: emailText, andPassword: passwordText) { (user, error) in
            if let error = error {
                self.showAlert(title: "Error", message: "Could not create user: error \(error.localizedDescription)")
            } else if let user = user {
                self.showAlert(title: "Success", message: "User Created")
                print(user)
            }
        }
    }
    
    
    
}

extension LoginViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true 
    }
}
