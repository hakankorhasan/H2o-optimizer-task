//
//  ViewController.swift
//  Task
//
//  Created by Hakan Körhasan on 23.01.2024.
//

import UIKit

class OptimizeViewController: UIViewController {
    
    var optimizeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Try Optimized", for: .normal)
        btn.backgroundColor = .black
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    private let optimizeLabel: UILabel = {
        let label = UILabel()
        label.text = "Optimized result:"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .red
        return label
    }()
    
    private let optimizeResultLabel: UILabel = {
        let label = UILabel()
        label.text = "0.00"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let notOptimizeLabel: UILabel = {
        let label = UILabel()
        label.text = "Unoptimized result:"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .red
        return label
    }()
    
    private let notOptimizeResultLabel: UILabel = {
        let label = UILabel()
        label.text = "0.00"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let evaluationResultLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    var measurementsOptimize: [PKMeasurementOptimize] = []
    
    var measurementsNotOptimize: [PKMeasurement] = []
    
    private let viewModel = OptimizeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        labelsUI()
        
        buttonUI()
        
        // deney verileri oluşturma
        configureDataArray()
        
        // ViewModel'e closure'ları tanımlama
       setupViewModel()
        
        // buttonların aksiyonlarını ayarlama
        setupButtonActions()
        
    }
    
    private func configureDataArray() {
        // Belirli bir sayıda örnek veri oluşturuyoruz
        for i in 1...2000 {
            let measurement = PKMeasurementOptimize(
                id: "\(i)",
                type: "Temperature",
                startsAt: Date(),
                endsAt: Date(),
                results: "25C"
            )
            measurementsOptimize.append(measurement)
        }
        
        for i in 1...2000 {
            let measurement = PKMeasurement(
                id: "\(i)",
                type: "Temperature",
                startsAt: Date(),
                endsAt: Date(),
                results: "25C"
            )
            measurementsNotOptimize.append(measurement)
        }
    }
    
    private func setupViewModel() {
        
       viewModel.optimizeCompletion = { [weak self] result in
           
           if let formattedResult = self?.viewModel.formatResult(result) {
                self?.optimizeResultLabel.text = formattedResult
           }
           
           self?.updateEvaluationResultLabel()
       }

        viewModel.notOptimizeCompletion = { [weak self] result in
           
            if let formattedResult = self?.viewModel.formatResult(result) {
                 self?.notOptimizeResultLabel.text = formattedResult
            }
            
            self?.updateEvaluationResultLabel()
        }
    }

    private func setupButtonActions() {
        optimizeButton.addTarget(self, action: #selector(fetchOpt), for: .touchUpInside)
    }
    
    @objc private func fetchOpt() {
        print(measurementsOptimize.count)
        viewModel.fetchOptimizeData(measurements: measurementsOptimize)
        viewModel.fetchNotOptimizeData(measurements: measurementsNotOptimize)
        
        // The method to be used on a very large data set. for example: Millions of data...
       /* viewModel.processMeasurementsAsynchronously(measurements: measurementsOptimize) { elapsedTime in
            let calculatedElapsed = self.viewModel.formatResult(elapsedTime)
            print(calculatedElapsed)
            self.optimizeResultLabel.text = "\(calculatedElapsed)"
        }
        
        viewModel.processMeasurementsAsynchronouslyNotOptimized(measurements: measurementsNotOptimize) { elapsedTime in
            let calculatedElapsed = self.viewModel.formatResult(elapsedTime)
            self.notOptimizeResultLabel.text = "\(calculatedElapsed)"
        }*/
        
    }
    
    private func updateEvaluationResultLabel() {
        if let optimizedResultText = optimizeResultLabel.text,
           let nonOptimizedResultText = notOptimizeResultLabel.text,
           let optimizedResult = Double(optimizedResultText),
           let nonOptimizedResult = Double(nonOptimizedResultText) {

           let ratio = nonOptimizedResult / optimizedResult
           let evaluationText = String(format: "Optimized system is %.2f times faster than the non-optimized system.", ratio)
           evaluationResultLabel.text = evaluationText
        } else {
           evaluationResultLabel.text = "Optimization results are not available."
        }
    }
    
    private func labelsUI() {
        let optimizeStack = UIStackView(arrangedSubviews: [
            optimizeLabel, optimizeResultLabel
        ])
        optimizeStack.axis = .horizontal
        optimizeStack.spacing = 10
        
        let notOptimizeStack = UIStackView(arrangedSubviews: [
            notOptimizeLabel, notOptimizeResultLabel
        ])
        notOptimizeStack.axis = .horizontal
        notOptimizeStack.spacing = 10
        
        let baseStackView = UIStackView(arrangedSubviews: [
            optimizeStack, notOptimizeStack
        ])
        baseStackView.axis = .vertical
        baseStackView.spacing = 20
        
        view.addSubview(baseStackView)
        baseStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            baseStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            baseStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
        
        evaluationResultLabel.numberOfLines = 2
        view.addSubview(evaluationResultLabel)
        evaluationResultLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            evaluationResultLabel.topAnchor.constraint(equalTo: baseStackView.bottomAnchor, constant: 20),
            evaluationResultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            evaluationResultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func buttonUI() {
        
        optimizeButton.layer.cornerRadius = 12
        view.addSubview(optimizeButton)
        optimizeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            optimizeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            optimizeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            optimizeButton.heightAnchor.constraint(equalToConstant: 50),
            optimizeButton.widthAnchor.constraint(equalToConstant: 120)
        ])
        
    }
    
}


