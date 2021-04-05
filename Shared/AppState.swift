//
//  AppState.swift
//  AutoClicker (macOS)
//
//  Created by Leonardo Dominguez on 4/4/21.
//
import Foundation
import KeyboardShortcuts

class AppState: ObservableObject {
    @Published var shortcut: KeyboardShortcuts.Shortcut?
    
    init() {
        shortcut = KeyboardShortcuts.getShortcut(for: .toggleAutoClick)
    }
}
