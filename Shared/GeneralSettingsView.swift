//
//  GeneralSettingsView.swift
//  AutoClicker (macOS)
//
//  Created by Leonardo Dominguez on 4/4/21.
//

import SwiftUI
import KeyboardShortcuts

struct GeneralSettingsView: View {
    @AppStorage("showPreview") private var showPreview = true
    @AppStorage("playSound") private var playSound = true
    @AppStorage("clicksPerSecond") private var clicksPerSecond = 1.0
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        Form {
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Text("Shorcut:")
                    KeyboardShortcuts.Recorder(for: .toggleAutoClick, onChange: { newShortcut in
                        appState.shortcut = newShortcut
                    })
                }
                Toggle("Play sound when clicking", isOn: $playSound)
                Slider(value: $clicksPerSecond, in: 1...20, step: 1) {
                    Text("Clicks per second (\(clicksPerSecond, specifier: "%.0f"))")
                        .frame(width: 145, alignment: .leading)
                }
            }
            .padding()
        }
    }
}

struct GeneralSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralSettingsView().frame(width: 350, height: 200)
    }
}
