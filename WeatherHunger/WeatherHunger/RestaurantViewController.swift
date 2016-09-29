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


}
