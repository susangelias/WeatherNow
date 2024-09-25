//
//  BackgroundView.swift
//  WeatherNow
//
//  Created by Susan Elias on 9/24/24.
//

import SwiftUI
import MapKit

struct BackgroundView: View {
    @Binding var searchText: String
    var onLocationFound: (CLLocationCoordinate2D) -> Void
    
    @State private var position: MapCameraPosition = .region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.3352, longitude: -122.0096),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    ))
    
    var body: some View {
        Map(position: $position) {
        }
        .mapStyle(.standard)
        .onChange(of: searchText) { _, newValue in
            searchLocation(newValue)
        }
    }
    
    private func searchLocation(_ searchText: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = MKCoordinateRegion(.world)
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            
            if let firstItem = response.mapItems.first {
                let coordinate = firstItem.placemark.coordinate
                position = .region(MKCoordinateRegion(
                    center: coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                ))
                onLocationFound(coordinate)
            }
        }
    }
}

#Preview {
    BackgroundView(searchText: .constant("San Francisco"), onLocationFound: { _ in })
}
