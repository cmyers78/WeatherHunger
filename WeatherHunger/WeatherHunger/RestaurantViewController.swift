//
//  RestaurantViewController.swift
//  WeatherHunger
//
//  Created by Christopher Myers on 9/29/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var restaurantData = Restaurant()
    let controller = APIController()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.controller.fetchRestaurants()
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadDataForRestaurants()
    }

    // set up tableViews
    
    func reloadDataForRestaurants() {
        self.tableView.reloadData()
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("foodCell", forIndexPath: indexPath) as! RestaurantTableViewCell
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.reloadDataForRestaurants), name: kNOTIFYREST, object: nil)
        
        if let hunger = DataStorage.sharedInstance.restaurantAtIndex(indexPath.row) {
            self.restaurantData = hunger
            
        }
        
        cell.restaurantNameLabel.text = self.restaurantData.name
        cell.restaurantAddressLabel.text = self.restaurantData.address
        
        return cell
    }
    
    // Create an api that writes a file which summarizes the data gathered in csv format
    func writeToDocsDirectory() {
        
        // take the first cell weather info (current weather)
        // take the three restaurants gathered
        // create a file and write as weatherSummary, rest1, rest2, rest3
        // move on to next line and repeat
        // append file to docs directory
        
        
    }

}
