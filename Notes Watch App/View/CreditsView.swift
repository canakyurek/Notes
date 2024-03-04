//
//  CreditsView.swift
//  Notes Watch App
//
//  Created by Can Akyürek on 4.03.2024.
//

import SwiftUI

struct CreditsView: View {
    
    @State private var randomNumber = Int.random(in: 1..<4)
    
    private var randomImage: String {
        return "developer-no\(randomNumber)"
    }
    
    var body: some View {
        VStack(spacing: 3) {
            Image(randomImage)
                .resizable()
                .scaledToFit()
                .layoutPriority(1)
            
            HeaderView(title: "Credits")
            
            Text("Can Akyürek")
                .foregroundStyle(.primary)
                .fontWeight(.bold)
            
            Text("Developer")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .fontWeight(.light)
            
        } //: VSTACK
    }
}

#Preview {
    CreditsView()
}
