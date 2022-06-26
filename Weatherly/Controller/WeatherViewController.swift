//
//  ViewController.swift
//  Weatherly
//
//  Created by Negin Zahedi on 2022-06-25.
//
// UITextFieldDelegate allows current VC to manage UITextField

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var searchCityTextField: UITextField!
    @IBOutlet weak var cityUILabel: UILabel!
    @IBOutlet weak var dateUILabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var temperatureUILabel: UILabel!
    @IBOutlet weak var conditionUILabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Notify the VC of the user's interactions with UITextField
        searchCityTextField.delegate = self
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        //dismiss keyboard
        searchCityTextField.endEditing(true)
        
        print(searchCityTextField.text!)
    
    }
    
    // when user press the "go" button on keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //dismiss keyboard
        textField.endEditing(true)
        
        print(searchCityTextField.text!)
        return true
    }
    
    //
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text == ""{
            return true
        } else{
            textField.placeholder = "Enter the City..."
            return false
        }
    }
    
    // clear the text field when user done with typing and press search
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        textField.text = ""
    }
  
}

