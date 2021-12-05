//
//  ContentView.swift
//  ShowConnectionType
//
//  Created by Hiroki Ito on 2021/12/01.
//

import SwiftUI
import CoreTelephony

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    
    var userLatitude: String {
            return "\(locationManager.lastLocation?.coordinate.latitude ?? 0)"
        }
        
        var userLongitude: String {
            return "\(locationManager.lastLocation?.coordinate.longitude ?? 0)"
        }
    

    // get current "Radio Access Technology Constants" string
    //
    // CTRadioAccessTechnologyLTE ... 4G
    // CTRadioAccessTechnologyNRNSA ... 5G, (The 5G New Radio Non-Standalone (NRNSA) radio access technology.)
    // CTRadioAccessTechnologyNR ... 5G, (The 5G New Radio (NR) radio access technology.)
    //
    // see)
    // https://developer.apple.com/documentation/coretelephony/cttelephonynetworkinfo/radio_access_technology_constants
    var connectionType: String {
        
        // to handle updates to user's cellar provider information,
        // use "serviceSubscriberCellularProvidersDidUpdateNotifier"
        // This App shows one-time info.
        //
        // https://developer.apple.com/documentation/coretelephony/cttelephonynetworkinfo/3024512-servicesubscribercellularprovide
        //
        let info = CTTelephonyNetworkInfo()
        // iOS device may have multiple SIMS.
        // This app simply bind their service's technologies.
        var technologies = ""
        for (service, _) in info.serviceSubscriberCellularProviders ?? [:] {
            let radio = info.serviceCurrentRadioAccessTechnology?[service] ?? ""
            if (radio != "") {
               technologies += radio
            }
        }
        
        let s = technologies
        return s
    }
    
    var body: some View {
        VStack {
            MapView().frame(height:300)
            HStack {
                VStack {
                    Text("Can I catch 5G?")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                }
                VStack {
                    Text("Connection Type")
                    Divider()
                    Text(connectionType).border(Color.gray, width: 1)
                }
            }
            VStack {
                HStack {
                    Text("latitude: \(userLatitude)")
                    Text("longitude: \(userLongitude)")
                }
            }

        }
        Divider()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
