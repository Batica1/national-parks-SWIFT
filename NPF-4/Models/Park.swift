//
//  Park.swift
//  NPF-2
//
//  Created by Domagoj Kurfürst on 11.10.2023..
//

import Foundation
import UIKit
import CoreLocation

class Park: NSObject,Identifiable {
    
    private var parkName : String = ""
    private var parkLocation : String = ""
    private var dateFormed : String = ""
    
    private var area : String = ""
    private var link : String = ""
    
    private var location : CLLocation?
    private var imageLink : String = ""
    private var parkDescription : String = ""
    
    private var imageName : String = ""
    
    private var latitude : Double = 0.0
    private var longitude : Double = 0.0
    
    
    func getLatitude() -> Double
    {
        return self.latitude
    }
    func setLatitude( latitude: Double) {
        self.latitude = latitude
    }
    
    func getLongitude() -> Double
    {
        return self.longitude
    }
    
    func setLongitude(longitude: Double) {
        self.longitude = longitude
    }
    
    //park name
    func getParkName() -> String{
        return parkName
    }
    
    func set(parkName : String){
        let withoutWhiteSpace = parkName.trimmingCharacters(in: .whitespaces)
        if (parkName.count >= 3 && parkName.count <= 75 && !withoutWhiteSpace.contains("")){
            self.parkName = parkName
        }else {
          self.parkName = "TBD"
          print("Bad value of \(parkName) in set(parkName): setting to TBD")
        }
    }
    
    //park location
    func getParkLocation() -> String{
        return parkLocation
    }
    
    func set(parkLocation : String){
        let withoutWhiteSpace = parkLocation.trimmingCharacters(in: .whitespaces)

        if (parkLocation.count >= 3 && parkLocation.count <= 75 && !withoutWhiteSpace.contains("")){
            self.parkLocation = parkLocation
        }else {
           self.parkLocation = "TBD"
           print("Bad value of \(parkLocation) in set(parkLocation): setting to TBD")
        }
        
    }
    
    //ImageLink
    func getImageLink() -> String{
        return imageLink
    }
    
    func set(imageLink : String){
        self.imageLink = imageLink
    }
    
    //ImageName
    func getImageName() -> String{
        return imageName
    }
    
    func set(imageName : String){
        self.imageName = imageName
    }
    
    //DateFormed
    func getDateFormed() -> String{
        return dateFormed
    }
    
    func set(dateFormed : String){
        self.dateFormed = dateFormed
    }
    
    //area
    func getArea() -> String{
        return area
    }
    
    func set(area : String){
        self.area = area
    }
    
    //area
    func getLink() -> String{
        return link
    }
    
    func set(link : String){
        self.link = link
    }
    
    func getLocation() -> CLLocation! {
        return location
    }
    
    func set( location : CLLocation){
        self.location = location
    }
    
    //description
    override var description: String {
        return """
                parkName: \(parkName)
                parkLocation: \(parkLocation)
                dateFormed: \(dateFormed)
                area: \(area)
                link: \(link)
                location: \(String(describing: location ?? nil))
                imageLink: \(imageLink)
                parkDescription: \(parkDescription)
                imageName: \(imageName)\n
                
                """
    }
    
    //constructor
    init(parkName: String, parkLocation: String, dateFormed: String, area: String, link: String,
         location: CLLocation?, imageLink: String, parkDescription: String , imageName: String , latitude: Double,longitude: Double) {
        
         super.init()
        
         self.set(parkName : parkName)
         self.set(parkLocation : parkLocation)
        
         self.dateFormed = dateFormed
         self.area = area
         self.link = link
         self.location = location
         self.imageLink = imageLink
         self.parkDescription = parkDescription
        self.imageName = imageName
        
     }
    
    var coordinate: CLLocationCoordinate2D {
        return location!.coordinate
    }

    var title: String {
        return parkName
    }

    var subtitle: String {
        return parkLocation
    }
    
    
       
    convenience override init() {
        
        self.init(parkName: "Unknown", parkLocation: "Unknown", dateFormed: "Unknown", area: "Unknown", link: "Unknown" , location : nil , imageLink: "Unknown" , parkDescription: "Unknown" , imageName: "Unknown", latitude:0.0, longitude: 0.0)
       }
    
    
    
    
    
} //end of class

extension Park {
    static func all() -> [Park] {
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
                    
                  
                    
                    let p = Park(parkName: parkName, parkLocation: parkLocation, dateFormed: dateFormed, area: area, link: link, location: location, imageLink: imageLink, parkDescription: parkDescription , imageName: imageName , latitude: latitude, longitude: longitude)
                   
                    
                    tempLandmarks.append(p)
                }
                            
                //check to see if the landmarks were created correctly
                print("There are \(tempLandmarks.count) landmarks")
                print("\(tempLandmarks)")

                return tempLandmarks.sorted { $0.getParkName() < $1.getParkName() }

            } catch {
                print(error)
            }
        }
        return []

    } //all
}


