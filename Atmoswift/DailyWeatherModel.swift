//
//  DailyWeatherModel.swift
//  Atmoswift
//
//  Created by Yunis Farah on 25/08/2020.
//

import SwiftUI

struct DailyWeatherModel: Codable {
    var list: [Lists]
    var city: City
}


struct Lists: Codable {
    var main: DailyMain
    var weather: [DailyWeather]
    var dt_txt: String
}

struct City: Codable {
    var name: String
    var country: String
    var population: Int
    var sunrise: Int
    var sunset: Int
}

struct DailyWeather: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct DailyMain: Codable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Int
    var humidity: Int
}

struct DailyWind: Codable {
    var speed: Double
    var deg: Int
}


struct DailySys: Codable {
    var country: String
    var sunrise: Int
    var sunset: Int
}

