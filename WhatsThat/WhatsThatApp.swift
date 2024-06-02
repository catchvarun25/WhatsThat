//
//  WhatsThatApp.swift
//  WhatsThat
//
//  Created by Varun Mehta on 31/5/24.
//

import SwiftUI

@main
struct WhatsThatApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(HomeViewModel())
        }
    }
}
