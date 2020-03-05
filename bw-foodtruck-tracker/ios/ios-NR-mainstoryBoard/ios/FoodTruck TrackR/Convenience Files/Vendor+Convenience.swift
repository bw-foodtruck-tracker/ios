//
//  Vendor+Convenience.swift
//  FoodTruck TrackR
//
//  Created by patelpra on 3/1/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import Foundation
import CoreData

extension FoodVendor {
    @discardableResult convenience init(email: String, username: String, password: String, vendorTrucks: [Truck], identifier: UUID = UUID(), context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        
        self.email = email
        self.username = username
        self.password = password
        self.vendorTrucks = NSOrderedSet(object: vendorTrucks)
        self.identifier = identifier
    }
    
    convenience init(user: VendorRepresentation) {
        var trucks: [Truck] = []
        for truck in user.vendorTrucks {
            trucks.append(Truck(truck: truck))
        }
        
        self.init(username: user.username, password: user.password, email: user.email, trucksOwned: trucks)
    }
}
