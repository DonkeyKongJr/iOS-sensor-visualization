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
    @IBOutlet weak var timestampLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.makeRestCall();
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
              
                    if(self.checkJsonResponse(data: response)){
                        self.setLabelData(data: response)
                    }
            }
        }
    }
    
    func setLabelData(data: NSDictionary){
        self.humidityLabel.text = self.getFormattedValue(number: data["humidity"] as! NSNumber) + " %";
        self.temperatureLabel.text = self.getFormattedValue(number: data["temp"] as! NSNumber) + " °C";
        self.timestampLabel.text = self.UTCToLocal(date: data["timestamp"] as! String)
    }
    
    func checkJsonResponse(data: NSDictionary) -> Bool{
        if (data["humidity"] == nil || data["temp"] == nil || data["timestamp"] == nil ) {
            return false
        } else {
            return true
        }
    }
    
    func getFormattedValue(number: NSNumber) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.roundingMode = .up
        
        return String(describing: formatter.string(from: number)!)
    }
    
    func UTCToLocal(date:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "hh:mm:ss a"
        
        return dateFormatter.string(from: dt!)
    }
}
