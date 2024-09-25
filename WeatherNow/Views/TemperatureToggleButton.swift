//
//  TemperatureToggleButton.swift
//  WeatherNow
//
//  Created by Susan Elias on 9/25/24.
//

import SwiftUI

struct TemperatureToggleButton: View {
    @Binding var isCelsius: Bool
    var action: () -> Void

    var body: some View {
        Button(action: {
            isCelsius.toggle()
            action()
        }) {
            Text(isCelsius ? "C" : "F")
                .font(.system(size: 18, weight: .bold))
                .frame(width: 40, height: 40)
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Circle())
        }
    }
}

struct TemperatureToggleButton_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureToggleButton(isCelsius: .constant(true), action: {})
    }
}
