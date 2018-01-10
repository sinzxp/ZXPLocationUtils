//
//  YBAMapUtils.swift
//  YaBeiProject
//
//  Created by quickplain on 2017/9/29.
//  Copyright © 2017年 Frank. All rights reserved.
//

import UIKit

public class YBAMapUtils: NSObject, MAMapViewDelegate, AMapLocationManagerDelegate {

    
    static let sharedInstance = YBAMapUtils.init()
    private override init(){}
    
    var mapView: MAMapView!

    let defaultLocationTimeout = 6
    let defaultReGeocodeTimeout = 3
    
    var completionBlock: AMapLocatingCompletionBlock!
    lazy var locationManager = AMapLocationManager()
    
    public func setApiKey() {
        AMapServices.shared().apiKey = "6d523b515fd3392cc8d32375b8c83dcc"
        
        initCompleteBlock()
        
        configLocationManager()
        
        locAction()
        
    }
    
    public func configLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.locationTimeout = defaultLocationTimeout
        locationManager.reGeocodeTimeout = defaultReGeocodeTimeout
    }
    ///获取地理位置
    public func locAction() {
        locationManager.requestLocation(withReGeocode: true, completionBlock: completionBlock)
    }
    

    public func initCompleteBlock() {
        
        completionBlock = {(location, regeocode, error) in
            if let error = error {
                let error = error as NSError
                print("错误:{\(error.code) - \(error.localizedDescription)};")
            }
            
            if let location = location {
                
                if let regeocode = regeocode {
                    let text = "\(regeocode.formattedAddress) \n \(regeocode.citycode!)-\(regeocode.adcode!)-\(regeocode.city)市"
                    print("定位1------> \(text)")

                }
                
                let text = "lat:\(location.coordinate.latitude); lon:\(location.coordinate.longitude); accuracy:\(location.horizontalAccuracy)m; \(location.description)"
                print("定位2------> \(text)")
            }
        }
    }
    ///获取地图
    public func getMapView(_ view:UIView) {
        ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
        ///初始化地图
        ///把地图添加至view
        AMapServices.shared().enableHTTPS = true
        
        mapView = MAMapView(frame: view.bounds)
        mapView.delegate = self
        mapView.isShowsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.minZoomLevel = 10
        view.addSubview(mapView)
    }
}
