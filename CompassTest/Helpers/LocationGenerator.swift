//
//  LocationGenerator.swift
//  CompassTest
//
//  Created by Pedro Henrique Guedes Silveira on 16/04/20.
//  Copyright © 2020 Pedro Henrique Guedes Silveira. All rights reserved.
//


import Foundation
import CoreLocation

struct LocationGenerator {

    // create random locations (lat and long coordinates) around user's location
    func getMockLocationsFor(location: CLLocation) -> [CLLocation] {
        
        func getBase(number: Double) -> Double {
            return round(number * 1000)/1000
        }
        func randomCoordinate() -> Double {
            return Double(arc4random_uniform(140)) * 0.0001
        }
        
        let baseLatitude = getBase(number: location.coordinate.latitude - 0.007)
        let baseLongitude = getBase(number: location.coordinate.longitude - 0.008) 
        
        var items = [CLLocation]()
        for _ in 0..<10 {
            
            let randomLat = baseLatitude + randomCoordinate() 
            let randomLong = baseLongitude + randomCoordinate() 
            let location = CLLocation(latitude: randomLat, longitude: randomLong)
            
            items.append(location)
            
        }
        
        return items
    }
}
