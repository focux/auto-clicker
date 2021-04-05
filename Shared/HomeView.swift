//
//  HomeView.swift
//  AutoClicker
//
//  Created by Leonardo Dominguez on 25/3/21.
//

import SwiftUI
import Combine
import KeyboardShortcuts
import AVFoundation

let systemSoundID: SystemSoundID = 1016

struct BlueButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.system(size: 22, weight: .bold, design: .default))
            .padding(16)
            .background(Color(.textBackgroundColor))
            .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
            .shadow(color: Color(#colorLiteral(red: 0, green: 0.5217629075, blue: 1, alpha: 1)).opacity(0.3), radius: 20, x: 0, y: 10)
            .opacity(configuration.isPressed ? 0.7 : 1)
    }
}

struct HomeView: View {
    @State private var enabled = false
    @AppStorage("secondsInterval") private var secondsInterval = 1.0
    @AppStorage("playSound") private var playSound = true
    @AppStorage("clicksPerSecond") private var clicksPerSecond = 1.0
    @State private var timer: Publishers.Autoconnect<Timer.TimerPublisher>? = nil
    @EnvironmentObject var appState: AppState
    
    private var shortcut = KeyboardShortcuts.getShortcut(for: .toggleAutoClick)?.description
    
    func handleClick() {
        enabled.toggle()
        
        if enabled {
            timer = Timer.publish(every: secondsInterval, on: .main, in: .common).autoconnect()
            
            timer = timer!.upstream.autoconnect()
        } else {
            timer!.upstream.connect().cancel()
        }
    }
    
    func click() {
        let dummy = CGEvent.init(source: nil)
        let loc = dummy!.location
        
        let mouseDown = CGEvent(mouseEventSource: nil, mouseType: CGEventType.leftMouseDown, mouseCursorPosition: loc, mouseButton: CGMouseButton.left)
        let mouseUp = CGEvent(mouseEventSource: nil, mouseType: CGEventType.leftMouseUp, mouseCursorPosition: loc, mouseButton: CGMouseButton.left)
        mouseDown?.post(tap: CGEventTapLocation.cghidEventTap)
        mouseUp?.post(tap: CGEventTapLocation.cghidEventTap)
    }
    
    var content: some View {
        VStack {
            Button(action: handleClick) {
                HStack {
                    Image(systemName: enabled ? "stop.circle.fill" : "play.circle.fill")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    Spacer()
                    Text(enabled ? "Stop" : "Start")
                }.frame(width: 90)
            }
            .buttonStyle(BlueButtonStyle())
            
            if enabled {
                if let shortcutText = appState.shortcut?.description {
                    Text("Or press \(shortcutText) to stop")
                        .font(.subheadline)
                        .padding(20)
                }
            } else {
                if let shortcutText = appState.shortcut?.description {
                    Text("Or press \(shortcutText) to start")
                        .font(.subheadline)
                        .padding(20)
                }
            }
        }
        .frame(minWidth: 300, minHeight: 300)
    }
    
    var body: some View {
        if timer != nil {
            content
                .onReceive(timer!) { time in
                    if !self.enabled {
                        self.timer!.upstream.connect().cancel()
                    } else {
                        for i in 1...Int(self.clicksPerSecond) {
                            print("clickkk #\(i) \(self.clicksPerSecond)")
                            if self.playSound {
                                NSSound.beep()
                            }
                            click()
                        }
                        
                    }
                }
        } else {
            content
                .onAppear {
                    KeyboardShortcuts.onKeyUp(for: .toggleAutoClick) {
                        handleClick()
                    }
                }
        }
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
