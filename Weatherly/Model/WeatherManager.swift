//
//  WeatherManager.swift
//  Weatherly
//
//  Created by Negin Zahedi on 2022-06-30.
//
// Network
// 1. create URL
// 2. create URL session
// 3. give URL a task (like browser to fetch data)
// 4. start the task (hit enter in search bar)
//
// Closure : anonymos function - function without a name
//

protocol WeatherDataManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

import Foundation
import CoreLocation

struct WeatherManager{
    
    // it means if there is a delegate then they can use the didUpdateWeather()
    var delegate: WeatherDataManagerDelegate?
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(PrivateKeys().OpenWeatherMapKey)&units=metric"
    
    // by city name
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
        performRequest(urlString)
    }
    
    // for current location - by lat and lon
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(urlString)
    }
    
    func performRequest(_ urlString: String){
        // 1. create URL : location of the resource (can be on local or remote server)
        if let url = URL(string: urlString){
            
            // 2. create URL session (downloading or uploading data)
            let session = URLSession(configuration: .default)
            
            // 3. create task - give URL a task (fetch data: to retrive content of url - closure
            let task = session.dataTask(with: url) { (data, response, error) in
                
                // if there are errors
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    // empty return just means exit
                    return
                }
                
                // if there is no errors
                if let safeData = data{
                    // for encoding text from website use .utf8
                    // let dataString = String(data: safeData, encoding: .utf8)
                    
                    // JSON: Javascript Object Notation
                    if let weather = self.parseJSON(safeData){
                        
                        // self means the delegate is in current class
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            
            // 4. start the task (hit enter in search bar)
            task.resume()
        }
    }
    
    // ? optional because it can be nil
    func parseJSON(_ weatherData: Data)->WeatherModel?{
        //object to decode json
        let decoder = JSONDecoder()
        // two things: decodable Type and a data to decode
        // try and throw : if sth goes wrong
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            // pass data and store in a struct
            let icon = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let description = decodedData.weather.description
            let condition = decodedData.weather[0].main
            let humidity = decodedData.main.humidity
            let pressure = decodedData.main.pressure
            let feels = decodedData.main.feels_like
            
            let weatherCity = WeatherModel(city: name, weatherIcon: icon, temperature: temp, decription: description, condition: condition, humidity: humidity,pressure: pressure,feelslike: feels)
            return weatherCity
            
        } catch{
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
