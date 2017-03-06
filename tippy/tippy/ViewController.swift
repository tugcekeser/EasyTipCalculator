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
    @IBOutlet weak var totalLabelForTwo: UILabel!
    @IBOutlet weak var totalLabelForFour: UILabel!
    @IBOutlet weak var totalLabelForThree: UILabel!
    @IBOutlet weak var calculatorView: UIView!
    
    //View Animations - Show
    func animateShow() {
        UIView.animate(withDuration:0.4, animations: {
            self.calculatorView.alpha = 1
        })
    }
    
    //View Animations - Hide
    func animateHidden(){
        UIView.animate(withDuration: 0.4, animations: {
            self.calculatorView.alpha = 0
        })
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        billField.becomeFirstResponder()
        
       }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let defaults = UserDefaults.standard
        let lastCalculationDate = defaults.object(forKey: "LastCalculationDate")
        let lastCalculationBillAmount = defaults.string(forKey: "LastCalculationBillAmount")
        let defaultTipIndex = defaults.integer(forKey: "TipPercentageIndex")
        if(lastCalculationDate==nil){
            //Do nothing
        }
        else{
            let elapsed=NSDate().timeIntervalSince(lastCalculationDate as! Date! )
            let duration = Int(elapsed)
            if(duration<36000){ //If the last bill was calculated before less then ten minutes
                billField.text=lastCalculationBillAmount
            }
        }
        
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
        if(billField.hasText){
           animateShow()
        }
        else{
           animateHidden()
        }
        
        let tipPercentages = [0.15, 0.18,0.20]
        let bill=Double(billField.text!) ?? 0
        let tip=bill*tipPercentages[tipControl.selectedSegmentIndex]
        let total=bill+tip
        
        let locale = Locale.current
        let currencySymbol = locale.currencySymbol
        
        tipLabel.text = currencySymbol!+String(format: "%.2f", tip)           //"S\(tip)"
        totalLabel.text=currencySymbol!+String(format: "%.2f", total)
        totalLabelForTwo.text=currencySymbol!+String(format: "%.2f", total/2)
        totalLabelForThree.text=currencySymbol!+String(format: "%.2f", total/3)
        totalLabelForFour.text=currencySymbol!+String(format: "%.2f", total/4)
        
        let defaults = UserDefaults.standard
        defaults.set(NSDate(), forKey: "LastCalculationDate")
        defaults.set(billField.text, forKey: "LastCalculationBillAmount")
        defaults.synchronize()
        
    }
}

