//
//  WeatherDataManager.swift
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
    func didUpdateWeather(weather: WeatherCityModel)
}

import Foundation

struct WeatherDataManager{
    
    // it means if there is a delegate then they can use the didUpdateWeather()
    var delegate: WeatherDataManagerDelegate?
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(PrivateKeys().OpenWeatherMapKey)&units=metric"
    
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        // 1. create URL : location of the resource (can be on local or remote server)
        if let url = URL(string: urlString){
            
            // 2. create URL session (downloading or uploading data)
            let session = URLSession(configuration: .default)
            
            // 3. create task - give URL a task (fetch data: to retrive content of url - closure
            let task = session.dataTask(with: url) { (data, response, error) in
                
                // if there are errors
                if error != nil{
                    print(error!)
                    // empty return just means exit
                    return
                }
                
                // if there is no errors
                if let safeData = data{
                    // for encoding text from website use .utf8
                    // let dataString = String(data: safeData, encoding: .utf8)
                    
                    // JSON: Javascript Object Notation
                    if let weather = parseJSON(weatherData: safeData){
                        
                        // self means the delegate is in current class
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            
            // 4. start the task (hit enter in search bar)
            task.resume()
        }
    }
    
    // ? optional because it can be nil
    func parseJSON(weatherData: Data)->WeatherCityModel?{
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
            let weatherCity = WeatherCityModel(city: name, weatherIcon: icon, temperature: temp, decription: description)
            return weatherCity
            
        } catch{
            print(error)
            return nil
        }
    }
    
    
    
}
