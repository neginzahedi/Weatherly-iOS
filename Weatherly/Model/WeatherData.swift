//
//  WeatherData.swift
//  Weatherly
//
//  Created by Negin Zahedi on 2022-07-06.
//
// decodable protocol
// name in struct should match the property name of JSON

// Encodable: encode to json
// Codable: Rncodable and Decodable

import Foundation

struct WeatherData: Codable{
    let name: String
    let main: Main
    let weather: [Weather]  //array in json
    
}

struct Main: Codable{
    let temp: Double
    let humidity: Double
    let pressure: Double
    let feels_like: Double
}

struct Weather: Codable{
    let description: String
    let id: Int
    let main: String
}
