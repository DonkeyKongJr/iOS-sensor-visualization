//
//  ViewController.swift
//  Sensor Visualization
//
//  Created by Patrick Schadler on 29.06.18.
//  Copyright © 2018 Patrick Schadler. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func refreshDataButtonClicked(_ sender: UIButton) {
        refreshSensorData();
    }
    
    func refreshSensorData(){
        self.temperatureLabel.text = "Refresh Temp"
        self.humidityLabel.text = "Refresh Humidity"
        makeRestCall();
    }
    
    func makeRestCall(){
        let url = URL(string: "http://192.168.1.43:3000/sensordata")
        
        Alamofire.request(url!,method: .post).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
    }
}
}
