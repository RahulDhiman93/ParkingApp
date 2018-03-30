//
//  ScrollPostViewController.swift
//  Parker
//
//  Created by Rahul Dhiman on 21/03/18.
//  Copyright © 2018 Rahul Dhiman. All rights reserved.
//

import UIKit
import EZYGradientView
import RKPieChart

class ScrollPostViewController: UIViewController {

    
    let picker = UIDatePicker()
    let pickerCat = UIPickerView()
    
    @IBOutlet weak var ScrollView: UIScrollView!
    var PostPinString:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.scrolling()
        
        // Do any additional setup after loading the view.
    }

      func scrolling(){
        
        if DeviceType.IS_IPHONE_5 {
            self.ScrollView.contentSize = CGSize(width: self.view.bounds.width,height: 780)
        }
        else{
            self.ScrollView.contentSize = CGSize(width: self.view.bounds.width,height: 1000)
            
        }
        self.loadscroll()
    }
    func loadscroll(){
        
        if let pageView = Bundle.main.loadNibNamed("post", owner: self, options: nil)?.first as? post {
           
            self.ScrollView.addSubview(pageView)
            
            
            
            
                pageView.frame.size.width = self.ScrollView.bounds.size.width
           
            
                let gradientView = EZYGradientView()
            if DeviceType.IS_IPHONE_6P{
                gradientView.frame = CGRect(x:0 ,y:0 ,width: pageView.Gview.bounds.size.width+40,height: pageView.Gview.bounds.size.height)
            }
            else{
                gradientView.frame = pageView.Gview.bounds
                
            }
            
                gradientView.firstColor = self.hexStringToUIColor(hex: "#000000")
                gradientView.secondColor = self.hexStringToUIColor(hex: "#4B0082")
                gradientView.angleº = 180.0
                gradientView.colorRatio = 0.4
                gradientView.fadeIntensity = 1.0
                gradientView.isBlur = true
                gradientView.blurOpacity = 0.5
                //self.GradientView.roundCorners(corners: [.bottomLeft], radius: 50)
                pageView.Gview.insertSubview(gradientView, at: 0)
            
            pageView.PlaceOfferButton.addTarget(self, action: #selector(ScrollPostViewController.FinalSUb(sender:)), for: .touchUpInside)
            
            self.createDatePicker()
        }
        
    }
    
    func createDatePicker()
    {
        
          if let pageView = Bundle.main.loadNibNamed("post", owner: self, options: nil)?.first as? post {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
            print("IM INNTEXT IM IN TEXT IM IN TET")
        //setting up DONE button in toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        
        pageView.TimeRegion.inputAccessoryView = toolbar
        pageView.TimeRegion.inputView = picker
        
        picker.datePickerMode = .time
        }
    }
    
    @objc func donePressed(){
          if let pageView = Bundle.main.loadNibNamed("post", owner: self, options: nil)?.first as? post {
        
        // Date Format settings
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .medium
        let dateString = formatter.string(from: picker.date)
        
        
        UIView.transition(with: (pageView.TimeRegion)!,
                          duration: 1.0,
                          options: .transitionCrossDissolve,
                          animations: { [weak self] in
                            pageView.TimeRegion.text = "\(dateString)"
            }, completion: nil)
        
        self.view.endEditing(true)
        }
    }
    
}

extension ScrollPostViewController{
    
    @objc func FinalSUb (sender: UIButton){
        print("BALLE BALLE BALLE BALLE BALLE")
    }
    
    func roundCorner(_ rView:UIView){
        rView.layer.cornerRadius = rView.bounds.size.width/2
        rView.clipsToBounds = true
    }
    
    
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
         
        }))
        self.present(alertview, animated: true, completion: nil)
        
    }
}



