//
//  DailyWeather.swift
//  WeatherHunger
//
//  Created by Christopher Myers on 9/27/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit

class DailyWeather: NSObject {
    
    // let date = NSDate(timeIntervalSince1970: 1415637900)
    
    var time : Double = 0.0
    var summaryDescription : String = ""
    var temperatureMin : Double = 0.0
    var temperatureMax : Double = 0.0
    var precipProbability : Double = 0.0
    
    override init() {
         super.init()
        
        self.time = 0.0
        self.summaryDescription = ""
        self.temperatureMin = 0.0
        self.temperatureMax = 0.0
        self.precipProbability = 0.0
        
    }
}
