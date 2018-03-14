//
//  ProfileDetailViewController.swift
//  Parker
//
//  Created by Rahul Dhiman on 12/03/18.
//  Copyright © 2018 Rahul Dhiman. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON
import Alamofire

class ProfileDetailViewController: UIViewController {
    
    var timer = Timer()
    var timerImg = Timer()
    
    var handleName:DatabaseHandle?
    var handleEmail:DatabaseHandle?
    var handleImgUrl:DatabaseHandle?
    var ref:DatabaseReference?
    var preName:String? = ""
    var preEmail:String? = ""
    var preImgUrl:String? = ""
    var ProfileImgUrl:String? = ""
    
    
    
    @IBOutlet weak var ProfileImage: UIImageView!
    
    @IBOutlet weak var ProfileName: UILabel!
    
    @IBOutlet weak var ProfileEmail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.handling()
        
        self.ProfileImage.layer.cornerRadius = self.ProfileImage.frame.width/2
        self.ProfileImage.clipsToBounds = true
        
        
        self.ProfileName.text = self.preName
        self.ProfileEmail.text = self.preEmail
        // Do any additional setup after loading the view.
        
        self.scheduledTimerWithTimeInterval()
       
        
        
    }

    @IBAction func logout(_ sender: Any) {
         try! Auth.auth().signOut()
    }
    
    func ImportingProfileImage(){
        let rqsturl = URL(string: self.ProfileImgUrl!)!
        let session = URLSession.shared
        let request = URLRequest(url: rqsturl)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print("error erroe error error error")
            }
            else {
                if let imageData = try? Data(contentsOf: rqsturl) {
                    print("MAIN MAIN MAIN MAIN MAIN")
                    print(imageData)
                    self.ProfileImage.image = UIImage(data: imageData)
                    
                }
            }
            
        }
        task.resume()
    }
    

}

extension ProfileDetailViewController{
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    
    struct ScreenSize
    {
        static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    
    struct DeviceType
    {
        static let IS_IPHONE_5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
        static let IS_IPHONE_6 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
        static let IS_IPHONE_6P = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
        static let IS_IPHONE_X = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
    }
    
    func alert(message:String )
    {
        
        
        
        let alertview = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertview.addAction(UIAlertAction(title: "Try Again!", style: .default, handler: {
            action in
            DispatchQueue.main.async {
                
                //  self.UISetup(enable: true)
            }
        }))
        self.present(alertview, animated: true, completion: nil)
        
    }
}

extension ProfileDetailViewController {
    func handling(){
        
        DispatchQueue.main.async {
            // Async tasks
            
            guard let uid = Auth.auth().currentUser?.uid else { return }
            self.ref = Database.database().reference()
            //Going deep into firebase hierarchy
            self.handleName = self.ref?.child("user").child(uid).child("Name").observe(.value, with: { (snapshot) in
                
                if let value = snapshot.value as? String{
                    
                    
                    
                    self.preName = value
                    
                }
            })
            
            self.handleEmail = self.ref?.child("user").child(uid).child("Email").observe(.value, with: { (snapshot) in
                
                if let value = snapshot.value as? String{
                    
                    self.preEmail = value
                    
                }
                
            })
            
            self.handleImgUrl = self.ref?.child("user").child(uid).child("photoURL").observe(.value, with: { (snapshot) in
                
                if let value = snapshot.value as? String{
                    
                    self.preImgUrl = value
                    
                }
                
            })
        }
    }
    
}

extension ProfileDetailViewController {
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.UserDetails), userInfo: nil, repeats: true)
    }
    
    @objc func UserDetails(){
        
        if self.preName == "" || self.preEmail == "" || self.preImgUrl == "" {
            self.ProfileName.text = String("Name")
            self.ProfileEmail.text = String("Email")
        }
        else{
            self.ProfileName.text = self.preName
            self.ProfileEmail.text = self.preEmail
            self.ProfileImgUrl = self.preImgUrl
            self.ImportingProfileImage()
            self.timer.invalidate()
        }
        
    }
}
