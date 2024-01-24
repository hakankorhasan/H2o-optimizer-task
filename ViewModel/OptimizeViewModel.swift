//
//  OptimizeViewModel.swift
//  Task
//
//  Created by Hakan Körhasan on 23.01.2024.
//
import UIKit


class OptimizeViewModel {
    
    var optimizeCompletion: ((String) -> Void)?
    
    var notOptimizeCompletion: ((String) -> Void)?

    func fetchOptimizeData(measurements: [PKMeasurementOptimize]) {
        
        let startTime = Date()

        do {
            let encodedData = try CodeableHelper.encode(measurements)

            if String(data: encodedData, encoding: .utf8) != nil {

                let _: [PKMeasurementOptimize] = try CodeableHelper.decode(from: encodedData)

                let endTime = Date()
                let elapsedTime = endTime.timeIntervalSince(startTime)
                optimizeCompletion?("\(elapsedTime)")
            } else {
                print("JSON String conversion error")
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }

    func fetchNotOptimizeData(measurements: [PKMeasurement]) {
        let startTime = Date()

        do {
            let encodedData = try JSONEncoder().encode(measurements)

            if String(data: encodedData, encoding: .utf8) != nil {

                let _: [PKMeasurement] = try JSONDecoder().decode([PKMeasurement].self, from: encodedData)

                let endTime = Date()
                let elapsedTime = endTime.timeIntervalSince(startTime)
                notOptimizeCompletion?("\(elapsedTime)")
            } else {
                print("JSON String conversion error")
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func formatResult(_ result: String) -> String {
        
        if let doubleValue = Double(result) {
            return String(format: "%.5f", doubleValue)
        }
        
        return result
    }
}
