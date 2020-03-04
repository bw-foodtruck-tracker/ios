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
                                        truckName: String,
                                        imageOfTruck: String,
                                        cuisineType: String,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        
        self.identifier = identifier
        self.truckName = truckName
        self.cuisineType = cuisineType
        self.customerRating = customerRating
        self.imageOfTruck = imageOfTruck
    }
}
