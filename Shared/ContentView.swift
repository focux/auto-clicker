//
//  ContentView.swift
//  Shared
//
//  Created by Leonardo Dominguez on 25/3/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeView()
            .frame(minWidth: 300, minHeight: 300)
            .navigationTitle("Auto Clicker")
            .toolbar(content: {
                ToolbarItemGroup(placement: .automatic) {
                    Spacer()
                    Menu {
                        Button(action: {
                            NSApp.sendAction(Selector(("showPreferencesWindow:")), to: nil, from: nil)
                        }) {
                            Label("Preferences", systemImage: "gear")
                        }
                    } label: {
                        Label("Options", systemImage: "ellipsis.circle.fill")
                    }
                }
            })
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
