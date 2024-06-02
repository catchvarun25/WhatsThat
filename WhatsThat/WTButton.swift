//
//  WTButton.swift
//  WhatsThat
//
//  Created by Varun Mehta on 31/5/24.
//

import SwiftUI

struct WTButton: View {
    var title: String?
    var leftIcon: String?
    var rightIcon: String?
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                if let leftIcon = leftIcon {
                    Image(systemName: leftIcon)
                        .foregroundColor(.blue)
                }
                if let title = title {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
                }
                if let rightIcon = rightIcon {
                    Image(systemName: rightIcon)
                        .foregroundColor(.white)
                }
            }
            .padding()
        }
    }
}
