//
//  TBUIGoalControllerViewController.swift
//  Task Blotter
//
//  Created by Paul Sons on 3/4/23.
//

import UIKit

class TBUIGoalControllerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var goals: [Goal] = []
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GoalCell", for: indexPath) as! TBUIGoalCell
        
        let goal = self.goals[indexPath.row]
        
        cell.goalNameTextField.text = goal.name
        cell.goalTopObjectivesTextField.text = "Fill in Top Objectives"
        
        return cell
    }
    

    
    @IBOutlet weak var goalListingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.goals = useEffortDomainAppStateRef().effortDomain.goals
        print("TBUIGoalControllerViewController.viewDidLoad()")
        for goal in self.goals {
            print("\t\(goal.name) has objectives.count: \(goal.objectives.count)")
        }
      
        goalListingTableView.dataSource = self
        goalListingTableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    // This will be common to my TabBarController children, so maybe a base class?
    func useParentTBC() -> TBUITabBarController {
        if let taskBlotterTabBarViewController = tabBarController as? TBUITabBarController {
            return taskBlotterTabBarViewController
        } else {
            assertionFailure("Error This class should be a subclass of TBUITabBarController")
            return TBUITabBarController()
        }
    }

    // This will be common to my TabBarController children, so maybe a base class?

    /**
            access the data and application state from the root controller.
     */
    func useEffortDomainAppStateRef() -> EffortDomainAppState {
        return self.useParentTBC().effortDomainAppState
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
  

}
