//
//  DataStorage.swift
//  WeatherHunger
//
//  Created by Christopher Myers on 9/27/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit

class DataStorage: NSObject {
    
    static let sharedInstance = DataStorage()
    
    private override init() {
        
    }
    
    var hourlyArray = [HourlyWeather]()
    
    var dailyArray = [DailyWeather]()
    
    var restaurantArray = [Restaurant]()
    
    
    func numberOfHourly() -> Int {
        return self.hourlyArray.count
    }
    
    func addHourlyWeatherData(hourlyData : HourlyWeather) {
        self.hourlyArray.append(hourlyData)
    }
    
    func hourlyDataAtIndex(index : Int) -> HourlyWeather? {
        if self.hourlyArray.count >= 0 && index < self.hourlyArray.count {
            return self.hourlyArray[index]
        }
        return nil
    }
    
    func numberOfDaily() -> Int {
        return self.dailyArray.count
    }
    
    func addDailyWeatherData(dailyData : DailyWeather) {
        self.dailyArray.append(dailyData)
        print("testing")
    }
    
    func dailyDataAtIndex(index : Int) -> DailyWeather? {
        if self.dailyArray.count >= 0 && index < self.dailyArray.count {
            return self.dailyArray[index]
        }
        return nil
    }
    
    func numberOfRestaurants() -> Int {
        return self.restaurantArray.count
    }
    
    func addRestaurant(restaurant : Restaurant) {
        self.restaurantArray.append(restaurant)
    }
    
    func restaurantAtIndex(index : Int) -> Restaurant? {
        if self.restaurantArray.count >= 0 && index < self.restaurantArray.count {
            return self.restaurantArray[index]
        }
        return nil
    }


}
