//
//  AutoClickerApp.swift
//  Shared
//
//  Created by Leonardo Dominguez on 25/3/21.
//

import SwiftUI
import KeyboardShortcuts

@main
struct AutoClickerApp: App {
    @StateObject var appState: AppState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .onReceive(NotificationCenter.default.publisher(for: NSApplication.willUpdateNotification), perform: { _ in
                    hideZoomButton()
                })
        }
        .windowToolbarStyle(UnifiedCompactWindowToolbarStyle())
        .windowStyle(HiddenTitleBarWindowStyle())
        Settings {
            SettingsView().environmentObject(appState)
        }
    }
}
