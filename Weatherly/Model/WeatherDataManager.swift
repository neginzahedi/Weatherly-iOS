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
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=eb3eeee18ffb66aafe75b1d5174e3919&units=metric"
    
    
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
            
            // 3. create task - give URL a task (to retrive content of url
            let task = session.dataTask(with: url, completionHandler: handler(data: response: error: ))
            
            // 4. start the task (hit enter in search bar)
            task.resume()
        }
        
        
    }
    
    func handler(data: Data?, response: URLResponse?, error: Error?) -> Void{
        // if there are errors
        if error != nil{
            print(error!)
            // empty return just means exit
            return
        }
        
        // if there is no errors
        if let safeData = data{
            // for encoding text from website use .utf8
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString)
        }
    }
}
