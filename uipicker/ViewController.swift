//
//  ViewController.swift
//  uipicker
//
//  Created by Jakub Opała on 02/02/2020.
//  Copyright © 2020 Jakub Opała. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var makePicker: UIPickerView!
    @IBOutlet weak var modelPicker: UIPickerView!
    @IBOutlet weak var yearPicker: UIPickerView!
    
    //ilość UIPickerView, poniżej zadeklarowane jako Dictionary
    var listOfMakes: [String] = [String]()
    var listOfModels: [String] = [String]()
    var listOfYears: [String] = [String]()
    
    //dla tych danych pierwszy poziom to jest key
    //dictionary ma być brane z serwera -> skrypt w Pythonie robiący nested dictionaries z pliku json/csv
    //przenieść ten cały carDictionary do osobnej lokalizacji
    
    var carDictionary = ["car": ["fiesta": ["year": ["1990", "2002"]], "focus": ["year": ["2020", "2002"]]], "car2": ["reno": ["year": ["1992", "2002"]], "super": ["year": ["1993", "1994"]]]]
    
    var makeRow = 0
    var modelRow = 0
    var yearRow = 0
    
    override func viewDidLoad() {
        //keys - "car" z przykładu, dictionary z pierwszego poziomiu
        self.listOfMakes = Array(carDictionary.keys)
        let firstCar = listOfMakes[0]
        let modelsDictionary = carDictionary[firstCar]! as  Dictionary<String, Dictionary<String, [String]>>
        var listOfModels = Array(modelsDictionary.keys).sorted()
        let firstModel = listOfModels[0]
        let yearsDictionary = modelsDictionary[firstModel]! as Dictionary<String, [String]>
        //self
        var listOfYears = Array(yearsDictionary.keys).sorted()
        
        makePicker.dataSource = self
        makePicker.delegate = self
        modelPicker.dataSource = self
        modelPicker.delegate = self
        yearPicker.dataSource = self
        yearPicker.delegate = self
    }
    
    func setModelsList(make: String) {
        let modelsDictionary = carDictionary[make]! as  Dictionary<String, Dictionary<String, [String]>>
        self.listOfModels = Array(modelsDictionary.keys).sorted()
    }
    func setYearsList(make: String, model: String) {
        let modelsDictionary = carDictionary[make]! as  Dictionary<String, Dictionary<String, [String]>>
        //let modelsList = Array(modelsDictionary.keys)
        let yearsArray = modelsDictionary[model]! as Dictionary<String, [String]>
        if let years = yearsArray["year"] {
            self.listOfYears = years
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == makePicker {
            setModelsList(make: listOfMakes[makeRow])
            modelPicker.selectRow(0, inComponent: 0, animated: true)
            return listOfMakes.count
        }
        else if pickerView == modelPicker {
            return listOfModels.count
        }
        else {
            return listOfYears.count
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == makePicker {
            makeRow = row
            setModelsList(make: listOfMakes[makeRow])
            setYearsList(make: listOfMakes[makeRow], model: listOfModels[0])
            modelPicker.selectRow(0, inComponent: 0, animated: true)
            yearPicker.selectRow(0, inComponent: 0, animated: true)
            self.modelPicker.reloadAllComponents()
            self.yearPicker.reloadAllComponents()
            
            
        }
        else if pickerView == modelPicker {
            modelRow = row
            setYearsList(make: listOfMakes[makeRow], model: listOfModels[modelRow])
            yearPicker.selectRow(0, inComponent: 0, animated: true)
            self.yearPicker.reloadAllComponents()
        }
        else {
            //delegat? do drugiego vc, połączone do jednego stringa
            let pickerString = "\(listOfMakes[row]) \(listOfModels[row]) \(listOfYears[row])"
            print(pickerString)
        }
        
    }
    
}
