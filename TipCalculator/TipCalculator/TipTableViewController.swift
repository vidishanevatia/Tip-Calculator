//
//  TipTableViewController.swift
//  TipCalculator
//
//  Created by Vidisha Nevatia on 12/06/20.
//  Copyright © 2020 Vidisha Nevatia. All rights reserved.
//

import UIKit

class TipTableViewController: UITableViewController {

    @IBOutlet var billAmountTextField: UITextField!
    @IBOutlet var tipPercentageLabel: UILabel!
    @IBOutlet var tipPercentageStepper: UIStepper!
    @IBOutlet var tipAmountLabel: UILabel!
    
    @IBOutlet var taxPercentageLabel: UILabel!
    @IBOutlet var taxPercentageStepper: UIStepper!
    @IBOutlet var taxAmountLabel: UILabel!
    @IBOutlet var totalBillLabel: UILabel!
    @IBOutlet var peopleLabel: UILabel!
    @IBOutlet var peopleStepper: UIStepper!
    @IBOutlet var perPeronLabel: UILabel!
    @IBOutlet var totalPerPersonLabel: UILabel!
    var tip = 0.0
    var tax = 0.0
    var billAmt = 0.0
    var totalBill = 0.0
    var people = 1
    let DEFAULT_TIP_PERCENTAGE = 18
    let DEFAULT_TAX_PERCENTAGE = 4.5
    let PEOPLE_NUMBER = 18
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTotalBillAmount()
        updateTipPercentage()
        updateTaxPercentage()
        updatePeople()
        perPeronLabel.text = "0.0"
        totalPerPersonLabel.text = "0.0"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = getUserDefaults()
               let defaultTipPercentage = defaults.integer(forKey: "defaultTipPercentage")
               let defaultTaxPercentage = defaults.integer(forKey: "defaultTaxPercentage")
               let peopleNumber = defaults.integer(forKey: "peopleNumber")
               tipPercentageStepper.value = Double(defaultTipPercentage)
               tipPercentageLabel.text = "\(defaultTipPercentage)%"
               taxPercentageStepper.value = Double(defaultTaxPercentage)
               taxPercentageLabel.text = "\(defaultTaxPercentage)%"
                peopleStepper.value = Double(peopleNumber)
                peopleLabel.text = "\(peopleNumber)"
    }
    
    @IBAction func billAmountTextFieldChanged(_ sender: UITextField) {
        updateTipPercentage()
        updateTaxPercentage()
        updateTotalBillAmount()
        updatePeople()
    }
    
    func updateTipPercentage(){
        tipPercentageLabel.text = "\(Int(tipPercentageStepper.value))%"
       
         tip = textToDouble(from: billAmountTextField) * Double(tipPercentageStepper.value)/100
        
         tip = Double(round(100*tip)/100)
        
        tipAmountLabel.text = "$\(tip)"
        
       }
    
    func updateTaxPercentage(){
        var taxPercent = Double(taxPercentageStepper.value)
        taxPercent =  Double(round(100*taxPercent)/100)
        taxPercentageLabel.text = "\(taxPercent)%"
       
          tax = textToDouble(from: billAmountTextField) * Double(taxPercentageStepper.value)/100
        
         tax = Double(round(100*tax)/100)
        
        taxAmountLabel.text = "$\(tax)"
       }
    
    
   func updateTotalBillAmount() {
     totalBill = textToDouble(from: billAmountTextField) + tax + tip
     totalBill = Double(round(100*totalBill)/100)
    totalBillLabel.text = "$\(totalBill)"
    
    }
    
    func updatePeople()
    {
        people = Int(peopleStepper.value)
        peopleLabel.text = "\(people)"
        var perPersonWithoutTax = textToDouble(from: billAmountTextField)/Double(people)
        perPersonWithoutTax = Double(round(100*perPersonWithoutTax)/100)
        var perPersonWithTax = totalBill/Double(people)
        perPersonWithTax = Double(round(100*perPersonWithTax)/100)
        
        perPeronLabel.text = "$\(perPersonWithoutTax)"
        totalPerPersonLabel.text = "$\(perPersonWithTax)"
    }
    
    
       
       @IBAction func tipStepperValueChanged(_ sender: UIStepper)
       {
           updateTipPercentage()
       }
    
    @IBAction func taxStepperValueChanged(_ sender: UIStepper) {
        updateTaxPercentage()
    }
    
    
    @IBAction func peopleStepperValueChanged(_ sender: UIStepper) {
        updatePeople()
    }
    
    @IBAction func clearButton(_ sender: UIBarButtonItem) {
        billAmountTextField.text = ""
        tipAmountLabel.text = "$0.0"
        taxAmountLabel.text = "$0.0"
        totalBillLabel.text = "$0.0"
        perPeronLabel.text = "0.0"
        totalPerPersonLabel.text = "0.0"
    }
    
    func textToDouble(from textField: UITextField) -> Double {
        guard let text = textField.text, let number = Double(text) else {
            return 0.0
        }
        return number
    }
    
    func getUserDefaults() -> UserDefaults {
        let defaults = UserDefaults.standard
        if (defaults.object(forKey: "defaultTipPercentage") == nil) {
               // set initial defaults
            defaults.set(DEFAULT_TIP_PERCENTAGE, forKey: "defaultTipPercentage")
            defaults.set(Int(DEFAULT_TAX_PERCENTAGE), forKey: "defaultTaxPercentage")
            defaults.set(PEOPLE_NUMBER, forKey: "peopleNumber")
               defaults.synchronize()
           }
           return defaults
       }
    

    


}
