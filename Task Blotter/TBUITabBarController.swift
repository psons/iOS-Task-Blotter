//
//  TBUITabBarController.swift
//  Task Blotter Base
//
//  Created by Paul Sons on 2/22/23.
//

import UIKit

class TBUITabBarController: UITabBarController {
    
    // combine thes two into an EffortDomainAppState()
//    var effortDomain = EffortDomain(name: "Should read the user data for EffortDomain Name")
//    var appState = AppState()
    var effortDomainAppState = dummyDataEffortDomainAppState
    // EffortDomainAppState(effortDomain: EffortDomain(name: "Should read the user data for EffortDomain Name"))
    
//    override init(effortDomain: EffortDomain = EffortDomain(name: "Should read the user data for EffortDomain Name"), appState: AppState = AppState(), effortDomainAppState: EffortDomainAppState) {
//        self.effortDomain = effortDomain
//        self.appState = appState
////        self.effortDomainAppState = effortDomainAppState
//    }
    
    override func viewDidLoad() {
        print("TBUITabBarController.viewDidLoad()")
        super.viewDidLoad()
        // self.intializeEffortDomainDefaults()  will need to load some data here at some point.
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
