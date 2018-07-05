//
//  SensorDataChart.swift
//  Sensor Visualization
//
//  Created by Patrick Schadler on 05.07.18.
//  Copyright © 2018 Patrick Schadler. All rights reserved.
//

import UIKit
import SwiftChart
import Firebase
import FirebaseFirestore

class SensorDataChartController: UIViewController {
    @IBOutlet weak var lineChart: Chart!
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.lineChart.minY = 0
         self.lineChart.maxY = 40
        self.getDataFromFirestore();
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    func getDataFromFirestore(){
        let db = Firestore.firestore()
        var temperatures = [Double]()
        
        db.collection("sensordata").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    
                    let data = document.data() as! NSDictionary
                    temperatures.append(data["temperature"] as! Double)
                }
                let series = ChartSeries(temperatures)
                self.lineChart.add(series)
            }
        }
    }
}
