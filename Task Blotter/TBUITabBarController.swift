//
//  TBUITabBarController.swift
//  Task Blotter Base
//
//  Created by Paul Sons on 2/22/23.
//

import UIKit

class TBUITabBarController: UITabBarController {
    var navTarget: String = "none"
    var effortDomainAppState =  EffortDomainAppState(effortDomain: EffortDomain(name: "Users Endeavors") , appState: AppState())
        
    override func viewDidLoad() {
        print("TBUITabBarController.viewDidLoad()")        
        super.viewDidLoad()
        // self.intializeEffortDomainDefaults()  will need to load some data here at some point.
        
        initDataState(dataState: .normal)
        
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
    
    func loadData() {
        DomainStore.load { result in
            switch result {
            case .failure(let error):
                fatalError(error.localizedDescription)
            case .success(let domainData):
                self.effortDomainAppState.effortDomain = domainData
            }
        }
    }

    func saveData() {
        DomainStore.save(domain: self.effortDomainAppState.effortDomain) { result in
            if case .failure(let error) = result {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    func emptyData() -> EffortDomainAppState {
        return EffortDomainAppState(effortDomain: EffortDomain(name: "Users Endeavors") , appState: AppState())
    }
    
    func initDataState(dataState: DataState) {
        switch dataState {
        case .clear: // this is really dangerous for a real app.  Disable this after some testing.
            effortDomainAppState =  emptyData()
            saveData()
            fallthrough
        case .testdata: // this is really dangerous for a real app.  Disable this after some testing.
            effortDomainAppState = dummyDataEffortDomainAppState
            saveData()
            fallthrough
        case .normal:
            loadData()
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
