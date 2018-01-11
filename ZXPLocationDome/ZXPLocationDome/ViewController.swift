//
//  ViewController.swift
//  ZXPLocationDome
//
//  Created by ZXP on 2018/1/10.
//  Copyright © 2018年 ZXP. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppleLocation.sharedInstance.initLocationManager()
        self.view.backgroundColor = UIColor.yellow
        
        let pr = UILabel(frame: CGRect(x: 10, y: 10, width: 50, height: 100))
        view.addSubview(pr)
        pr.backgroundColor = UIColor.red
        let tap = UITapGestureRecognizer(target: self, action: #selector(onUserDistanceLocation))
        pr.isUserInteractionEnabled = true
        pr.addGestureRecognizer(tap)
        
        
//        YBAMapUtils.sharedInstance.setApiKey()
//        YBAMapUtils.sharedInstance.getMapView(view)
        
    }
    
    func onUserDistanceLocation() {
        
        let cloc = CLLocation(latitude: 52.104526, longitude: 51.111151)
        print(AppleLocation.sharedInstance.userDistanceLocation(cloc))
        
    }



}

