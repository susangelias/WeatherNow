//
//  FavoritesModel.swift
//  WeatherNow
//
//  Created by Susan Elias on 9/25/24.
//

import Foundation

class FavoritesModel: ObservableObject {
    @Published var cities: [City]
    
    init() {
        self.cities = []
    }
    
    func addCity(_ city: City) {
        if !cities.contains(where: { $0.title == city.title }) {
            cities.append(city)
        }
    }
    
    func removeCity(_ city: City) {
        cities.removeAll { $0.id == city.id }
    }
  
    func removeCityByName(_ cityName: String) {
        cities.removeAll { $0.title == cityName }
    }
    
    func isCityFavorite(_ cityName: String) -> Bool {
        return cities.contains { $0.title == cityName }
    }
}
