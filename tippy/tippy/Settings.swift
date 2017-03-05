//
//  Settings.swift
//  tippy
//
//  Created by Tuze on 3/4/17.
//  Copyright © 2017 Tugce. All rights reserved.
//

import UIKit


class Settings: UIViewController {
     @IBOutlet weak var tipControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
         // Do any additional setup after loading the view.
        let defaults = UserDefaults.standard
        let defaultTipIndex = defaults.integer(forKey: "TipPercentageIndex")
        tipControl.selectedSegmentIndex = defaultTipIndex
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(tipControl.selectedSegmentIndex, forKey: "TipPercentageIndex")
        defaults.synchronize()
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
