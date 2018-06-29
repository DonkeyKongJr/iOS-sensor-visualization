//
//  ViewController.swift
//  Sensor Visualization
//
//  Created by Patrick Schadler on 29.06.18.
//  Copyright © 2018 Patrick Schadler. All rights reserved.
//

import UIKit

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
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if let data = data {
                do {
                    // Convert the data to JSON
                    let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                    
                    if let json = jsonSerialized, let url = json["url"], let explanation = json["explanation"] {
                        print(url)
                        print(explanation)
                    }
                }  catch let error as NSError {
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
}
