//
//  File.swift
//  ShowConnectionType
//
//  Created by Hirioki Ito on 2021/12/01.
//
// based on Giuseppe Sapienza's answer in StackOverflow
// https://stackoverflow.com/questions/57681885/how-to-get-current-location-using-swiftui-without-viewcontrollers

import Foundation
import CoreLocation
import Combine
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {

    private let locationManager = CLLocationManager()
    @Published var lastLocation: CLLocation?
    @Published var region = MKCoordinateRegion()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // should handle Auth in prod.code
        locationManager.requestWhenInUseAuthorization()
        // It's better to call this after authorization passed.
        // This App is for testing purpose, simply call it here.
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lastLocation = location
        // print(#function, location)
        locations.last.map {
            let center = CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            region = MKCoordinateRegion(center: center, span: span)
        }
    }
}

