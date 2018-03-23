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

    @IBOutlet weak var ScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.scrolling()
        // Do any additional setup after loading the view.
    }

      func scrolling(){
        
            self.ScrollView.contentSize = CGSize(width: self.view.bounds.width,height: 1000)
        self.loadscroll()
    }
    func loadscroll(){
        
        if let pageView = Bundle.main.loadNibNamed("post", owner: self, options: nil)?.first as? post {
           
            self.ScrollView.addSubview(pageView)
            pageView.frame.size.width = self.view.bounds.size.width
            
            
                let gradientView = EZYGradientView()
                gradientView.frame = pageView.Gview.bounds
                gradientView.firstColor = self.hexStringToUIColor(hex: "#000000")
                gradientView.secondColor = self.hexStringToUIColor(hex: "#4B0082")
                gradientView.angleº = 180.0
                gradientView.colorRatio = 0.4
                gradientView.fadeIntensity = 1.0
                gradientView.isBlur = true
                gradientView.blurOpacity = 0.5
                //self.GradientView.roundCorners(corners: [.bottomLeft], radius: 50)
                pageView.Gview.insertSubview(gradientView, at: 0)
            
            
        }
        
    }
   
}

extension ScrollPostViewController{
    
    
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
}

