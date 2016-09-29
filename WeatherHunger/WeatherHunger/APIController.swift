//
//  APIController.swift
//  WeatherHunger
//
//  Created by Christopher Myers on 9/27/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit

class APIController: NSObject {
    
    let token = "d47e0d371b59ef8e979861e24d10f186"
    
    let latitude = 33.792499999999997
    let longitude = -84.323999999999998
    
    let session = NSURLSession.sharedSession()
    
    // add string parameter for any location...
    
    func fetchWeatherData() {
        
        let urlString = "https://api.darksky.net/forecast/d47e0d371b59ef8e979861e24d10f186/33.792499999999997,-84.323999999999998"
        
        if let url = NSURL(string: urlString) {
            
            let task = session.dataTaskWithURL(url, completionHandler: {
                (data, response, error) in
                
                if error != nil {
                    print(error?.localizedDescription)
                    return
                }
                
                if let jsonDictionary = self.parseJSON(data) {
                    print(jsonDictionary)
                    
                    // create a jsonArray from the jsonDictionary
                    
                    
                    if let hourlyDict = jsonDictionary["hourly"] as? JSONDictionary {
                        
                        print(hourlyDict)
                        
                        if let dataArray = hourlyDict["data"] as? JSONArray {
                            
                            print(dataArray)
                            
                            for dataDict in dataArray {
                                
                                let hourlyWeatherData = HourlyWeather()
                                
                                if let summary = dataDict["summary"] as? String {
                                    hourlyWeatherData.summaryDescription = summary
                                } else {
                                    print("I could not parse summary")
                                }
                                
                                if let temp = dataDict["temperature"] as? Double {
                                    hourlyWeatherData.temperature = temp
                                } else {
                                    print("I could not parse temperature")
                                }
                                
                                if let time = dataDict["time"] as? Int {
                                    hourlyWeatherData.time = time
                                } else {
                                    print("I could nto parse the time")
                                }
                                
                                if let precipProb = dataDict["precipProbability"] as? Double {
                                    hourlyWeatherData.precipProbability = precipProb
                                } else {
                                    print("I could not parse the precipitation")
                                }
                                
                                // append to an array
                                DataStorage.sharedInstance.addHourlyWeatherData(hourlyWeatherData)
                                
                                
                            }
                        }
                        
                    }
                        
                    if let dailyDict = jsonDictionary["daily"] as? JSONDictionary {
                        print(dailyDict)
                        
                        if let dataArray = dailyDict["data"] as? JSONArray {
                            
                            print(dataArray)
                            
                            for dataDict in dataArray {
                                
                                let dailyWeatherData = DailyWeather()
                                
                                if let summary = dataDict["summary"] as? String {
                                    dailyWeatherData.summaryDescription = summary
                                    
                                } else {
                                    print("I could not parse summary")
                                }
                                
                                if let time = dataDict["time"] as? Double {
                                    dailyWeatherData.time = time
                                } else {
                                    print("I could not parse the time")
                                }
                                
                                if let tempMin = dataDict["temperatureMin"] as? Double {
                                    dailyWeatherData.temperatureMin = tempMin
                                } else {
                                    print("I could not parse the tempMin")
                                }
                                
                                if let tempMax = dataDict["temperatureMax"] as? Double {
                                    dailyWeatherData.temperatureMax = tempMax
                                } else {
                                    print("I coudl not parse the tempMax")
                                }
                                
                                if let precipProb = dataDict["precipProbability"] as? Double {
                                    dailyWeatherData.precipProbability = precipProb
                                    print(dailyWeatherData.precipProbability)
                                } else {
                                    print("I could not parse the precipitation probability")
                                }
                                
                                // append model to an array
                                DataStorage.sharedInstance.addDailyWeatherData(dailyWeatherData)
                            }
                            
                            
                        }
                    }
                        dispatch_async(dispatch_get_main_queue() , {
                     NSNotificationCenter.defaultCenter().postNotificationName(kNOTIFY, object: nil)
                    })
                    
                } else {
                    print("I could not parse the dictionary")
                }
            })
                task.resume()
        } else {
            print("Not a valid url \(urlString)")
        }
    }
    
    // location string must be: ("xx.xxxxx,-xx.xxxx") format
    // add location string parameter after testing.
    func fetchRestaurants() {
        let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=33.792499999999997,-84.323999999999998&radius=1000&key=AIzaSyBwcr7URkxBOGP_YrC-e61a6I2qTjeyMII&keyword=restaurants"
        
        if let url = NSURL(string: urlString) {
            
            let task = session.dataTaskWithURL(url, completionHandler: {
                (data, response, error) in
                
                if error != nil {
                    print(error?.localizedDescription)
                    return
                }
                
                if let jsonDictionary = self.parseJSON(data) {
                    
                    print(jsonDictionary)
                    
                    if let resultsArray = jsonDictionary["results"] as? JSONArray {
                        
                        for infoDict in resultsArray {
                            
                            let restaurantData = Restaurant()
                            
                            if let name = infoDict["name"] as? String {
                                restaurantData.name = name
                            } else {
                                print("I could not parse the restaurant")
                            }
                            
                            if let address = infoDict["vicinity"] as? String {
                                restaurantData.address = address
                            } else {
                                print("I could not parse the restaurant")
                            }
                            
                            // append model to DataStorage
                            
                            DataStorage.sharedInstance.addRestaurant(restaurantData)
                        }
                        
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), {
                    NSNotificationCenter.defaultCenter().postNotificationName(kNOTIFYREST, object: nil)
                    })
                    
                } else {
                    print("I could not parse the dictionary")
                }
                
            })
            
            task.resume()
            
        } else {
            print("Not a valid urlString")
        }

    }
    
    func parseJSON(data : NSData?) -> JSONDictionary? {
        var theDictionary : JSONDictionary? = nil
        
        if let data = data {
            do {
                if let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? JSONDictionary {
                    theDictionary = jsonDictionary
                } else {
                    print("I could not parse jsonDictionary")
                }
            } catch {
                
            }
        } else {
            print("Could not unwrap data")
        }
        return theDictionary
    }
}
