//
//  NewUserVC.swift
//  FirebaseSwift5
//
//  Created by Joshua Mac Guinness on 31/8/19.
//  Copyright © 2019 Wei Lian Chin. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth


class NewUserVC: UIViewController {

    var db: Firestore!

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    
    @IBAction func onSignUpTapped(_ sender: Any) {
        
        

        
        let signUpManager = FirebaseAuthManager()
        if let email = emailTF.text, let password = passwordTF.text {
            signUpManager.createUser(email: email, password: password) {[weak self] (success) in
                guard let `self` = self else { return }
                var message: String = ""
                if (success) {
                    message = "User was sucessfully created."
                } else {
                    message = "There was an error."
                }
                let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertController, animated: true)
//                self.performSegue(withIdentifier: "returnHome", sender: self)
                self.emailTF.text = ""
                self.passwordTF.text = ""
            }
        }
        
        
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        }
        catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initial = storyboard.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = initial
    }
    
    
    
}

