//
//  Truck+Convenience.swift
//  FoodTruck TrackR
//
//  Created by patelpra on 2/27/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import Foundation
import CoreData

extension Truck {
    @discardableResult convenience init(identifier: UUID = UUID(),
                                        customerRating: Double,
                                        location: Location,
                                        truckName: String,
                                        imageOfTruck: String,
                                        foodType: String,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        
        self.identifier = identifier
        self.truckName = truckName
        self.foodType = foodType
        self.customerRating = customerRating
        self.location = location
        self.imageOfTruck = imageOfTruck
    }
    
    convenience init(truck: TruckRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        self.init(truckName: truck.truckName,
                  customerRating: truck.customerRating,
                  location: Location(location: truck.location),
                  imageOfTruck: truck.imageOfTruck,
                  context: context)
    }

    var truckRepresentation: TruckRepresentation? {
        guard let location = location,
            let imageOfTruck = imageOfTruck,
            let identifier = identifier,
            let truckName = truckName else { return nil }
        return TruckRepresentation(location: LocationRepresentation(longitude: location.longitude,
                                                                    latitude: location.latitude),
                                   imageOfTruck: imageOfTruck,
                                   customerRating: customerRating,
                                   truckName: truckName,
                                   identifier: identifier)
    }
}
