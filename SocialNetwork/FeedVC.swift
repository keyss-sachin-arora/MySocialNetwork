//
//  FeedVC.swift
//  SocialNetwork
//
//  Created by Mac Mini on 15/12/16.
//  Copyright © 2016 Mac Mini. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

   
    @IBAction func signOutPressed(_ sender: Any) {
       let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("Remove from keychain \(keychainResult)")
        try! FIRAuth.auth()?.signOut()
//            {
//        
//        }catch if let error = NSError{
//        print("Error \(error))")
//        }
        dismiss(animated: true, completion: nil)
    }

}
