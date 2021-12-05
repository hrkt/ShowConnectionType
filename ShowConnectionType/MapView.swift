//
//  MapView.swift
//  ShowConnectionType
//
//  Created by Hiroki Ito on 2021/12/01.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject var locationManager = LocationManager()

    var body: some View {
        Map(coordinateRegion: $locationManager.region)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
