//
//  TabViewController.swift
//  FirebaseSwift5
//
//  Created by Wei Lian Chin on 29/08/2019.
//  Copyright © 2019 Wei Lian Chin. All rights reserved.
//

import UIKit
import Firebase

class TabViewController: UITabBarController {
let uid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        // Do any additional setup after loading the view.
        
        
        // MARK: - User Privilages
        let user = Auth.auth().currentUser
        if let user = user {
            let uid = user.uid
            let email = user.email
            print(uid)
            print(email)
        }
        
        if uid == "test@test.com" {
            if let arrayOfTabBarItems = self.tabBar.items as AnyObject as? NSArray,let
                tabBarItem1 = arrayOfTabBarItems[1] as? UITabBarItem {
                tabBarItem1.isEnabled = false
            }
            if let arrayOfTabBarItems = self.tabBar.items as AnyObject as? NSArray,let
                tabBarItem2 = arrayOfTabBarItems[4] as? UITabBarItem {
                tabBarItem2.isEnabled = false
            }
        }
        
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
