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
        makeRestCall();
    }
    
    func makeRestCall(){
        let url = URL(string: "http://192.168.1.43:3000/sensordata")
        
        Alamofire.request(url!,method: .post).responseJSON { (responseData) -> Void in
                if((responseData.result.value) != nil) {
                    let response = responseData.result.value as! NSDictionary
                    self.humidityLabel.text = String(format: "%@", response["humidity"] as! NSNumber)
                    self.temperatureLabel.text = String(format: "%@", response["temp"] as! NSNumber)
        }
    }
}
}
