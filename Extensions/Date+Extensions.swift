//
//  Date+Extensions.swift
//  Task
//
//  Created by Hakan Körhasan on 23.01.2024.
//

import Foundation

extension Date {
    
    public func toString(format: DateStyle.Format) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }
    
    public func formatToAnotherStyle(format: DateStyle.Format) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        let dateString = formatter.string(from: self)
        return formatter.date(from: dateString)
    }
    
}

extension String {
    public func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = DateStyle.Format.dateAndTime.rawValue
        return formatter.date(from: self)
    }
}

