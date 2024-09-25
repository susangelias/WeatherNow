//
//  CityModel.swift
//  WeatherNow
//
//  Created by Susan Elias on 9/25/24.
//

import Foundation

struct City: Identifiable {
    let id = UUID()
    let title: String
    let latitude: Double
    let longitude: Double
}
