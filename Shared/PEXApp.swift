//
//  PEXApp.swift
//  Shared
//
//  Created by PEXAVC on 7/18/22.
//

import SwiftUI
import Granite

@main
struct PEXApp: App {
    #if os(iOS)
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    #elseif os(macOS)
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    #endif
    
    let pubDidFinishLaunching = NotificationCenter.default
        .publisher(for: NSNotification.Name("nyc.stoic.Quill.DidFinishLaunching"))
    
    var body: some Scene {
        WindowGroup {
            #if os(iOS)
            Home()
            #elseif os(macOS)
            EmptyComponent()
            .onReceive(pubDidFinishLaunching) { _ in
                GraniteNavigationWindow.backgroundColor = NSColor(Color.background)
                
                GraniteNavigationWindow.shared.addWindow(id: "main",
                                                         title: "",
                                                         style: .init(size: .init(width: 900,
                                                                                  height: 600), minSize: .init(width: 900, height: 600), styleMask: .resizable),
                                                         isMain: true) {
                    Home()
                        .background(Color.background)
                }
            }
            #endif
        }
    }
    
    static func expandWindow(close: Bool = false) {
        #if os(macOS)
        if close {
            GraniteNavigationWindow.shared.updateWidth(720, id: "main")
        } else {
            GraniteNavigationWindow.shared.updateWidth(1200, id: "main")
        }
        #endif
    }
}
struct EmptyComponent: GraniteComponent {
    struct Center: GraniteCenter {
        
        struct State: GraniteState {
            
        }
        
        @Store var state: State
    }
    
    @Command var center: Center
}

extension EmptyComponent: View {
    var view: some View {
        ZStack {
            Text("Quill")
        }
    }
}
