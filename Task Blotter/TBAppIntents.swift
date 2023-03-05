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
        // What do I do here to control navigation to a tab in the tabbar controller?
        // UIApplication.share
        return .result()  //.finished
    }
}

struct AddObjectiveIntent: AppIntent {
    static var title: LocalizedStringResource = "Add an objective in the Task Blotter App"
    
    static var description = IntentDescription("Adds an objective underneath the current goal in the Task Blotter App")
    
    @Parameter(title: "Name of the Objective")
    var name: String    // not non-optional will have Sire assure that it is provided.
    
    func perform() async throws -> some IntentResult {
        print("AddObjectiveIntent has parameter 'name' from the user \(name)")
        return .result(value: "Added the Objective" )
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
        
        AppShortcut(
            intent: AddObjectiveIntent(), phrases: [
                "Add Objective to \(.applicationName)",
                "Add Story to  \(.applicationName)",
                "Add Grouping of tasks to \(.applicationName)"])
    }
}


