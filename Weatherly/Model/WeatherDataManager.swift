//
//  WeatherDataManager.swift
//  Weatherly
//
//  Created by Negin Zahedi on 2022-06-30.
//

import Foundation

struct WeatherDataManager{
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=eb3eeee18ffb66aafe75b1d5174e3919&units=metric"
    
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
    }
}
