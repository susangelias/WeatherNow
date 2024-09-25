//
//  FavoriteCitiesView.swift
//  WeatherNow
//
//  Created by Susan Elias on 9/25/24.
//

import SwiftUI

struct FavoriteCitiesView: View {
    @ObservedObject var favoritesModel: FavoritesModel
    var onCitySelected: (City) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(favoritesModel.cities) { city in
                    Button(action: {
                        onCitySelected(city)
                    }) {
                        Text(city.title)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .contextMenu {
                        Button(action: {
                            favoritesModel.removeCity(city)
                        }) {
                            Label("Remove from Favorites", systemImage: "trash")
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .frame(height: 50)
    }
}

struct FavoriteCitiesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteCitiesView(favoritesModel: FavoritesModel()) { _ in }
    }
}
