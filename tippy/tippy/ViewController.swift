//
//  ViewController.swift
//  tippy
//
//  Created by Tuze on 3/2/17.
//  Copyright © 2017 Tugce. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let defaults = UserDefaults.standard
        let defaultTipIndex = defaults.integer(forKey: "TipPercentageIndex")
        tipControl.selectedSegmentIndex = defaultTipIndex
        calculateTip(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func tipChanged(_ sender: Any) {
        calculateTip(self)
    }
    
    
    @IBAction func onTap(_ sender: Any) {
    view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        let tipPercentages = [0.18, 0.2,0.25]
        let bill=Double(billField.text!) ?? 0
        let tip=bill*tipPercentages[tipControl.selectedSegmentIndex]
        let total=bill+tip
        
        tipLabel.text = String(format: "$%.2f", tip)
            //"S\(tip)"
        totalLabel.text=String(format: "$%.2f", total)
        
    }
}

