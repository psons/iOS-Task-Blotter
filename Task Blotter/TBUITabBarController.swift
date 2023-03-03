//
//  TBUITabBarController.swift
//  Task Blotter Base
//
//  Created by Paul Sons on 2/22/23.
//

import UIKit

class TBUITabBarController: UITabBarController {
    
    var effortDomain = EffortDomain(name: "Should read the user data for EffortDomain Name")
    var appState = AppState()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.intializeEffortDomainDefaults()
    }
    
    
    func intializeEffortDomainDefaults() {

        let defaultEndeavor = Endeavor(name: "default")
        self.effortDomain.addEndeavor(endeavor: defaultEndeavor)
        
        let tempObjective = Objective(name: "temp objective to replace with user input")
        self.effortDomain.endeavors[0].addObjective(objective: tempObjective)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
//    override func restoreUserActivityState(_ activity: NSUserActivity) {
//        print("TBUITabBarController.restoreUserActivityState()")
//        print("\t customize prepare(for segue... to pass in the activity: NSUserActivity ")
//    }

}
