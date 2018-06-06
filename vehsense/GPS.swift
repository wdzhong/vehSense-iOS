//
//  GPS.swift
//  vehsense
//
//  Created by Jalil Sarwari on 6/4/18.
//  Copyright © 2018 Weida Zhong. All rights reserved.
//

import Foundation
import CoreLocation

class GPS: FileSystem{
    let locationManager = CLLocationManager()
    
    func Go(){
        //This is what should happen when the go button is clicked
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        self.createTxtFile()
        self.writeToTxt()
    }
    
    func Stop(){
        locationManager.stopUpdatingLocation()
    }
    
    func writeToTxt(){
        let speed = locationManager.location?.speed.description
        let latitude = locationManager.location?.coordinate.latitude.description
        let longitude = locationManager.location?.coordinate.longitude.description
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"//formats the time into the format we want
        let dateTime = formatter.string(from: Date())//saves the current time from Date()
        write(dateTime + " \t ", to: "/gps.txt", FileSystem.folderDestination)
        write(formatter.string(from: Date()) + " \t ",to: "/gps.txt" , FileSystem.folderDestination)
        write(latitude! + " \t ",to: "/gps.txt" , FileSystem.folderDestination)
        write(longitude! + " \t ",to: "/gps.txt" , FileSystem.folderDestination)
        write(speed! +  " \n",to: "/gps.txt" , FileSystem.folderDestination)
    }
    
    func createTxtFile(){
        guard let writePath = NSURL(fileURLWithPath: FileSystem.rootFolder).appendingPathComponent(FileSystem.folderDestination) else { return }
        let file = writePath.appendingPathComponent("gps.txt")
        let titleString = "timestamp, \t system_time, \t  \t lat, \t \t  lon, \t \t speed, \t bearing, \t provider"
        do {
            try "\(titleString)\n".write(to: file, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print(error)
        }
    }
}
