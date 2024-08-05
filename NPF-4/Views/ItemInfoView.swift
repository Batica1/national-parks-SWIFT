//
//  ItemInfoView.swift
//  FavoritePlaces
//
//  Created by Domagoj Kurfürst on 18.10.2023..
//

import SwiftUI
import MapKit


struct ItemInfoView: View {
    
    var route: MKRoute?
    //var selected: Park
    var selectedPark: Park
    
  
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D.lasVegas, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))

    @State private var zoomLevel: Double = 1.0
    
   // var selectedResult: MKRoute
    
    
    
    @State private var lookaroundScene: MKLookAroundScene?
    @Binding var position: MapCameraPosition
    
    private var travelTime: String? {
        guard let route else { return nil }
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle  = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
        return formatter.string(from: route.expectedTravelTime)
    }
    
    var body: some View {
        
        VStack {
            Text("\(selectedPark.title )")
                .font(.title2)
                .fontWeight(.bold)
         
            
           if let travelTime {
               Text(travelTime).font(.title3)
           } else {
               Text("Calculating route, might not be avaliable").font(.title3)
           }


            
            HStack{
                Button(action: {
                    
                    if let url = URL(string: selectedPark.getLink()){
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                    
                }, label: {
                    Label("View Wiki", systemImage: "info.square")
                })
                .buttonStyle(.bordered)
                
                Button(action: {
                    
                    let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: selectedPark.coordinate ?? CLLocationCoordinate2D()))
                    
                    mapItem.name = selectedPark.title
                    
                    let options = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
                    
                    mapItem.openInMaps(launchOptions: options)
                    
                }, label: {
                    Label("Open in Maps", systemImage: "map")
                })
                .buttonStyle(.bordered)
                
            }
            
            
        } // VStack
        

        
    } // body
    
    
} // ItemInfoView





