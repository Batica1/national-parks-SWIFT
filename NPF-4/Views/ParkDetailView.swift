//
//  LandmarkDetailView.swift
//  FavoritePlaces
//
//  Created by Domagoj Kurfürst on 23.10.2023..
//

import SwiftUI
import MapKit

struct ParkDetailView: View {
    
    var park: Park
    @Binding var selectedTab: Tabs
    
    @State private var showNameInfo = false
    @State private var showLocationInfo = false
    //    @State private var showCoordInfo = false
    var mapView: MapView!
    let lighterGray = Color.gray.opacity(0.2)
    
    @Environment(Parks.self) private var landmarks: Parks

    var body: some View {
        Form {
            Section(content: {
                Text(park.getParkName())
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                
                Text(park.getArea())
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                
                Text("Date formed: \(park.getDateFormed())")
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                
                
            })
            
            Section(content: {
                AsyncImage(url: URL(string: "\(park.getImageLink())"))
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                    
            })
            
            Section(){
                Button("\(park.getLink())", action: {
                    if let url = URL(string: park.getLink()){
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                })
                .fontWeight(.bold)
                .foregroundColor(.blue)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            }
            
            Section(){
                Button("Show on map", action: {
                    
                        
//                    MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: park.getLatitude(), longitude: park.getLongitude()), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
//                    
                    landmarks.selectedPark = park
                    selectedTab = .map
                })
                
                .fontWeight(.bold)
                .foregroundColor(.blue)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            }
            
        
            

        } //Form
        .navigationBarTitle("\(park.getParkName())")
       
        
    } //body
    
}


//#Preview {
//    ParkDetailView(park: Park.all().first!, selectedTab: .constant(.list))
//}



