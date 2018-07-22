//
//  GPS.swift
//  vehsense
//
//  Created by Brian Green on 6/26/18.
//  Copyright © 2018 Weida Zhong. All rights reserved.
//

import Foundation
import CoreLocation

class GPS : NSObject , CLLocationManagerDelegate {
    
    static let shared = GPS()
    
    var isOn = false
    var isRecording = false

    let locationManager = CLLocationManager()
    
    let notificationName = Notification.Name.init(rawValue: gpsNotification)
    
    private override init() {
        super.init()
        
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
    }
    
    
    func turnOn(){
        locationManager.startUpdatingLocation()
        isOn = true
    }
    
    func turnOff(){
        locationManager.stopUpdatingLocation()
        isOn = false
    }
    
    func checkLocationServices() -> Bool{
        return CLLocationManager.locationServicesEnabled()
    }
    
    
    func isAuth() -> Bool{
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                return false
            case .authorizedAlways, .authorizedWhenInUse:
                return true
        }
        
    }
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {return}
        let data = ["location": location]
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: data)
        
        
    }
    
}
