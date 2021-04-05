//
//  SettingsView.swift
//  AutoClicker (macOS)
//
//  Created by Leonardo Dominguez on 4/4/21.
//

import SwiftUI


struct SettingsView: View {
    private enum Tabs: Hashable {
        case general, advanced
    }
    
    var body: some View {
        TabView {
            GeneralSettingsView()
                .tabItem {
                    Label("General", systemImage: "gear")
                }
                .tag(Tabs.general)
        }
        .padding(20)
        .frame(width: 350, height: 200)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
