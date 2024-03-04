//
//  SettingsView.swift
//  Notes Watch App
//
//  Created by Can Akyürek on 4.03.2024.
//

import SwiftUI

struct SettingsView: View {
    
    // PROPERTIES
    @AppStorage("lineCount") var lineCount = 1
    @State private var value: Float = 1.0
    
    func update() {
        lineCount = Int(value)
    }
    
    var body: some View {
        VStack {
            // HEADER
            HeaderView(title: "Settings")
            // ACTUAL LINE COUNT
            Text("Lines: \(lineCount)".uppercased())
                .fontWeight(.bold)
            
            // SLIDER
            Slider(value: Binding(get: {
                self.value
            }, set: { newValue in
                self.value = newValue
                update()
            }), in: 1...4, step: 1)
                .tint(.accentColor)
        } //: VSTACK
        .onAppear(perform: {
            value = Float(lineCount)
        })
        
    }
}

#Preview {
    SettingsView()
}
