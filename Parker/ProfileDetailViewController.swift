//
//  ProfileDetailViewController.swift
//  Parker
//
//  Created by Rahul Dhiman on 12/03/18.
//  Copyright © 2018 Rahul Dhiman. All rights reserved.
//

import UIKit
import Firebase

class ProfileDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func logout(_ sender: Any) {
         try! Auth.auth().signOut()
    }
    

}
