//
//  ParseLoginViewController.swift
//  ParseApp
//
//  Created by Nick McDonald on 2/5/17.
//  Copyright © 2017 Nick McDonald. All rights reserved.
//

import UIKit
import Parse

class ParseLoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.emailTextField.becomeFirstResponder()
        let color: UIColor = UIColor.white.withAlphaComponent(0.40)
        self.emailTextField.attributedPlaceholder = NSAttributedString(string: "Enter email address...", attributes: [NSForegroundColorAttributeName: color])
        self.passwordTextField.attributedPlaceholder = NSAttributedString(string: "Enter password...", attributes: [NSForegroundColorAttributeName: color])
        
        self.loginButton.layer.cornerRadius = 19.0
        self.signUpButton.layer.cornerRadius = 19.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignUpTapped(_ sender: Any) {
        self.emailTextField.endEditing(true)
        self.passwordTextField.endEditing(true)
        guard self.emailTextField.text != "",
            self.passwordTextField.text != "" else {
                self.showErrorAlert(withMessage: "The email and/or the password fields cannot be blank.", andTitle: "Input Error")
                return
        }
        
        let email: String = self.emailTextField.text!
        let username: String = email
        let password: String = self.passwordTextField.text!
        let parseClient: ParseClient = ParseClient.sharedInstance
        
        let user: PFUser = parseClient.newUser(username: username, email: email, password: password)
        parseClient.signUp(user: user, success: {
            // Do something
            print("I've signed up!")
            parseClient.login(user: user, success: { (user: PFUser) in
                // Do something with a, now, logged in user.
                print("I've logged in!")
            }, failure: { (error: Error) in
                self.showErrorAlert(withMessage: error.localizedDescription, andTitle: "Parse Error")
            })
        }) { (error: Error) in
            // Do something on error
            self.showErrorAlert(withMessage: error.localizedDescription, andTitle: "Parse Error")
        }
    }

    @IBAction func onLoginTapped(_ sender: Any) {
        self.emailTextField.endEditing(true)
        self.passwordTextField.endEditing(true)
        guard self.emailTextField.text != "",
            self.passwordTextField.text != "" else {
                self.showErrorAlert(withMessage: "The email and/or the password fields cannot be blank.", andTitle: "Input Error")
                return
        }
        
        let email: String = self.emailTextField.text!
        let username: String = email
        let password: String = self.passwordTextField.text!
        let parseClient: ParseClient = ParseClient.sharedInstance
        
        let user: PFUser = parseClient.newUser(username: username, email: email, password: password)
        parseClient.login(user: user, success: { (loggedInUser: PFUser) in
            print("I've logged in!")
        }) { (error: Error) in
            self.showErrorAlert(withMessage: error.localizedDescription, andTitle: "Parse Error")
        }
    }
    
    
    // MARK: - Logistics
    
    private func showErrorAlert(withMessage: String, andTitle title: String) {
        let alertController: UIAlertController = UIAlertController(title: title, message: withMessage, preferredStyle: .alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
