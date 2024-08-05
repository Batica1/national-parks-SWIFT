//
//  LandmarkDetailView.swift
//  FavoritePlaces
//
//  Created by Domagoj Kurfürst on 23.10.2023..
//

import SwiftUI
import CoreLocation

struct ParksListView: View {
    
    @Environment(Parks.self) private var parks: Parks
   
    @Binding var selectedTab: Tabs
    
    
    @State private var sortMode: SortMode = .nameAscending
    
    enum SortMode {
        case nameAscending
        case nameDescending
    }
    
    
    
    var body: some View {
        
        NavigationStack {
            
            
            VStack {
                
                if parks.list.isEmpty {
                    //Could be any view, stack, etc. here
                    Text("Oops, looks like there's no data...")
                } else {
                    //List will go here
                    
                    List(parks.list) { park in
                        
                        NavigationLink( destination: ParkDetailView(park: park, selectedTab: $selectedTab)) {
                            ParkRow(lm: park)
                        }
                        
                    }
                    .listStyle(.plain)
                }
                
                
            } // VStack
            .toolbar{
                ToolbarItem(placement: .principal){
                    Picker("Sort by", selection: $sortMode) {
                        Text("A-Z").tag(SortMode.nameAscending)
                        Text("Z-A").tag(SortMode.nameDescending)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    .onChange(of: sortMode) { _ in
                        sortParks()
                    }
                }
            }
            
            
        }// Nav stack
        
    } // body
    
    func sortParks() {
        switch sortMode {
        case .nameAscending:
            parks.list.sort { $0.getParkName() < $1.getParkName() }
        case .nameDescending:
            parks.list.sort { $0.getParkName() > $1.getParkName() }
        }
    }
    
    func sortedParks() -> [Park] {
        switch sortMode {
        case .nameAscending:
            return parks.list.sorted { $0.getParkName() < $1.getParkName() }
        case .nameDescending:
            return parks.list.sorted { $0.getParkName() > $1.getParkName() }
        }
    }
    
} // struct


#Preview {
    ParksListView(selectedTab: .constant(.list)).environment(Parks() )
}



struct ParkRow: View {
    var lm: Park
    var locationManager = LocationManager()
    
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            
            
            Text("\(lm.getParkName())")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Distance: \(lm.getLocation().distance(from: CLLocation(latitude: lm.getLatitude() ?? 0, longitude: lm.getLongitude() ?? 0)) / 1609.34, specifier: "%.2f") miles")
                .font(.title2)
            
        }
    }
}


