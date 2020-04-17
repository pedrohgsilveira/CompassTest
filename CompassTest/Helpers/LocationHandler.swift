//
//  LocationHandler.swift
//  CompassTest
//
//  Created by Pedro Henrique Guedes Silveira on 15/04/20.
//  Copyright © 2020 Pedro Henrique Guedes Silveira. All rights reserved.
//

import Foundation
import CoreLocation


class LocationHandler: NSObject, CLLocationManagerDelegate {
    
    var locationCallBack: ((CLLocation) -> ())? = nil
    var headingCallBack: ((CLLocationDirection) -> ())? = nil
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else {
            return
        }
        locationCallBack?(currentLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        headingCallBack?(newHeading.trueHeading)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
      print(" Failed to update location " + error.localizedDescription)
    }
    
    

}
