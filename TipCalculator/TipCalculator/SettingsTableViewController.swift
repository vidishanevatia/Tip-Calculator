//
//  SettingsTableViewController.swift
//  TipCalculator
//
//  Created by Vidisha Nevatia on 12/06/20.
//  Copyright © 2020 Vidisha Nevatia. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    @IBOutlet var defaultTipLabel: UILabel!
    @IBOutlet var defaultTipSlider: UISlider!
    @IBOutlet var defaultTaxLabel: UILabel!
    @IBOutlet var defaultTaxSlider: UISlider!
    @IBOutlet var peopleLabel: UILabel!
    @IBOutlet var peopleStepper: UIStepper!
    
    var defaultTipPercentage = 15
      var defaultTaxPercentage = 4
    var peopleNumber = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   
    @IBAction func defaultTipChanged(_ sender: UISlider) {
        updateTipValue()
    }
    
    @IBAction func defaultTaxChanged(_ sender: UISlider) {
        updateTaxValue()
    }
    
    @IBAction func defaultPeopleChanged(_ sender: UIStepper) {
        updatePeopleValue()
    }
    
    func updateTipValue()
    {
         defaultTipPercentage = Int(defaultTipSlider.value)
        defaultTipLabel.text = "\(defaultTipPercentage)%"
        let defaults = UserDefaults.standard
        defaults.set(defaultTipPercentage, forKey: "defaultTipPercentage")
        defaults.synchronize()
    }
    
    func updateTaxValue()
    {
         defaultTaxPercentage = Int(defaultTaxSlider.value)
         defaultTaxLabel.text = "\(defaultTaxPercentage)%"
        let defaults = UserDefaults.standard
        defaults.set(defaultTaxPercentage, forKey: "defaultTaxPercentage")
        defaults.synchronize()
    }
    
    func updatePeopleValue()
    {
         peopleNumber = Int(peopleStepper.value)
        peopleLabel.text = "\(peopleNumber)"
        let defaults = UserDefaults.standard
        defaults.set(peopleNumber, forKey: "peopleNumber")
        defaults.synchronize()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           
           // get saved defaults
        let defaults = UserDefaults.standard
       defaultTipPercentage = defaults.integer(forKey: "defaultTipPercentage")
        defaultTaxPercentage = defaults.integer(forKey: "defaultTaxPercentage")
         peopleNumber = defaults.integer(forKey: "peopleNumber")
           // init controls & labels
        defaultTipSlider.value = Float(defaultTipPercentage)
           defaultTipLabel.text = String(format: "%d%%", defaultTipPercentage)
        defaultTaxSlider.value = Float(defaultTaxPercentage)
        defaultTaxLabel.text = String(format: "%d%%", defaultTaxPercentage)
        peopleStepper.value = Double(Int(peopleNumber))
        peopleLabel.text = String(format: "%d%", peopleNumber)
           
       }
    
   
}
