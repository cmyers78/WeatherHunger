//
//  DocumentsCSV.swift
//  WeatherHunger
//
//  Created by Christopher Myers on 9/29/16.
//  Copyright © 2016 Dragoman Developers, LLC. All rights reserved.
//

import UIKit

class DocumentsCSV: NSObject {
    
    var newLine : String = ""
    
    override init() {
        self.newLine = ""
        
    }
    
    //initialize with weather info, and restaurant names
    // self.newline = "weatherinfo param, rest1 param, rest2 param, rest3 param
    
    
    // Create an api that writes a file which summarizes the data gathered in csv format
    
    func writeToFile(content: String, fileName: String) {
        
        let contentToAppend = content+"\n"
        //NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let filePath = NSHomeDirectory() + "/Documents/" + fileName
        
        //Check if file exists
        if let fileHandle = NSFileHandle(forWritingAtPath: filePath) {
            //Append to file
            fileHandle.seekToEndOfFile()
            fileHandle.writeData(contentToAppend.dataUsingEncoding(NSUTF8StringEncoding)!)
        }
        else {
            //Create new file
            do {
                try contentToAppend.writeToFile(filePath, atomically: true, encoding: NSUTF8StringEncoding)
            } catch {
                print("Error creating \(filePath)")
            }
        }
    }

        // take the first cell weather info (current weather)
        // take the three restaurants gathered
        // create a file and write as weatherSummary, rest1, rest2, rest3
        // move on to next line and repeat as location changes.
        // append file to docs directory
        



}
