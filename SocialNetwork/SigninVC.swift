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
import SwiftKeychainWrapper


class SigninVC: UIViewController {
    @IBOutlet weak var txtEmail: CustomField!
    @IBOutlet weak var txtPassword: CustomField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID){
            performSegue(withIdentifier: "FeedVC", sender: nil)
        }
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
                if let user = user{
                    let userData = ["Provider":_credential.provider]
                self.completeSignin(id: user.uid,userData: userData)
                }
            }
        })
    }
    
    @IBAction func signinPressed(_ sender: Any) {
        
        if let email = txtEmail.text , let password = txtPassword.text{
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil{
            print("Email user authenticate with firebase.")
                if let user = user{
                    let userData = ["Provider":user.providerID]
                    self.completeSignin(id: user.uid,userData: userData)
                }
            }
            else{
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                if error != nil{
                print("Unable to create a new user with Email.")
                }
                else{
                print("Successfully autheticate with firebase using new email.")
                    if let user = user{
                        let userData = ["Provider":user.providerID]
                        self.completeSignin(id: user.uid,userData: userData)
                        }
                    }
                })
                }
            })
        }
    }
    
    func completeSignin(id: String , userData:Dictionary<String,String> ){
        DataService.ds.createFirbaseDBUser(uid: id, userData: userData)
    let keychainResult = KeychainWrapper.standard.set(id,forKey: KEY_UID)
        print("Data saved to keychain \(keychainResult)")
        performSegue(withIdentifier: "FeedVC", sender: nil)
    }
}

