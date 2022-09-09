//
//  wdtDndApp.swift
//  wdtDnd
//
//  Created by Gevorg Hmayakyan on 08.09.22.
//

import SwiftUI

@main
struct wdtDndApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(width: 1300.0, height: 300.0)
        }
    }
    
}

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
}
