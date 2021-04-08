//
//  Utilities.swift
//  AutoClicker (macOS)
//
//  Created by Leonardo Dominguez on 7/4/21.
//
import AVFoundation
import SwiftUI

func simulateClick() {
    let dummy = CGEvent.init(source: nil)
    let loc = dummy!.location
    
    let mouseDown = CGEvent(mouseEventSource: nil, mouseType: CGEventType.leftMouseDown, mouseCursorPosition: loc, mouseButton: CGMouseButton.left)
    let mouseUp = CGEvent(mouseEventSource: nil, mouseType: CGEventType.leftMouseUp, mouseCursorPosition: loc, mouseButton: CGMouseButton.left)
    mouseDown?.post(tap: CGEventTapLocation.cghidEventTap)
    mouseUp?.post(tap: CGEventTapLocation.cghidEventTap)
}

func simulateClickWithBeep() {
    simulateClick()
    NSSound.beep()
}
