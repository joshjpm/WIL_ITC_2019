//
//  ViewController.swift
//  FirebaseSwift5
//
//  Created by Wei Lian Chin on 26/08/2019.
//  Copyright © 2019 Wei Lian Chin. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var checkBoxSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        checkBoxSwitch.setOn(false, animated: false)
        self.loginButton.backgroundColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 0.5)
        self.loginButton.setTitleColor(.black, for: .normal)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: email.text! , password: password.text!){
            (user, error) in
            if error != nil {
                print (error!)
            }else {
                print("Login successful")
                self.performSegue(withIdentifier: "goHome", sender: self)
                
            }
        }
    }
    
    @IBAction func switchChange(_ sender: Any) {
        if checkBoxSwitch.isOn {
            loginButton.isEnabled = true
            self.loginButton.backgroundColor = UIColor(red: 149/255, green: 252/255, blue: 189/255, alpha: 1)
            self.loginButton.setTitleColor(.white, for: .normal)
        }
        else {
            loginButton.isEnabled = false
            self.loginButton.backgroundColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 0.5)
            self.loginButton.setTitleColor(.black, for: .normal)
        }
    }
    
    
    @IBAction func forceContinue(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "goHome", sender: nil)
        
            let user = Auth.auth().currentUser
            if let user = user {
                
                let uid = user.uid
                let email = user.email
                
                print(uid)
                print(email)
            }
            
        }
    }
    
    
   
}

