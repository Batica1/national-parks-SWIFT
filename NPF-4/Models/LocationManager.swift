//
//  LocationManager.swift
//  FavoritePlaces
//
//  Created by Domagoj Kurfürst on 16.10.2023..
//

import Foundation
import CoreLocation
import SwiftUI

@Observable
class LocationManager: NSObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    var location: CLLocation? = nil
    var locationError = false
    var permissionError = false
    
    
    override init() {
        super.init()
        
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.requestWhenInUseAuthorization()
            }
        }
        
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    } // init
    
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            permissionError = false
            return
        case .restricted:
            permissionError = true
            return
        case .denied:
            permissionError = true
            return
        case .authorizedAlways:
            permissionError = false
            return
        case .authorizedWhenInUse:
            permissionError = false
            return
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("ERROR: \(error.localizedDescription)")
        locationError = true
    }
} // LocationManager
