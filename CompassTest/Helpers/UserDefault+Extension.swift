//
//  UserDefault+Extension.swift
//  CompassTest
//
//  Created by Pedro Henrique Guedes Silveira on 15/04/20.
//  Copyright © 2020 Pedro Henrique Guedes Silveira. All rights reserved.
//

import Foundation
import CoreLocation

extension UserDefaults {
  var currentLocation: CLLocation {
    get { return CLLocation(latitude: latitude ?? 90, longitude: longitude ?? 0) } // default value is North Pole (lat: 90, long: 0)
    set { latitude = newValue.coordinate.latitude
          longitude = newValue.coordinate.longitude }
  }
    
    private var latitude: Double? {
        get {
            if let _ = object(forKey: #function) {
                return double(forKey: #function)
            }
            return nil
        }
        set {
            set(newValue, forKey: #function)
        }
    }
    
  private var longitude: Double? {
    get {
      if let _ = object(forKey: #function) {
        return double(forKey: #function)
      }
      return nil
    }
    set { set(newValue, forKey: #function) }
  }
    
}
