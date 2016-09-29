//
//  ViewController.swift
//  WeatherHunger
//
//  Created by Christopher Myers on 9/27/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    var dailyWeather = DailyWeather()
    
    var hourlyWeather = HourlyWeather()
    
    var isHourly = false
    
    
    // Find user location
    var locationManager = CLLocationManager()
    
    // Run API Controller
    let controller = APIController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        
        self.findUserLocation()
        
        print(locationManager.location?.coordinate.latitude)
        print(locationManager.location?.coordinate.longitude)
        
        //tableView.reloadData()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        controller.fetchWeatherData()
    }
    
    // MARK : Location Manager Custom Methods
    
    func findUserLocation() {
        let status = CLAuthorizationStatus.AuthorizedAlways
        
        if status != .Denied {
            self.locationManager.startUpdatingLocation()
            self.locationManager.requestLocation()
            //print(locationManager.location)
        
        }
    }
    
    // MARK : Location Manager Delegates
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        self.findUserLocation()
        
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error.localizedDescription)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if DataStorage.sharedInstance.numberOfDaily() != 0 {
//            self.tableView.reloadData()
//            
//            self.locationManager.stopUpdatingLocation()
//        }
        if locations.count > 0 {
            let location = locations.last
//            print(location?.coordinate.latitude)
//            print(location?.coordinate.longitude)
            
            let span = MKCoordinateSpan(latitudeDelta: 0.29, longitudeDelta: 0.29)
            if let center = location?.coordinate {
                let _ = MKCoordinateRegion(center: center, span: span)
                
                
            }
        }
        // Potentially unnecessary since not using an MapView
        
        if let loc = locationManager.location {
            print (loc.coordinate)
            
            let _ = loc.coordinate.longitude
            let _ = loc.coordinate.latitude
        }
    }
    
    
    

    // MARK : TableView Delegates & functions
    
    func reloadData() {
        self.tableView.reloadData()
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isHourly == true {
            return 5
        } else {
            return 5
        }
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("weatherCell", forIndexPath: indexPath) as! WeatherTableViewCell
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.reloadData), name: kNOTIFY, object: nil)
        
        if isHourly == true {
            if let hourly = DataStorage.sharedInstance.hourlyDataAtIndex(indexPath.row) {
                self.hourlyWeather = hourly
                
                cell.temperatureLabel.text = String(Int(hourlyWeather.temperature)) + "°"
                
                
                
                let formattedDate = NSDateFormatter()
                formattedDate.dateFormat = "h:mm a"
                let day = NSDate(timeIntervalSince1970: Double(hourlyWeather.time))
                
                
                cell.dayLabel.text = formattedDate.stringFromDate(day)
                cell.summaryLabel.text = hourlyWeather.summaryDescription
                cell.precipProbabilityLabel.text = String(hourlyWeather.precipProbability * 100) + "%"
            }
            
        } else {
            if let daily = DataStorage.sharedInstance.dailyDataAtIndex(indexPath.row) {
                self.dailyWeather = daily
                
                cell.temperatureLabel.text = String(Int(dailyWeather.temperatureMax))  + "°" + "/" + String(Int(dailyWeather.temperatureMin)) + "°"
                
                let formattedDate = NSDateFormatter()
                formattedDate.dateFormat = "MMM d"
                let day = NSDate(timeIntervalSince1970: dailyWeather.time)
                
                cell.dayLabel.text = formattedDate.stringFromDate(day)
                cell.summaryLabel.text = dailyWeather.summaryDescription
                cell.precipProbabilityLabel.text = String(dailyWeather.precipProbability * 100) + "%"
                
            }
        }
        
        
        // else 
        
        return cell
        
    }
    @IBAction func returnToMain(sender: UIStoryboardSegue) {
        self.tableView.reloadData()
    }
    
    @IBAction func weatherChanged(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            isHourly = false
            self.tableView.reloadData()
        } else {
            isHourly = true
            self.tableView.reloadData()
        }
        
    }

    @IBAction func restaurantInfoTapped(sender: UIBarButtonItem) {
        
        
        self.performSegueWithIdentifier("restaurantSegue", sender: self)
        
    }
    
    // create IBAction that returns the from Restaurant modal screen back to weather screen
}

