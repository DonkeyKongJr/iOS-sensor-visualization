//
//  SensorData.swift
//  Sensor Visualization
//
//  Created by Patrick Schadler on 29.06.18.
//  Copyright © 2018 Patrick Schadler. All rights reserved.
//

import Foundation

final class SensorData {
    let humidity: String
    let temp: String
    let timestamp: Date
    
    required init?(response: HTTPURLResponse, representation: AnyObject) {
        self.humidity = representation.value(forKeyPath: "humidity") as! String
        self.temp = representation.value(forKeyPath: "temp") as! String
        self.timestamp = representation.value(forKeyPath: "timestamp") as! Date
    }
}
