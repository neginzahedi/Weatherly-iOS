//
//  ViewController.swift
//  Weatherly
//
//  Created by Negin Zahedi on 2022-06-25.
//
// UITextFieldDelegate allows current VC to manage UITextField


import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherDataManagerDelegate {
  
    
    
    @IBOutlet weak var searchCityTextField: UITextField!
    @IBOutlet weak var cityUILabel: UILabel!
    @IBOutlet weak var dateUILabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var temperatureUILabel: UILabel!
    @IBOutlet weak var conditionUILabel: UILabel!
    
    //new weather manager
    var weatherDataManager = WeatherDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        weatherDataManager.delegate = self
        
        // Notify the VC of the user's interactions with UITextField
        searchCityTextField.delegate = self
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        //dismiss keyboard
        searchCityTextField.endEditing(true)
    }
    
    // when user press the "go" button on keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //dismiss keyboard
        searchCityTextField.endEditing(true)
        return true
    }
    
    //
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        } else{
            textField.placeholder = "Enter the City..."
            return false
        }
    }
    
    // clear the text field when user done with typing and press search
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchCityTextField.text{
            weatherDataManager.fetchWeather(cityName: city)
        }
        
        searchCityTextField.text = ""
    }
    
    // from WeatherDataManagerDelegate protocol
    func didUpdateWeather(weather: WeatherCityModel) {
        print(weather.temperature)
        cityUILabel.text = weather.city
        temperatureUILabel.text = "\(weather.temperature)"
        conditionUILabel.text = weather.decription
    }
    
}

