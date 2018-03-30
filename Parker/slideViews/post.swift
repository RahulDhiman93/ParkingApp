//
//  post.swift
//  Parker
//
//  Created by Rahul Dhiman on 21/03/18.
//  Copyright © 2018 Rahul Dhiman. All rights reserved.
//

import UIKit

class post: UIView {
    @IBOutlet weak var PlaceDescription: UITextField!
    @IBOutlet weak var PlaceLocation: UITextField!
    
    @IBOutlet weak var CarInfo: UITextField!
    @IBOutlet weak var ChartView: UIView!
    @IBOutlet weak var MyPrice: UITextField!
    @IBOutlet weak var TotalPrice: UILabel!
    @IBOutlet weak var Gview: UIView!
    @IBOutlet weak var stackLead: NSLayoutConstraint!
    
    @IBOutlet weak var TimeRegion: UITextField!
    @IBOutlet weak var LocationPictureButton: UIButton!
    @IBOutlet weak var PlaceOfferButton: UIButton!
    @IBOutlet weak var DoneTexting: UIButton!
    @IBAction func DoneButtonDone(_ sender: Any) {
        
    }
    
}
