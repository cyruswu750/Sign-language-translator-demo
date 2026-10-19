//
//  CameraTestApp.swift
//  CameraTest
//
//  Created by Cyrus Wu on 2023/8/10.
//

import SwiftUI



@main
struct CameraTestApp: App {
    init() {
        // 在应用启动时尝试获取accessToken
        TokenManager.shared.fetchAccessToken { token, error in
            if let tokenValue = token {
                print("Access token fetched: \(tokenValue)")
            } else {
                print("Error fetching access token: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
        
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
