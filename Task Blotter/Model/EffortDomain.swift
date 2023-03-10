//
//  EffortDomain.swift
//  Task Blotter Base
//
//  Created by Paul Sons on 2/21/23.
//

import Foundation


let defaultMaxObjectives = 3
let defaultMaxTasks = 1


enum StatusVal: String, Codable {
    case abandoned = "abandoned"
    case completed = "completed"
    case scheduled = "scheduled"
    case in_progress = "in progress"
    case unfinished = "unfinished"
    case todo = "todo"
    var state: String { return self.rawValue }
}


class Task: Codable, CustomStringConvertible {
    var status: StatusVal = .todo
    var name: String
    var detail = ""
    let tid: String
    var description: String {
        return "{Task} |status:\(status)|name: \(name)|detail: \(detail)|tid: \(tid)|"
    }

    init(status: StatusVal, name: String, detail: String) {
        self.status = status
        self.name = name
        self.detail = detail
        self.tid = "Need to implement tid in init"
    }
}

// Objective replaces Story in the class model.
class Objective: Codable, CustomStringConvertible {
    var name: String
    var maxTasks = defaultMaxTasks
    let oid: String
    var tasks: [Task] = []
    var description: String {
        let heading = "{Objective} |maxTasks:\(maxTasks)|name: \(name)|oid: \(oid)|\n"
        var tasksAsStr = ""
        for task in tasks {
            tasksAsStr += "\t\t\t\(task)\n"
        }
        return heading + tasksAsStr
    }

    
    init(name: String, maxTasks: Int = defaultMaxTasks) {
        self.name = name
        self.maxTasks = maxTasks
        self.oid = "Need to implement oid in init"
    }

    func addTask(task: Task) {
        self.tasks.append(task)
    }

}


class Goal: Codable, CustomStringConvertible {
    static let defaultOslot = 0
    let _id: String
    var name = ""
    var maxObjectives = 3
    let gid: String
    var objectives: [Objective] = []
    var description: String {
        let heading = "{Goal} |_id: \(_id)|name: \(name)|maxObjectives: \(maxObjectives)|gid: \(gid)|\n"
        var objectivesAsStr = ""
        for objective in objectives {
            objectivesAsStr += "\t\(objective)\n"
        }
        return heading + objectivesAsStr
    }

    init(name: String, maxObjectives: Int = defaultMaxObjectives, createDefaultObjective: Bool = false) {
        self._id = "Need to implement _id in init"
        self.name = name
        self.maxObjectives = maxObjectives
        self.gid = "Need to implement gid in init"
        if createDefaultObjective {
            self.objectives.append(Objective(name: "default objective"))
        }
    }

    func addObjective(objective: Objective) {
        self.objectives.append(objective)
    }

    func objectiveStrings() -> String {
        var sList = ""
        for objective in self.objectives {
            sList += "\t\t\(objective)\n"
        }
        return sList
    }
    
}

/**
 An effort domain refers to the context that a person will use to prioritize time and efort use,
 plus the goals within that context.
 A persons goals and priorities, for example are different during work hours than they are outside of work.
 */
class EffortDomain: Codable, CustomStringConvertible {
    static let defaultGSlot = 0
    var name = ""
    var todoMaxTasks = defaultMaxTasks
    var goals: [Goal] = []
    var description: String {
        let heading = "{EffortDomain} |name:\(name)|todoMaxTasks: \(todoMaxTasks)|\n"
        var goalsAsStr = ""
        for goal in goals {
            goalsAsStr += "\t\(goal)\n"
        }
        return heading + goalsAsStr
    }
    
    init(name: String, todoMaxTasks: Int = defaultMaxTasks) {
//        print("EfortDomain.init goals.count: \(self.goals.count)")
        self.goals.append(Goal(name: "default goal", createDefaultObjective: true))
        self.name = name
        self.todoMaxTasks = todoMaxTasks
//        self.addGoal(goal: Goal(name: "default goal", createDefaultObjective: true))
//        print("EfortDomain.init goals: \(goals)")
    }
    
    func addGoal(goal: Goal){
        self.goals.append(goal)
    }
}

class AppState: Codable, CustomStringConvertible {
    var currentGSlot = EffortDomain.defaultGSlot  // index of an goal that will be used if none provided when creatig an Objective
    var currentOSlot = Goal.defaultOslot  // index of Objective that will be used if none provided when creatig a task.
    //var currentTslot = 0
    var description: String {
        return "Appstate slots (G,O) (\(currentGSlot),\(currentOSlot))"
    }
}


/**
 State Rules:
 1 - an EffortDomain always has a default Goal
 2 - the default Goal in an EffortDomain always has a default Objective.
 3 - Goals other than the default Goal in an Effort Domain may be empty, having no Objectives
 4 - Objectives may be empty, having no Tasks.
 
 in the future, the default goal and Objective may change so that a user can put new Objectives and Tasks in with Siri, and set where they go.
 */
class EffortDomainAppState: Codable, CustomStringConvertible {
    var effortDomain = EffortDomain(name:"un specified name")
    var appState = AppState()
    
//    /**
//     Initialize the with the EffortDomain, and use the default appState of 0, 0
//     */
//    init(effortDomain: inout EffortDomain) {
//
//        // appState handled by initializer
//        self.effortDomain = effortDomain
//
//        // make sure there is a current goal or default Goal
//        if !self.effortDomain.goals.indices.contains(self.appState.currentGSlot){
//            print("Error in EffortDomainAppState.init().   EffortDomain is supposed to always have a default goal")
//        }
//        // now can use self.currentGoal
//
//        if !self.currentGoal.objectives.indices.contains(Goal.defaultOslot) {
//            self.currentGoal.objectives[Goal.defaultOslot] = Objective(name: "default objective")
//        }
//
//    }

    init(effortDomain: inout EffortDomain, appState: inout AppState) {
        self.effortDomain = effortDomain
        self.appState = appState
        
        // make sure appState points at a Goal
        if !self.effortDomain.goals.indices.contains(self.appState.currentGSlot){
            print("Error in EffortDomainAppState.init(). AppState currentGSlot does not agree with EffortDomain. ")
            print("\t Forcing AppState to appState.currentGSlot EffortDomain.defaultGSlot")
            self.appState.currentGSlot = EffortDomain.defaultGSlot
        }
        // now can use self.currentGoal

        /**
         todo Need some test scenarios for this when user can manipulate appState current Goal and Objective with Siri
         `and when task adding is supported.`
         */
        if !self.currentGoal.objectives.indices.contains(appState.currentOSlot) {
            print("Error in EffortDomainAppState.init(). AppState currentOSlot does not agree with EffortDomain. ")
            print("\t Appending to currentGoal.objectives")
            self.currentGoal.objectives.append(Objective(name: "default objective"))
            self.appState.currentOSlot = self.currentGoal.objectives.count
        }
    }
    
    var description: String {
        var headline = "{EffortDomainAppState} |currentGoal-name: \(self.currentGoal.name)|"
        headline += "currentObjective-name: \(self.currentObjective.name)|"
        let bodyLines = "\n\(self.appState.description)\n\(self.effortDomain.description)"
        return headline + bodyLines
    }

    var currentGoal: Goal {
        get {return effortDomain.goals[appState.currentGSlot]}
    }

    var currentObjective: Objective {
        get {return effortDomain.goals[appState.currentGSlot].objectives[appState.currentOSlot]}
    }
    
    /**
     not supporting maxTasks here because a case where maxTasks is provided, probably won't use the defaut current location
     */
    func addObjective(name: String) {
        self.currentGoal.addObjective(objective: Objective(name: name))
    }
}

