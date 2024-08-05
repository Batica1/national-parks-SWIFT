//
//  NPF_4App.swift
//  NPF-4
//
//  Created by Domagoj Kurfürst on 05.11.2023..
//

import SwiftUI

@main
struct NPF_4App: App {
    
    @State private var parks = Parks()

    var body: some Scene {
        WindowGroup {
            ContentView().environment(parks)
        }
    }
}
