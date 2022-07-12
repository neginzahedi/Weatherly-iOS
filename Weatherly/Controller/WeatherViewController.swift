//
//  ViewController.swift
//  Weatherly
//
//  Created by Negin Zahedi on 2022-06-25.
//
// UITextFieldDelegate allows current VC to manage UITextField
// Extentions
// mark comment
// CoreLocation
// .plist: property list automatically created with xcode project and stores configuration info for app at runtime

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    // IBOutlets
    @IBOutlet weak var searchCityTextField: UITextField!
    @IBOutlet weak var cityUILabel: UILabel!
    @IBOutlet weak var dateUILabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var temperatureUILabel: UILabel!
    @IBOutlet weak var conditionUILabel: UILabel!
    @IBOutlet weak var feelsUILabel: UILabel!
    @IBOutlet weak var humidityUILabel: UILabel!
    @IBOutlet weak var pressureUILabel: UILabel!
    
    //new weather manager
    var weatherDataManager = WeatherManager()
    
    // location manager - need permission
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // location needs user permission (add info.plist)
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        // to monitor location when changes and get updated location - locationManager.startUpdatingLocation()
        locationManager.requestLocation()
        
        // delegates
        weatherDataManager.delegate = self
        // Notify the VC of the user's interactions with UITextField
        searchCityTextField.delegate = self
    }
    
    @IBAction func currentLocationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
}

// MARK: - UITextFieldDelegate
extension WeatherViewController: UITextFieldDelegate{
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
}

// MARK: - WeatherDataManagerDelegate
extension WeatherViewController: WeatherDataManagerDelegate{
    // from WeatherDataManagerDelegate protocol
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        // we can not easily set text label to the data because of threads, we are doing the networking and execution in the background and we need to dispatch the call to update uilabel to the main thread
        
        DispatchQueue.main.async {
            self.cityUILabel.text = weather.city
            self.temperatureUILabel.text = weather.tempToString
            self.conditionUILabel.text = weather.condition
            self.weatherIconImageView.image = UIImage(imageLiteralResourceName: weather.conditionIcon)
            self.humidityUILabel.text = "\(weather.humidity)"
            self.pressureUILabel.text = "\(weather.pressure)"
            self.feelsUILabel.text = "\(weather.feelslike)"
        }
        
    }
    
    // if any errors happen
    func didFailWithError(error: Error) {
        print(error)
    }
}

// MARK: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            // use stop to get updates again
            locationManager.stopUpdatingLocation()
            
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherDataManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
