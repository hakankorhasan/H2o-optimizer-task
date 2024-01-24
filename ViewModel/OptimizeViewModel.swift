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
    
    /// The method to be used for very large data sets.
    ///  For my example, the calculation time for 1 million data sets is 5 seconds.
    func processMeasurementsAsynchronously(measurements: [PKMeasurementOptimize], completion: @escaping (String) -> Void) {
        let queue = DispatchQueue(label: "com.example.processQueue", attributes: .concurrent)
        let group = DispatchGroup()

        var elapsedTime: TimeInterval = 0.0

        queue.async(group: group) {
            let startTime = Date()

            do {
                let encodedData = try CodeableHelper.encode(measurements)

                if String(data: encodedData, encoding: .utf8) != nil {

                    let _: [PKMeasurementOptimize] = try CodeableHelper.decode(from: encodedData)

                    let endTime = Date()
                    elapsedTime = endTime.timeIntervalSince(startTime)
                } else {
                    print("JSON String conversion error")
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }

        group.notify(queue: DispatchQueue.main) {
            completion("\(elapsedTime)")
        }
    }
    
    func formatResult(_ result: String) -> String {
        
        if let doubleValue = Double(result) {
            return String(format: "%.5f", doubleValue)
        }
        
        return result
    }
}
