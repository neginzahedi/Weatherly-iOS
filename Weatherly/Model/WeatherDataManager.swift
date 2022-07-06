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



import Foundation

struct WeatherDataManager{
    
    
    
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
            
            // 3. create task - give URL a task (to retrive content of url - closure
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
                    parseJSON(weatherData: safeData)
                }
            }
            
            // 4. start the task (hit enter in search bar)
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data){
        //object to decode json
        let decoder = JSONDecoder()
        // two things: decodable Type and a data to decode
        // try and throw : if sth goes wrong
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.weather[0].description)
        } catch{
            print(error)
        }
    }
    
}
