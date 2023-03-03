//
//  TBAppIntents.swift
//  Task Blotter
//
//  Created by Paul Sons on 3/2/23.
//

import Foundation
import AppIntents
import UIKit  // needed to access UIApplication

struct StartTaskBlotterIntent: AppIntent {
    static var title: LocalizedStringResource = "Start Task Blotter"

    static var description = IntentDescription("Launches the Task Blotter App.")
    
    static var openAppWhenRun = true
    
    @MainActor
    func perform() async throws -> some IntentResult {
        print("StartTaskBlotterIntent.perform()")
        // What do I do here to control navogation
        let service = UIApplication.shared.delegate as! AppDelegate
        guard let tabBarController = service.inputViewController?.view as! UITabBarController?
        else {  // todo -  a little code clean up around guard.
            print("Problem in StartTaskBlotterIntent")
            return .result()  //return LocalizedStringResource(stringLiteral: "0")
        }
        tabBarController.selectedIndex = 1
        return .result()  //.finished
    }
}


// build Intent into a shortcut.
struct TaskBlotterShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: StartTaskBlotterIntent(), phrases: [
                "Start \(.applicationName)",
                "Launch \(.applicationName)",
                "Launch My Goal App \(.applicationName)"])
    }
}
