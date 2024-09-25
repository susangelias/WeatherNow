//
//  OpaqueRoundedRectView.swift
//  WeatherNow
//
//  Created by Susan Elias on 9/25/24.
//

import SwiftUI

struct OpaqueRoundedRectView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
        }
        .padding()
        .background(Color.black.opacity(0.6))
        .foregroundColor(.white)
        .cornerRadius(10)
        .padding()
    }
}

#Preview {
    OpaqueRoundedRectView()
}
