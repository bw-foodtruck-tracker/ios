//
//  CustomerController.swift
//  FoodTruck TrackR
//
//  Created by patelpra on 3/1/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

enum NetworkError: Error {
    case encodingError
    case badResponse
    case otherError(Error)
    case noData
    case decodeError
    case noAuth
    case invalidError
}

let baseURL = URL(string: "https://foodtruck-####.firebaseio.com/")! // Need correct URL

class CustomerController {
    
    var user: CustomerRepresentation?
    var token: String?
    
    typealias CompletionHandler = (Error?) -> Void
    
    static let shared = CustomerController()
    
    func register(user: CustomerSignup, completion: @escaping(NetworkError?) ->  Void) {
        let requestURL = baseURL
            .appendingPathComponent("Customer")
            .appendingPathComponent(user.username)
            .appendingPathComponent("json")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        do {
            let customerRepresent = CustomerRepresentation(username: user.username,
                                                           password: user.password,
                                                           email: user.email,
                                                           favoriteTrucks: [],
                                                           identifier: UUID())
            request.httpBody = try jsonEncoder.encode(customerRepresent)
        } catch { print("Error encoding user: \(error)"); completion(.encodingError); return }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 201 && response.statusCode != 200 {
                print(response.statusCode)
                completion(.badResponse)
                return
            }
            
            if let error = error {
                NSLog("Error signing up: \(error)")
                completion(.otherError(error))
                return
            }
            
            guard let data = data else {
                completion(.noData)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(CustomerRepresentation.self, from: data)
                self.user = result
                self.token = result.password
                completion(nil)
            } catch {
                NSLog("Could not decode object: \(error)")
                completion(.decodeError)
            }
            
        }.resume()
    }
    
    func logout() {
        user = nil
        token = nil
    }
    
    func logIn(user: CustomerLogin, completion: @escaping(NetworkError?) -> Void) {
        
        let requestURL = baseURL.appendingPathComponent("Consumer")
            .appendingPathComponent(user.username)
            .appendingPathExtension("json")
        
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 201 && response.statusCode != 200 {
                NSLog("Response status code is not 200 or 201. Status code: \(response.statusCode)")
                completion(.badResponse)
                return
            }
            
            if let error = error {
                NSLog("Error verifying user: \(error)")
                completion(.otherError(error))
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from data task")
                completion(.noData)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let result = try jsonDecoder.decode(CustomerRepresentation.self, from: data)
                self.user = result
                self.token = result.password
                completion(nil)
            } catch {
                NSLog("Error decoding data/token: \(error)")
                completion(.decodeError)
                return
            }
        }.resume()
    }
    
    func addFavoriteTruck(truck: TruckRepresentation) {
        
    }
    
    func saveToPersistentStore() {
        do {
            try CoreDataStack.shared.mainContext.save()
        } catch {
            NSLog("Error saving managed object context: \(error)")
        }
    }
}
