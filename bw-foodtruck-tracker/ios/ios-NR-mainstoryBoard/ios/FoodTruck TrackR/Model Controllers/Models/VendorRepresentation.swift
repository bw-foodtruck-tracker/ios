//
//  VendorRepresentation.swift
//  FoodTruck TrackR
//
//  Created by patelpra on 3/2/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import Foundation

class VendorRepresentation: Codable, Equatable {
    
    var username: String
    var password: String
    var email: String
    var vendorTrucks: [TruckRepresentation]
    var identifier: UUID
    
    init(username: String, password: String, email: String, vendorTrucks: [TruckRepresentation], identifier: UUID) {
        self.username = username
        self.password = password
        self.email = email
        self.vendorTrucks = vendorTrucks
        self.identifier = identifier
    }
    
    


    static func == (lhs: VendorRepresentation, rhs: VendorRepresentation) -> Bool {
        return lhs.username == rhs.username &&
            lhs.password == rhs.password &&
            lhs.email == rhs.email &&
            lhs.identifier == rhs.identifier
    }
}
