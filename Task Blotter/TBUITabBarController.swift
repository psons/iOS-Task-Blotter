//
//  TBUITabBarController.swift
//  Task Blotter Base
//
//  Created by Paul Sons on 2/22/23.
//

import UIKit

class TBUITabBarController: UITabBarController {
    var navTarget: String = "none"
    var effortDomainAppState = dummyDataEffortDomainAppState
        
    override func viewDidLoad() {
        print("TBUITabBarController.viewDidLoad()")        
        super.viewDidLoad()
        // self.intializeEffortDomainDefaults()  will need to load some data here at some point.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doNavigation()
    }
    
    func doNavigation() {
        if self.navTarget == "GoalDetail" {
            print("TBUITabBarController wil do doNavigation() to \(self.navTarget)")
            let goalNav = self.viewControllers?[2] as! UINavigationController

            let goalVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "goal")
            // todo: build up a list of controllers here for deeper navigation cases.like [goalVC, goalObjectiveVC]

            goalNav.setViewControllers([goalVC], animated: true)  // can make longer array, and will display last.
            self.selectedViewController = goalNav  // this actualy displays the view controller after the arry is set up on prev line.
        }
        if self.navTarget == "none" {
            return
        }
    }
    
    func setNavigation(navTarget: String) {
        self.navTarget = navTarget
    }
    

    /*
    // MARK: - Navigation
     */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("in TBUITabBarController prepare for segue. self.navTarget: \(self.navTarget)")
            }

}
