//
//  WeatherModel.swift
//  Weatherly
//
//  Created by Negin Zahedi on 2022-07-07.
//
// WeatherCityModel is to store decodedData property
//
// computed property -> var name : dataType {return}

import Foundation

struct WeatherModel {
    
    let city: String
    let weatherIcon: Int
    let temperature: Double
    let decription: String
    let condition: String
    let humidity: Double
    let pressure: Double
    let feelslike: Double
    
    // computed property
    var tempToString: String {
        return String(format: "%.1f", temperature)
    }
    
    // computed property
    var conditionIcon: String {
        switch weatherIcon {
        case 200...232:
            return "zap"
        case 300...321:
            return "wind"
        case 500...531:
            return "rain"
        case 600...622:
            return "fog"
        case 701...781:
            return "cloud"
        case 800:
            return "sun"
        case 801...804:
            return "zap"
        default:
            return "cloud"
        }
    }
    
}
