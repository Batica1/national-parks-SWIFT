//
//  Landmarks.swift
//  FavoritePlaces
//
//  Created by Domagoj Kurfürst on 25.10.2023..
//

import Foundation
import CoreLocation

@Observable

class Parks {
    var list: [Park] = []
    var selectedPark : Park? = nil
    init() {
        //load data
        if let path = Bundle.main.path(forResource: "data", ofType: "plist") {
                    
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let tempDict = try PropertyListSerialization.propertyList(from: data, format: nil) as! [String:Any]
                print("\(String.init(describing: tempDict))")
                let tempArray = tempDict["parks"]! as! Array<[String:Any]>
                
                var tempLandmarks: [Park] = []
                for dict in tempArray {
                    print("\(dict)")
                    let parkName = dict["parkName"]! as! String
                    let parkLocation = dict["parkLocation"]! as! String
                 
                    let imageLink = dict["imageLink"]! as! String
                    let dateFormed = dict["dateFormed"]! as! String
                    let latitude = Double(dict["latitude"]! as! String)!
                    let longitude = Double(dict["longitude"]! as! String)!
                    let location = CLLocation(latitude: latitude, longitude: longitude)
                    
                    let imageName = dict["imageName"]! as! String
                    let link = dict["link"]! as! String
                    let area = dict["area"]! as! String
                    let parkDescription = dict["description"]! as! String
                    
                    
                    
                    let p = Park(parkName: parkName, parkLocation: parkLocation, dateFormed: dateFormed, area: area, link: link, location: location, imageLink: imageLink, parkDescription: parkDescription, imageName: imageName, latitude: latitude,longitude: longitude)
                   
                    
                    tempLandmarks.append(p)
                }
                
                            
                //check to see if the landmarks were created correctly
                print("There are \(tempLandmarks.count) parks")
                print("\(tempLandmarks)")

                list = tempLandmarks.sorted { $0.getParkName() < $1.getParkName() }
                
                print("List: \(list)")
            } catch {
                print(error)
            }
        }
    }
}
