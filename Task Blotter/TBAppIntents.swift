//
//  TBAppIntents.swift
//  Task Blotter
//
//  Created by Paul Sons on 3/2/23.
//

import Foundation
import AppIntents
import UIKit  // needed to access UIApplication

func getTBRootController() -> TBUITabBarController {
    return (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow?.rootViewController as! TBUITabBarController
}

struct StartTaskBlotterIntent: AppIntent {
    static var title: LocalizedStringResource = "Start Task Blotter"
    static var description = IntentDescription("Launches the Task Blotter App.")
    static var openAppWhenRun = true
    
    @MainActor
    func perform() async throws -> some IntentResult {
        print("StartTaskBlotterIntent.perform()")
        let tbc = getTBRootController()
        tbc.selectedIndex = 2
        return .result()  //.finished
    }
}

struct TaskBlotterDataLoad: AppIntent {
    static var title: LocalizedStringResource = "Start Task Blotter With Test Data Load"
    static var description = IntentDescription("Launches the Task Blotter Appand load test data.")
    static var openAppWhenRun = true
    
    @MainActor
    func perform() async throws -> some IntentResult {
        print("TaskBlotterDataLoad.perform()")
        let tbc = getTBRootController()
        tbc.initDataState(dataState: .testdata)
        tbc.selectedIndex = 2
        print("TaskBlotterDataLoad tbc.effortDomainAppState!: \(Unmanaged.passUnretained(tbc.effortDomainAppState!).toOpaque())")
        return .result()  //.finished
    }
}

/**
 This intent demnstrates that the data store can be cleared by calling into the bundle from a shortcut without
 loading the viewcontrollers.
 It saves an empty default Effort Domain via the DomainStore class.
 */
struct TaskBlotterDataClear: AppIntent {
    static var title: LocalizedStringResource = "Start Task Blotter and Clear the data"
    static var description = IntentDescription("Launches the Task Blotter Appand load test data.")
    static var openAppWhenRun = false  // <---- Won't launch app, load ViewControllers.
    
    func perform() async throws -> some IntentResult {
        print("TaskBlotterDataClear.perform()")
        DomainStore.save(domain: DomainStore().domain ) { result in
            if case .failure(let error) = result {
                fatalError(error.localizedDescription)
            }
        }
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

/**
go to the goal via nav controller so i have context
and prove I can go past the tab bar inexes
 */
struct ViewDefaultGoalIntent: AppIntent {
    static var title: LocalizedStringResource = "View the Default Goal"
    static var description = IntentDescription("Views the Goal where new Objectives and Tasks will be created in the Task Blotter App")
    static var openAppWhenRun = true
    
    @MainActor
    func perform() async throws -> some IntentResult {
        print("ViewDefaultGoalIntent invoked")
        let tbc = getTBRootController()
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
        
        AppShortcut(
            intent: TaskBlotterDataLoad(), phrases: [
                "Load and Persist Task Blotter Data \(.applicationName)"])

        AppShortcut(
            intent: TaskBlotterDataClear(), phrases: [
                "Clear Persisted Task Blotter Data \(.applicationName)"])

    }
}


