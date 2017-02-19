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
    
    static private let toChatViewControllerStoryboardIdentifier: String = "ToChatViewController"
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = defaultAppColor
        
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
                // Do something with a, now logged-in, user.
                print("I've logged in!")
                self.userHasLoggedIn()
            }, failure: { (error: Error) in
                self.showErrorAlert(withMessage: error.localizedDescription, andTitle: "Parse Sign Up Error")
            })
            
        }) { (error: Error) in
            // Do something on error
            guard self.emailTextField.text != "",
                self.passwordTextField.text != "" else {
                    self.showErrorAlert(withMessage: "The email and/or the password fields cannot be blank.", andTitle: "Input Error")
                    return
        }
            self.showErrorAlert(withMessage: error.localizedDescription, andTitle: "Parse Login Error")
        }
    }

    @IBAction func onLoginTapped(_ sender: Any) {
        self.emailTextField.endEditing(true)
        self.passwordTextField.endEditing(true)
        let email: String = self.emailTextField.text!
        let username: String = email
        let password: String = self.passwordTextField.text!
        let parseClient: ParseClient = ParseClient.sharedInstance
        
        let user: PFUser = parseClient.newUser(username: username, email: email, password: password)
        parseClient.login(user: user, success: { (loggedInUser: PFUser) in
            print("I've logged in!")
            self.userHasLoggedIn()
        }) { (error: Error) in
            self.showErrorAlert(withMessage: error.localizedDescription, andTitle: "Parse Login Error")
        }
    }
    
    
    func userHasLoggedIn() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let baseNavigationController: BaseNavigationViewController = storyboard.instantiateViewController(withIdentifier: ParseLoginViewController.toChatViewControllerStoryboardIdentifier) as! BaseNavigationViewController
        self.modalPresentationStyle = .popover
        self.present(baseNavigationController, animated: true, completion: nil)
    }
    
    
    // MARK: - Logistics
    
    private func showErrorAlert(withMessage message: String, andTitle title: String) {
        DispatchQueue.main.async {
            let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
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
