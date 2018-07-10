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
    var db : Firestore!
    @IBOutlet weak var lineChart: Chart!
    @IBOutlet weak var humidityChart: Chart!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addNavigationBar()
        self.initFirestore()
        self.setChartMetaData()
        self.getDataFromFirestore()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setChartMetaData(){
        self.lineChart.minY = 0
        self.lineChart.maxY = 40
        self.humidityChart.minY = 0;
        self.humidityChart.maxY = 100;
    }

    func getDataFromFirestore() {
        let db = Firestore.firestore()
        var temperatures = [Double]()
        var humidities = [Double]()
        
        db.collection("sensordata").order(by: "timestamp", descending: true).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    if(temperatures.count >= 24){
                        break
                    }
                    
                    let data = document.data() as NSDictionary
                    temperatures.append(data["temperature"] as! Double)
                    humidities.append(data["humidity"] as! Double)
                }
                
                let series = ChartSeries(temperatures)
                self.lineChart.add(series)
                self.lineChart.yLabelsFormatter = { String(Int($1)) +  "ºC" }
                self.lineChart.xLabelsFormatter = { String(Int(round($1)))}
                
                let humiditySeries = ChartSeries(humidities)
                self.humidityChart.add(humiditySeries)
                self.humidityChart.yLabelsFormatter = { String(Int($1)) +  "%" }
                self.humidityChart.xLabelsFormatter = { String(Int(round($1)))}
            }
        }
    }
    
    private func addNavigationBar(){
        let height: CGFloat = 75
        let statusBarHeight = UIApplication.shared.statusBarFrame.height;
        let navbar = UINavigationBar(frame: CGRect(x: 0, y: statusBarHeight, width: UIScreen.main.bounds.width, height: height))
        navbar.backgroundColor = UIColor.white
        navbar.delegate = self as? UINavigationBarDelegate
        
        let navItem = UINavigationItem()
        navItem.title = "Sensor Data"
        navItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(dismissViewController))
        
        navbar.items = [navItem]
        
        view.addSubview(navbar)
        
        self.view?.frame = CGRect(x: 0, y: height, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - height))
    }
    
    @objc private func dismissViewController(){
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    private func initFirestore(){
        db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
    }
}
