//
//  HourlyWeather.swift
//  WeatherHunger
//
//  Created by Christopher Myers on 9/27/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit

class HourlyWeather: NSObject {
    
    var time : Int = 0
    var summaryDescription : String = ""
    var temperature : Double = 0.0
    var precipProbability : Double = 0.0
    
    override init() {
        super.init()
        
        self.time = 0
        self.summaryDescription = ""
        self.temperature = 0.0
        self.precipProbability = 0.0
        
    }


}
