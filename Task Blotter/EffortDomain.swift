//
//  EffortDomain.swift
//  Task Blotter Base
//
//  Created by Paul Sons on 2/21/23.
//

import Foundation

let defaultMaxObjectives = 3
let defaultMaxTasks = 1


class AppState {
    var currentESlot = 0  // index of an endeavor that will be used if none provided when creatig an Objective
    //var currentOSlot = 0  // index of Objective that will be used if none provided when creatig a task.
    //var currentTslot = 0
}

enum StatusVal: String {
    case abandoned = "abandoned"
    case completed = "completed"
    case scheduled = "scheduled"
    case in_progress = "in progress"
    case unfinished = "unfinished"
    case todo = "todo"
    var state: String { return self.rawValue }
}

/**
 String conversion: https://stackoverflow.com/questions/60733662/swift-how-to-i-define-a-special-method-for-my-class-that-returns-a-string-repr
 */
class Task: CustomStringConvertible {
    var status: StatusVal = .todo
    var name: String
    var detail = ""
    var description: String {
        return "|Task| status: \(self.status), name: \(self.name), detail: \(self.detail)"
    }
    
    init(status: StatusVal, name: String, detail: String) {
        self.status = status
        self.name = name
        self.detail = detail
    }
}


// Objective replaces Story in the class model.
class Objective: CustomStringConvertible {
    var name: String
    var maxTasks = defaultMaxTasks
    var tasks: [Task] = []
    var description: String {
        let headline = "|Objective| name: \(self.name), maxTasks: \(self.maxTasks)"
        var tList = ""
        for task in self.tasks {
            tList += "\t\t\(task)\n"
        }
        return headline + "\n" + tList
    }
    
    init(name: String, maxTasks: Int = defaultMaxTasks) {
        self.name = name
        self.maxTasks = maxTasks
    }

    func addTask(task: Task) {
        self.tasks.append(task)
    }

}


class Endeavor: CustomStringConvertible {
    var name = ""
    var maxObjectives = 3
    var objectives: [Objective] = []
    var description: String {
        let headline = "|Endeavor| name:\(name) maxObjectives: \(self.maxObjectives)"
        return headline + "\n" + objectiveStrings()
    }
        
    init(name: String, maxObjectives: Int = defaultMaxObjectives) {
        self.name = name
        self.maxObjectives = maxObjectives
    }

    func addObjective(objective: Objective) {
        self.objectives.append(objective)
    }


    func objectiveStrings() -> String {
        var sList = ""
        for objective in self.objectives {
            sList += "\t\(objective)\n"
        }
        return sList
    }
    
}

class EffortDomain: CustomStringConvertible {
    var name = ""
    var sprintMaxTasks = defaultMaxTasks
    var endeavors: [Endeavor] = []
    var description: String {
        let headline = "|EffortDomain| name:\(name) sprintMaxTasks: \(sprintMaxTasks) "
        var eList = ""
        for endevor in self.endeavors {
            eList += "\t\(endevor)\n"
        }
        return headline + "\n" + eList
    }
    
    init(name: String, sprintMaxTasks: Int = defaultMaxTasks) {
        self.name = name
        self.sprintMaxTasks = sprintMaxTasks
    }
    
    func addEndeavor(endeavor: Endeavor){
        self.endeavors.append(endeavor)
    }
}
