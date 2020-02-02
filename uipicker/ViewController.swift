//
//  ViewController.swift
//  uipicker
//
//  Created by Jakub Opała on 02/02/2020.
//  Copyright © 2020 Jakub Opała. All rights reserved.
//

import UIKit

class CarPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var makePicker: UIPickerView!
    @IBOutlet weak var modelPicker: UIPickerView!
    @IBOutlet weak var yearPicker: UIPickerView!
    
    
    var listOfMakes: [String] = [String]()
    let listOfModels: [String] = [String]()
    let listOfYears: [String] = [String]()
    var carList: Dictionary <String, Dictionary<String,Dictionary<String,String>>> = Dictionary()
    //var carList: Dictionary <String, Dictionary<String,Dictionary<String,String>>> = Dictionary()
    //var carDictionary = { make1: {model1: {year1, year2}, model2: {year1, year2}}, make2: {model4: {year16, year23}, model5: {year21, year23}}}
    //var carDictionary = ["ford": ["fiesta": ["year": "2001", "year": "2002"], "focus": ["year": "2001","year":  "2002"]], ["opel": ["astra": ["year": "2001","year":  "2002"]], "corsa": ["year": "2001","year": "2002"]]]
    var carDictionary = ["ford": ["fiesta": ["year": "2001", "year": "2002"], "focus": ["year": "2001","year": "2002"]], "ford": ["fiesta": ["year": "2001", "year": "2002"], "focus": ["year": "2001","year": "2002"]]]
    
    //var carList: Dictionary <String, Dictionary<String,Dictionary<String,String>>> = Dictionary()
    //{ make1: {model1: {year1, year2}, model2: {year1, year2}}, make2: {model4: {year16, year23}, model5: {year21, year23}}}
    
    var makeRow = 0
    var modelRow = 0
    var yearRow = 0
    
    //var carDictionary = ["ford": ["fiesta": ["year": "2001", "year": "2002"], "focus": ["year": "2001","year":  "2002"]], ["opel": ["astra": ["year": "2001","year":  "2002"], "corsa": ["year": "2001","year": "2002"]]]
    
    override func viewDidLoad() {
        self.listOfMakes = Array(carDictionary.keys)
        let firstCar = listOfMakes[0]
        let modelsDictionary = carList[firstCar]! as  Dictionary<String, Dictionary<String, String>>
        //self
        var listOfModels = Array(modelsDictionary.keys).sort()
        let firstModel = listOfModels[0]
        let yearsDictionary = modelsDictionary[firstModel]! as Dictionary<String, String>
        //self
        var listOfYears = Array(yearsDictionary.keys).sort()
    }
    
    
    func setModelsList(make: String) {
        let modelsDictionary = carList[make]! as  Dictionary<String, Dictionary<String, String>>
        self.listOfModels = Array(modelsDictionary.keys).sort()
    }
    func setYearsList(make: String, model: String) {
        let modelsDictionary = carList[make]! as  Dictionary<String, Dictionary<String, String>>
        let modelsList = Array(modelsDictionary.keys)
        let yearsDictionary = modelsDictionary[model]! as Dictionary<String, String>
        self.listOfYears = Array(yearsDictionary.keys).sort()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == makePicker {
            makeRow = row
            setModelsList(listOfMakes[makeRow])
            setYearsList(listOfMakes[makeRow], model: listOfModels[0])
            modelPicker.selectRow(0, inComponent: 0, animated: true)
            yearPicker.selectRow(0, inComponent: 0, animated: true)
            self.modelPicker.reloadAllComponents()
            self.yearPicker.reloadAllComponents()
        }
        else if pickerView == modelPicker {
            modelRow = row
            setYearsList(listOfMakes[makeRow], model: listOfModels[modelRow])
            yearPicker.selectRow(0, inComponent: 0, animated: true)
            self.modelPicker.reloadAllComponents()
            self.yearPicker.reloadAllComponents()
        }
        else {
            //do anything you want once you have chosen a specific year.
        }
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == makePicker {
            return listOfMakes[row]
        }
        else if pickerView == modelPicker {
            return listOfModels[row]
        }
        else {
            return listOfYears[row]
        }
    }
}

