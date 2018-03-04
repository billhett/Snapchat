//
//  SignInViewController.swift
//  Snapchat
//
//  Created by William Hettinger on 3/3/18.
//  Copyright © 2018 William Hettinger. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            print("we tried to sign in ")
            if error != nil{
                print("error signing in: \(String(describing: error))")
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    print("we tried to create a user")
                    if error != nil {
                        print("error: \(String(describing: error))")
                    } else {
                        print("success creating new user: \(user)")
                    }
                })
            } else {
                print("signed in successfully: \(String(describing: user))")
            }
        }
    }
    
}

