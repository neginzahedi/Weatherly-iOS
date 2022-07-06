//
//  WeatherData.swift
//  Weatherly
//
//  Created by Negin Zahedi on 2022-07-06.
//
// decodable protocol
// name in struct should match the property name of JSON

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]  //array in json
}

struct Main: Decodable{
    let temp: Double
}

struct Weather: Decodable{
    let description: String
}
