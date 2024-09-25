//
//  StyledVStack.swift
//  WeatherNow
//
//  Created by Susan Elias on 9/25/24.
//

import SwiftUI

import SwiftUI

struct StyledVStack<Content: View>: View {
    let content: Content
    let backgroundColor: Color
    let foregroundColor: Color
    let cornerRadius: CGFloat
    let padding: CGFloat
    
    init(
        backgroundColor: Color = Color.black.opacity(0.6),
        foregroundColor: Color = .white,
        cornerRadius: CGFloat = 10,
        padding: CGFloat = 20,
        @ViewBuilder content: () -> Content
    ) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.cornerRadius = cornerRadius
        self.padding = padding
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            content
        }
        .padding(padding)
        .background(backgroundColor)
        .foregroundColor(foregroundColor)
        .cornerRadius(cornerRadius)
    }
}

struct StyledVStack_Previews: PreviewProvider {
    static var previews: some View {
        StyledVStack {
            Text("Sample Title")
                .font(.headline)
            Text("Sample Content")
                .font(.body)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
