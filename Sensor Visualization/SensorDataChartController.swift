//
//  SensorDataChart.swift
//  Sensor Visualization
//
//  Created by Patrick Schadler on 05.07.18.
//  Copyright © 2018 Patrick Schadler. All rights reserved.
//

import UIKit
import SwiftChart

class SensorDataChartController: UIViewController {
    @IBOutlet weak var lineChart: Chart!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let series = ChartSeries([0, 6.5, 2, 8, 4.1, 7, -3.1, 10, 8])
        lineChart.add(series)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
