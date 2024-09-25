//
//  WeatherModel.swift
//  WeatherNow
//
//  Created by Susan Elias on 9/24/24.
//

import Foundation
import Combine

enum TemperatureUnit: String {
    case celsius = "metric"
    case fahrenheit = "imperial"
}


class WeatherModel: ObservableObject {
    @Published var temperature: Double?
    @Published var description: String?
    @Published var error: String?

    private var cancellables = Set<AnyCancellable>()
    
    func fetchWeather(latitude: Double, longitude: Double, units: TemperatureUnit) {
        
        print("Bundle.main.infoDictionary \(String(describing: Bundle.main.infoDictionary))")
        if let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String {
            let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&units=\(units.rawValue)&appid=\(apiKey)"
            guard let url = URL(string: urlString) else {
                self.error = "Invalid URL"
                return
            }
            
            print("Fetching weather from URL: \(urlString)")
            
            URLSession.shared.dataTaskPublisher(for: url)
                .map(\.data)
                .tryMap { data -> Data in
                    // Print raw JSON data
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("Raw JSON respone")
                        print(jsonString)
                    }
                    return data
                }
                .decode(type: APIResponse.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink { completion in
                    if case .failure(let error) = completion {
                        print("Error: \(error)")
                        
                        self.error = "API Error: \(error.localizedDescription)"
                    }
                } receiveValue: { response in
                    switch response {
                    case .success(let weatherData):
                        self.temperature = weatherData.main.temp
                        self.description = weatherData.weather.first?.description
                        self.error = nil
                    case .failure(let errorResponse):
                        self.error = "API Error: \(errorResponse.message)"
                    }
                }
                .store(in: &cancellables)
        } else {
            print("WeatherModel missing api key")
        }
    }
}

enum APIResponse: Decodable {
    case success(WeatherResponse)
    case failure(ErrorResponse)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let errorResponse = try? container.decode(ErrorResponse.self) {
            self = .failure(errorResponse)
        } else {
            let weatherResponse = try container.decode(WeatherResponse.self)
            self = .success(weatherResponse)
        }
    }
}

struct ErrorResponse: Decodable {
    let cod: String
    let message: String
}

struct WeatherResponse: Codable {
    let main: MainWeather
    let weather: [WeatherDescription]
}

struct MainWeather: Codable {
    let temp: Double
}

struct WeatherDescription: Codable {
    let description: String
}
