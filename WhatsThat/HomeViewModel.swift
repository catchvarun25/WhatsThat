//
//  HomeViewModel.swift
//  WhatsThat
//
//  Created by Varun Mehta on 31/5/24.
//

import Foundation
import UIKit

protocol HomeViewModelProtocol: ObservableObject {
    var predictionText: String? { get set }
    func makePrediction(_ image: UIImage)
}

class HomeViewModel: HomeViewModelProtocol {
    @Published var predictionText: String?
    
    let imagePredictor = ImagePredictor()
    
    //MARK: - Public Methods -
    func makePrediction(_ image: UIImage) {
        classifyImage(image)
    }
    
    // MARK: - Image prediction methods -
    /// Sends a photo to the Image Predictor to get a prediction of its content.
    /// - Parameter image: A photo.
    private func classifyImage(_ image: UIImage) {
        do {
            try self.imagePredictor.makePredictions(for: image,
                                                    completionHandler: imagePredictionHandler)
        } catch {
            print("Vision was unable to make a prediction...\n\n\(error.localizedDescription)")
        }
    }
    
    /// The method the Image Predictor calls when its image classifier model generates a prediction.
    /// - Parameter predictions: An array of predictions.
    /// - Tag: imagePredictionHandler
    private func imagePredictionHandler(_ predictions: [ImagePredictor.Prediction]?) {
        guard let predictions = predictions else {
            return
        }

        let formattedPredictions = formatPredictions(predictions)
        let predictionString = formattedPredictions.joined(separator: "\n")
        predictionText = predictionString
    }

    /// Converts a prediction's observations into human-readable strings.
    /// - Parameter observations: The classification observations from a Vision request.
    /// - Tag: formatPredictions
    private func formatPredictions(_ predictions: [ImagePredictor.Prediction]) -> [String] {
        // Vision sorts the classifications in descending confidence order.
        let topPredictions: [String] = predictions.prefix(Constants.kPredictionCountToShow).map { prediction in
            var name = prediction.classification

            // For classifications with more than one name, keep the one before the first comma.
            if let firstComma = name.firstIndex(of: ",") {
                name = String(name.prefix(upTo: firstComma))
            }

            return "\(name) - \(prediction.confidencePercentage)%"
        }

        return topPredictions
    }

}

extension HomeViewModel {
    private enum Constants {
        static let kPredictionCountToShow: Int = 2
    }
}
