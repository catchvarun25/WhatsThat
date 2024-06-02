//
//  HomeView.swift
//  WhatsThat
//
//  Created by Varun Mehta on 31/5/24.
//

import SwiftUI

struct HomeView<ViewModel: HomeViewModelProtocol>: View {
    @StateObject private var viewModel: ViewModel
    @State private var selectedImage: UIImage?
    @State private var isPhotoPickerPresented: Bool = false
    
    init(_ viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    var body: some View {
        NavigationView{
            VStack {
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                    if let text = viewModel.predictionText {
                        Text(text)
                            .padding()
                            .foregroundColor(.black)
                    }
                } else {
                    Text("No Image Selected")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .navigationBarTitle("From Image", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    WTButton(leftIcon: "camera") {
                        isPhotoPickerPresented = true
                    }
                }
            }
        }
        .sheet(isPresented: $isPhotoPickerPresented) {
            PhotoPicker(selectedImage: $selectedImage, isPresented: $isPhotoPickerPresented)
        }
        .onChange(of: selectedImage) { newValue in
            if let image = newValue {
                viewModel.makePrediction(image)
            }
        }
    }
}
