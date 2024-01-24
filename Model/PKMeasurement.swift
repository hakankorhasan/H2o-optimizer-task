//
//  PKMeasurement.swift
//  Task
//
//  Created by Hakan Körhasan on 23.01.2024.
//

import Foundation

import Foundation

public struct PKMeasurement: Codable {
    public let id : String?
    public let type : String?
    public let startsAt : Date
    public let endsAt : Date
    public let results : String
    
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
    
    public func encode(to encoder: Encoder) throws {
        let typeOrEmpty = type ?? ""
        let startDateUtc = startsAt.toString(format: .dateAndTime)
        let endDateUtc = endsAt.toString(format: .dateAndTime)
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(typeOrEmpty, forKey: .type)
        try container.encodeIfPresent(startDateUtc, forKey: .startsAt)
        try container.encodeIfPresent(endDateUtc, forKey: .endsAt)
        try container.encodeIfPresent(results, forKey: .results)
    }
    
    public init(from decoder: Decoder) throws {
           let values = try decoder.container(keyedBy: CodingKeys.self)
           id = try values.decode(String.self, forKey: .id)
           type = try values.decodeIfPresent(String.self, forKey: .type)
           startsAt = try values.decodeIfPresent(String.self, forKey: .startsAt)?.toDate() ?? Date()
           endsAt = try values.decodeIfPresent(String.self, forKey: .endsAt)?.toDate() ?? Date()
           results = try values.decodeIfPresent(String.self, forKey: .results) ?? ""
       }
    
}

