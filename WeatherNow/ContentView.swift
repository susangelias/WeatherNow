//
//  ContentView.swift
//  WeatherNow
//
//  Created by Susan Elias on 9/24/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var searchText = ""
    @State private var latitude: Double = 0
    @State private var longitude: Double = 0
    @StateObject private var weatherModel = WeatherModel()
    @State private var isCelsius = true
    @StateObject private var favoritesModel = FavoritesModel()

    
    var body: some View {
        ZStack {
            BackgroundView(searchText: $searchText) { coordinate in
                latitude = coordinate.latitude
                longitude = coordinate.longitude
                weatherModel.fetchWeather(
                    latitude: coordinate.latitude,
                    longitude: coordinate.longitude,
                    units: TemperatureUnit.celsius
                )
            }
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                StyledVStack {
                    SearchBar(text: $searchText)
                        .padding(EdgeInsets(top: 15.0, leading: 20.0, bottom: 15.0, trailing: 20.0
                                           ))
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    
                    FavoriteCitiesView(favoritesModel: favoritesModel) { city in
                        searchText = city.title
                        latitude = city.latitude
                        longitude = city.longitude
                        weatherModel.fetchWeather(latitude: city.latitude, longitude: city.longitude, units: isCelsius ? .celsius : .fahrenheit)
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
                
                Spacer()
                
                if latitude != 0 && longitude != 0 {
                    StyledVStack {
                        HStack {
                               Text("Location: \(searchText)")
                                   .font(.headline)
                               Spacer()
                                Button(action: {
                                    toggleFavorite()
                                }) {
                                    Image(systemName: favoritesModel.isCityFavorite(searchText) ? "star.fill" : "star")
                                        .foregroundColor(.yellow)
                                }
                               .disabled(favoritesModel.isCityFavorite(searchText))
                           }
                        
                        if let temperature = weatherModel.temperature,
                           let description = weatherModel.description {
                            HStack {
                                  Text("Temperature: \(temperature, specifier: "%.1f")°")
                                      .font(.title2)
                                  
                                  TemperatureToggleButton(isCelsius: $isCelsius) {
                              
                                      weatherModel.fetchWeather(
                                        latitude: latitude,
                                        longitude: longitude,
                                        units: isCelsius ? .celsius : .fahrenheit
                                      )
                                  }
                              }
                            Text("Weather: \(description)")
                                .font(.body)
                        }
                        
                        if let error = weatherModel.error {
                            Text("Error: \(error)")
                                .foregroundColor(.red)
                        }
                    }
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
                }
            }
        }
    }
    private func toggleFavorite() {
        if favoritesModel.isCityFavorite(searchText) {
            favoritesModel.removeCityByName(searchText)
        } else {
            let newCity = City(title: searchText, latitude: latitude, longitude: longitude)
            favoritesModel.addCity(newCity)
        }
    }
}

#Preview {
    ContentView()
}
