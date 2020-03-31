//
//  ViewController.swift
//  uipicker
//
//  Created by Jakub Opała on 02/02/2020.
//  Copyright © 2020 Jakub Opała. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var makePicker: UIPickerView!
    @IBOutlet weak var modelPicker: UIPickerView!
    @IBOutlet weak var yearPicker: UIPickerView!
    @IBOutlet weak var textFieldKKS: UITextField!
    
    //ilość UIPickerView, poniżej zadeklarowane jako Dictionary
    var listOfFirst: [String] = [String]()
    var listOfSecond: [String] = [String]()
    var listOfThird: [String] = [String]()
    
    //dla tych danych pierwszy poziom to jest key
    //dictionary ma być brane z serwera -> skrypt w Pythonie robiący nested dictionaries z pliku json/csv
    //przenieść ten cały carDictionary do osobnej lokalizacji
    
    //var carDictionary = ["car": ["fiesta": ["year": ["1990", "2002"]], "focus": ["year": ["2020", "2002"]]], "car2": ["reno": ["year": ["1992", "2002"]], "super": ["year": ["1993", "1994"]]]]
    
    //var carDictionary = ["15": ["35": ["year": ["1", "2"]], "12": ["year": ["1", "2", "3"]], "20": ["year": ["1", "2", "3"]]], "20": ["65": ["year": ["1", "2"]], "18": ["year": ["1", "2", "3"]], "90": ["year": ["1", "2", "3"]]]]
    
    //var carDictionary = ["10": ["10": ["bq": ["1", "2", "3", "4", "5", "6" ]], "12": ["bq": ["1", "2", "3" ]], "20": ["bq": ["1", "2", "3" ]]], "15": ["35": ["bq": ["1", "2" ]], "45": ["bq": ["1", "2" ]]]]
    
    var inputDictionary = ["10": ["010": ["bq": ["001", "002", "003", "004", "005", "006" ]], "015": ["bq": ["001", "002", "003", "004", "005", "006", "007" ]], "252": ["bq": ["001", "002", "003", "004", "005", "006", "007", "008", "009" ]], "301": ["bq": ["001", "002", "003" ]], "302": ["bq": ["001", "002", "003" ]], "402": ["bq": ["001", "002", "003", "004", "005", "006", "007", "009", "010", "011" ]], "403": ["bq": ["001", "002", "003", "004", "005", "006", "007" ]], "404": ["bq": ["001", "002", "003", "004", "008" ]], "501": ["bq": ["001"]]], "20": ["010": ["bq": ["001", "002", "003", "004", "005", "006" ]], "015": ["bq": ["001", "002", "003", "004", "005", "006", "007", "008" ]], "301": ["bq": ["001" ]], "302": ["bq": ["001" ]], "303": ["bq": ["001" ]], "505": ["bq": ["001"]]]]
    
    var ofFirstRow = 0
    var ofSecondRow = 0
    var ofThirdRow = 0
    
    override func viewDidLoad() {
        //pobranie z pliku
        //var wczytaj = DictionaryDownloader()
        //var carDictionary = wczytaj.wczytajWszystko()
        
        super.viewDidLoad()
        //makePicker.isHidden = true
        //modelPicker.isHidden = true
        //yearPicker.isHidden = true
        //keys - "car" z przykładu, dictionary z pierwszego poziomiu
        self.listOfFirst = Array(inputDictionary.keys).sorted()
        let firstCar = listOfFirst[0]
        let modelsDictionary = inputDictionary[firstCar]! as  Dictionary<String, Dictionary<String, [String]>>
        
        var listOfModels = Array(modelsDictionary.keys).sorted()
        let firstModel = listOfModels[0]
        let yearsDictionary = modelsDictionary[firstModel]! as Dictionary<String, [String]>
        //self
        var listOfYears = Array(yearsDictionary.keys).sorted()
        let firstYear = listOfYears[0]
        //let yearsDictionary = modelsDictionary[firstYear]! as [String]
        
        textFieldKKS.delegate = self
        
        makePicker.dataSource = self
        makePicker.delegate = self
        modelPicker.dataSource = self
        modelPicker.delegate = self
        yearPicker.dataSource = self
        yearPicker.delegate = self
    }
    
    func setModelsList(make: String) {
        let modelsDictionary = inputDictionary[make]! as  Dictionary<String, Dictionary<String, [String]>>
        self.listOfSecond = Array(modelsDictionary.keys).sorted()
    }
    func setYearsList(make: String, model: String) {
        let modelsDictionary = inputDictionary[make]! as  Dictionary<String, Dictionary<String, [String]>>
        //let modelsList = Array(modelsDictionary.keys)
        let yearsArray = modelsDictionary[model]! as Dictionary<String, [String]>
        if let years = yearsArray["bq"] {
            self.listOfThird = years
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        makePicker.isHidden = false
        modelPicker.isHidden = false
        yearPicker.isHidden = false
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        makePicker.isHidden = false
        modelPicker.isHidden = false
        yearPicker.isHidden = false
        //return false
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == makePicker {
            setModelsList(make: listOfFirst[ofFirstRow])
            modelPicker.selectRow(0, inComponent: 0, animated: true)
            return listOfFirst.count
        }
        else if pickerView == modelPicker {
            return listOfSecond.count
        }
        else {
            return listOfThird.count
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == makePicker {
            return listOfFirst[row]
        }
        else if pickerView == modelPicker {
            return listOfSecond[row]
        }
        else {
            return listOfThird[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == makePicker {
            ofFirstRow = row
            setModelsList(make: listOfFirst[ofFirstRow])
            setYearsList(make: listOfFirst[ofFirstRow], model: listOfSecond[0])
            modelPicker.selectRow(0, inComponent: 0, animated: true)
            yearPicker.selectRow(0, inComponent: 0, animated: true)
            self.modelPicker.reloadAllComponents()
            self.yearPicker.reloadAllComponents()
            
            
        }
        else if pickerView == modelPicker {
            ofSecondRow = row
            setYearsList(make: listOfFirst[ofFirstRow], model: listOfSecond[ofSecondRow])
            yearPicker.selectRow(0, inComponent: 0, animated: true)
            self.yearPicker.reloadAllComponents()
        }
        else {
            //delegat? do drugiego vc, połączone do jednego stringa
            //let pickerString = "\(listOfFirst[row]) \(listOfSecond[row]) \(listOfThird[row])"
            //let trimmedString = pickerString.replacingOccurrences(of: " ", with: "")
            //print(pickerString)
            //print(trimmedString)
            //            makePicker.isHidden = true
            //            modelPicker.isHidden = true
            //            yearPicker.isHidden = true
            //textFieldKKS.text = pickerString
//            makePicker.isHiddenAnimated(value: true)
//            modelPicker.isHiddenAnimated(value: true)
//            yearPicker.isHiddenAnimated(value: true)
            //            var wczytaj = DictionaryDownloader()
            //            wczytaj.wczytajWszystko()
        }
        
    }
    
}

extension UIView {
    func isHiddenAnimated(value: Bool, duration: Double = 4.0) {
        UIView.animate(withDuration: duration) { [weak self] in self?.isHidden = value }
    }
}
