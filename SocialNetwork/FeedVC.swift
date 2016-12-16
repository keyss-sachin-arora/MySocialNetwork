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

class FeedVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    var posts = [Post]()
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
        if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot]{
            for snap in snapshot{
            print("SNAP : \(snap)")
                if let postDict = snap.value as? NSDictionary{
                let key = snap.key
                let post = Post.init(postKey: key, postData: postDict as! Dictionary<String, AnyObject>)
                    self.posts.append(post)
                }
            }
            }
            self.tableView.reloadData()
        })
       
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? PostCell
        
        let post = posts[indexPath.row]
        print("Caption:\(post.caption)")
        return cell!
        
    }
   
    @IBAction func signOutPressed(_ sender: Any) {
       let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("Remove from keychain \(keychainResult)")
        try! FIRAuth.auth()?.signOut()
        dismiss(animated: true, completion: nil)
    }

}
