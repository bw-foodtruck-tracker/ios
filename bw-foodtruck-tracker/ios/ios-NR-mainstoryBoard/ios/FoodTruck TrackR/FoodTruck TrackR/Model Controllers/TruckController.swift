//
//  TruckController.swift
//  FoodTruck TrackR
//
//  Created by patelpra on 3/2/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import Foundation
import CoreData

class TruckController {
    
    var trucks: [TruckRepresentation] = []
    
    static let shared = TruckController()
    
    func getTrucks(with searchTerm: String?) -> [TruckRepresentation] {
        guard let searchTerm = searchTerm, !searchTerm.isEmpty else { return [] }
        
        let filteredNames = trucks.filter({(item: TruckRepresentation) -> Bool in
            let stringMatch = item.truckName.lowercased().range(of: searchTerm.lowercased())
            return stringMatch != nil ? true : false
        })
        return filteredNames
    }
    
    func createTruck(with truckName: String, imageOfTruck: String, identifier: UUID = UUID()) {
        let truck = Truck(truckName: truckName, customerRating: 0, imageOfTruck: "")
        put(truck: truck)
        saveToPersistentStore()
    }
    
}

