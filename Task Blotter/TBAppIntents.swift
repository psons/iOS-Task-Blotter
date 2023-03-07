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
//        UIApplication.
        // UIApplication.shared.windows.first?.rootViewController.
        // downcast to my custom tabbar.
        // set index on tab bar controller.
        
        // 'windows' was deprecated in iOS 15.0: Use UIWindowScene.windows on a relevant window scene instead
        //let tbc = UIApplication.shared.windows.first?.rootViewController as! TBUITabBarController
//        let tbc = UIApplication.shared.
//        let tbc = UIWindowScene.  .windows.first as! TBUITabBarController // .root //.first?.rootViewController as! TBUITabBarController
        //UIApplication.shared.windows.first?.rootViewController. // setView
        let tbc = UIApplication.shared.windows.first?.rootViewController as! TBUITabBarController
        tbc.selectedIndex = 2
        // .tabBarController.selectedIndex = 1
        
        print(UIApplication.shared)
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
        //todo similar to above, but pass data to the tab bar.
        return .result(value: "Added the Objective" )
    }
    
}

struct ViewDefaultGoalIntent: AppIntent {   // go to the goal via nav controller so i have contect
                                        // and prove I can go past the tab bar inexes
    static var title: LocalizedStringResource = "View the Default Goal"
    
    static var description = IntentDescription("Views the Goal where new Objectives and Tasks will be created in the Task Blotter App")

    static var openAppWhenRun = true
    
    @MainActor
    func perform() async throws -> some IntentResult {
        print("ViewDefaultGoalIntent invoked")
        let tbc = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow?.rootViewController as! TBUITabBarController
//        let tbc = UIApplication.shared.windows.first?.rootViewController as! TBUITabBarController
        tbc.setNavigation(navTarget: "GoalDetail")
        tbc.doNavigation()
        
        return .result(value: "Launched to the default Goal" )
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

        AppShortcut(
            intent: ViewDefaultGoalIntent(), phrases: [
                "View Default Goalin \(.applicationName)",
                "View a Goal  \(.applicationName)",
                "View my Goal \(.applicationName)"])
    }
}


