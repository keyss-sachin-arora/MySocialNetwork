//
//  ViewController.swift
//  SocialNetwork
//
//  Created by Mac Mini on 12/12/16.
//  Copyright © 2016 Mac Mini. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase


class SigninVC: UIViewController {
    @IBOutlet weak var txtEmail: CustomField!
    @IBOutlet weak var txtPassword: CustomField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func facebookBtnPressed(_ sender: Any) {
        let loginManager = FBSDKLoginManager()
        loginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil{
            print("Unable to authenticate with facebook \(error)")
            }
            else if result?.isCancelled == true{
            print("User cancelled the authentication permission")
            }
            else{
            print("Successfully authenticate with facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(_credential: credential)
                
            }
        }
    }

    func firebaseAuth(_credential : FIRAuthCredential){
    
        FIRAuth.auth()?.signIn(with: _credential, completion: { (user, error) in
            if error != nil{
            print("Unable to authenticate with firebase \(error)")
            }
            else{
            print("Successfully authenticate with firebase")
            }
        })
    }
    
    @IBAction func signinPressed(_ sender: Any) {
        
        if let email = txtEmail.text , let password = txtPassword.text{
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil{
            print("Email user authenticate with firebase.")
            }
            else{
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                if error != nil{
                print("Unable to create a new user with Email.")
                }
                else{
                print("Successfully autheticate with firebase using new email.")
                    }
                })
                }
            })
            }
        }
    }

