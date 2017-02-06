//
//  ParseLoginViewController.swift
//  ParseApp
//
//  Created by Nick McDonald on 2/5/17.
//  Copyright © 2017 Nick McDonald. All rights reserved.
//

import UIKit

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
    }

    @IBAction func onLoginTapped(_ sender: Any) {
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
