//
//  MapView.swift
//  FavoritePlaces
//
//  Created by Domagoj Kurfürst on 18.10.2023..
//

import SwiftUI
import MapKit
import _MapKit_SwiftUI


struct MapView: View {
    
    @Environment(Parks.self) private var landmarks: Parks
    
    @State private var locationManager = LocationManager()
    
    @State private var selected: Park? = nil
    
    @State private var route: MKRoute?
    
    var locationError: Bool { return locationManager.locationError }
    
    var permissionError: Bool { return locationManager.permissionError }
        
    @State private var position: MapCameraPosition = .automatic

    var location : CLLocationCoordinate2D{
        
        return locationManager.location?.coordinate ?? .lasVegas
        
    }
    
    
    
    @State private var selectedResult: MKMapItem?
    
    @State private var selectedSegment = 0
    @State private var mapSelect = [
        MapTypeSelect(title: "Standard", map: .standard),
        MapTypeSelect(title: "Satellite", map: .imagery),
        MapTypeSelect(title: "Hybrid", map: .hybrid) ]
    
    @State private var mapType: MapStyle = .standard
    
    
    var body: some View {
                    
        Map(position: $position , selection: $selected) {
            UserAnnotation()
          
            
            ForEach(landmarks.list, id: \.self) { landmark in
                
                // Marker(item: MKMapItem(placemark: MKPlacemark(coordinate: landmark.coordinate)))
                 
                 Marker(landmark.title, systemImage: "tree.circle", coordinate: landmark.coordinate)
                     .tint(.purple)

                
            }
            .annotationTitles(.hidden)
        } // Map
        .mapControls {
            MapUserLocationButton()
            MapScaleView()
        }
        
        .mapStyle(mapType)
//        .onAppear(){
//            if(landmarks.selectedPark == nil){
//                position = .camera(MapCamera(centerCoordinate: .lasVegas , distance: 2500000000))
//
//            }else{
//                position = .camera(MapCamera(centerCoordinate: landmarks.selectedPark?.coordinate ?? .lasVegas , distance: 5000))
//
//            }
//        }
        .safeAreaInset(edge: .bottom, content: {
            VStack {
                VStack(spacing: 0) {
                    if let selected {
                        
                        ItemInfoView(route: route, selectedPark: selected, position: $position )
                            
                            .frame(height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding([.top, .horizontal])
                        
                        
                    }
                } // VStack
                
                HStack{
                    Button(action: {
                        position = .camera(MapCamera(centerCoordinate: .lasVegas , distance: 2500000000))
                    }, label: {
                        Label("", systemImage: "minus.magnifyingglass")
                    })
                    .buttonStyle(.borderedProminent)
                    
                    Picker(selection: $selectedSegment, label: EmptyView()) {
                        ForEach(0 ..< mapSelect.count) {
                            Text(self.mapSelect[$0].title).tag($0)
                        }
                    
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                
                } .padding()
                    
                
                
            } // VStack
            .background(.thinMaterial)
            .onChange(of: selectedSegment){
                mapType = mapSelect[selectedSegment].map
            }
            
        })
        .onChange(of: selected) { oldValue, newValue in
            getDirections()
        }

     
       
       
    } // body
    
    func getDirections() {
        route = nil
        guard let selected else { return }
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: location))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: selected.coordinate))
        
        Task {
            let directions = MKDirections(request: request)
            let response = try? await directions.calculate()
            route = response?.routes.first
        }
    } // getDirections
    
} // MapView




extension CLLocationCoordinate2D {
    static let lasVegas = CLLocationCoordinate2D(latitude: 36.1716, longitude: -115.1391)
}


// MARK: - Device Settings
extension MapView {
    func goToDeviceSettings() {
        guard let url = URL.init(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}



