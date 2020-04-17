//
//  MainViewController.swift
//  CompassTest
//
//  Created by Pedro Henrique Guedes Silveira on 15/04/20.
//  Copyright © 2020 Pedro Henrique Guedes Silveira. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var compassImageView: UIImageView!
    @IBOutlet weak var needleImageView: UIImageView!
    
    let locationHandler = LocationHandler()
    
    let locationGenerator = LocationGenerator()
    
    var latestLocation: CLLocation?
    
    var randomLocation: CLLocation?
    
    var heading: CLLocationDirection?
        
    let locationManager = CLLocationManager()
    
    var angle: CGFloat?
    
    var runCount: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLocationManager { (result) in
            if result {
                self.setupLatestLocation()
                self.generateRandomPlace()
            } else {
                print("Failed to set location")
            }
        }
        
        locationHandler.headingCallBack = { newHeading in
            
            self.angle = self.computeNewAngle(with: CGFloat(newHeading))
            self.animateCompass(with: self.angle!)            
        }
        
        let _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        
    }
    
    func setLocationManager(completionHandler: @escaping (Bool) -> ()) {
        
        locationManager.delegate = locationHandler
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        guard CLLocationManager.locationServicesEnabled() else {
            completionHandler(false)
            return
        }
        
        let status = CLLocationManager.authorizationStatus()
        guard status != .denied else { 
            completionHandler(false)
            return
        }
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
        
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        
         
        completionHandler(true)
        
    }
    
    func setupLatestLocation() {
        locationHandler.locationCallBack = { location in 
            self.latestLocation = location
        }
    }
    
    func generateRandomPlace() {
        
        let randomPlaces = locationGenerator.getMockLocationsFor(location: latestLocation ?? CLLocation())
        self.randomLocation = randomPlaces.randomElement()
    }
    
    
    func computeNewAngle(with newAngle: CGFloat) -> CGFloat {
        let heading: CGFloat = {
            
            guard let randomPlace = randomLocation else {
                return CGFloat()
            }
            
            guard let locationBearing = latestLocation?.bearingToLocationDegrees(destinationLocation: randomPlace) else {
                return CGFloat()
            }
            let originalHeading = locationBearing - newAngle.degreesToRadians
            switch UIDevice.current.orientation {
            case .faceDown: return -originalHeading
            default: return originalHeading
            }
        }()
        return CGFloat(heading)
        
    }
    
    func animateCompass(with angle: CGFloat) {
        
        UIView.animate(withDuration: 0.5) { 
            self.needleImageView.transform = CGAffineTransform(rotationAngle: angle)
        }
    }
    
    @objc func fireTimer() {
        runCount += 1
        setHaptics()
    }
    
    func setHaptics() {
        
        if runCount >= 0 && runCount < 10 {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            generator.prepare()
        }
        
        if runCount >= 10 && runCount < 20 {
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            generator.prepare()
        }
        
        if runCount >= 20 {
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            generator.prepare()
        }   
    }
    
}
