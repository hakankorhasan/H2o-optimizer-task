//
//  PKMeasurementOptimize.swift
//  Task
//
//  Created by Hakan Körhasan on 23.01.2024.
//

import Foundation


public struct PKMeasurementOptimize: Codable {
    public let id: String?
    public let type: String?
    public let startsAt: Date
    public let endsAt: Date
    public let results: String
    
    enum CodingKeys: String, CodingKey {
        case id, type, startsAt, endsAt, results
    }
        
    public init(id: String? = nil,
                type: String?,
                startsAt: Date,
                endsAt: Date,
                results: String) {
        self.id = id
        self.type = type
        self.startsAt = startsAt
        self.endsAt = endsAt
        self.results = results
    }
}

struct CodeableHelper {
    
    static func encode<T: Codable>(_ instance: T) throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(instance)
    }
    
    static func decode<T: Codable>(from data: Data) throws -> T {
        
        let decoder = JSONDecoder()
        let decodedObject = try decoder.decode(T.self, from: data)
        
        // Check if the decoded object is of type PKMeasurementOptimize and contains Date fields
        if let measurementOptimize = decodedObject as? PKMeasurementOptimize {
            
            // We can format date fields according to the type we want.
            let startsAt = measurementOptimize.startsAt.formatToAnotherStyle(format: .dateAndTime) ?? measurementOptimize.startsAt
            let endsAt = measurementOptimize.endsAt.formatToAnotherStyle(format: .dateAndTime) ?? measurementOptimize.endsAt
                
            let updatedObject = PKMeasurementOptimize(id: measurementOptimize.id, type: measurementOptimize.type, startsAt: startsAt, endsAt: endsAt, results: measurementOptimize.results)
                
            return updatedObject as! T
        }
            
        return decodedObject
    }
    
}

