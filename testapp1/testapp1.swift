//
//  testapp1App.swift
//  testapp1
//
//  Created by Raheem Chisman on 3/2/25.
//

import SwiftUI

@main
struct testapp1App: App {
    //Adding AppDelegate
@UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
