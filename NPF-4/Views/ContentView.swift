//
//  ContentView.swift
//  NPF-3
//
//  Created by Domagoj Kurfürst on 19.10.2023..
//

import SwiftUI
import CoreLocation
import MapKit


enum Tabs: Hashable {
    case list
    case map
    case about
}

struct ContentView: View {
    
    @Environment(Parks.self) var parks: Parks
    @State private var selectedTab = Tabs.list
    
    @State var parksNPF3: [Park] = []
    
    init() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.systemBlue,             .font: UIFont(name: "ArialRoundedMTBold", size: 35)!]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.systemRed,
             .font: UIFont(name: "ArialRoundedMTBold", size: 20)!]
    

        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    
            
    }

    
    var body: some View {
        
        
        TabView(selection: $selectedTab) {
            
            MapView()
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
                }
                .tag(Tabs.map)
            
            
            ParksListView(selectedTab: $selectedTab)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Parks")
                }
                .tag(Tabs.list)
            
            
            AboutView()
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("About")
                }
                .tag(Tabs.about)
            
        } // TabView
        
        
    } // body
} // contentView


#Preview {
    ContentView().environment(Parks())
}
