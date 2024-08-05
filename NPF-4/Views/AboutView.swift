//
//  AboutView.swift
//  NPF-4
//
//  Created by Domagoj Kurfürst on 05.11.2023..
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        
        VStack{
            Spacer()
            Image(systemName: "info.circle")
                .font(.system(size: 100))
                .foregroundColor(.green)
            
            Text("National Park Finder By")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Text("Domagoj Kurfurst")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                
            Spacer()
            Text("Class project for")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(.title2)
            Text("Mobile Application Development I")
                .foregroundColor(.white)
                .fontWeight(.bold)
                .font(.title2)
            Spacer()
        }
        .background(
            Image("img")
                .resizable()
                .scaledToFill()
        )
        .overlay{
            
        }
        
    }
    
}

#Preview {
    AboutView()
}
