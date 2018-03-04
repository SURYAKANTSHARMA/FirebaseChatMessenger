//
//  ViewController.swift
//  FirebaseChatMessenger
//
//  Created by SuryaKant Sharma on 18/02/18.
//  Copyright © 2018 SuryaKant Sharma. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth

class ViewController: UITableViewController {
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    
    }

    @objc func handleLogout() {
        do {
            try Auth.auth().signOut()
        } catch  {
            print(error.localizedDescription)
        }
      present(LoginController(), animated: true, completion: nil)
    }

}

