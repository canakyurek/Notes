//
//  DetailView.swift
//  Notes Watch App
//
//  Created by Can Akyürek on 4.03.2024.
//

import SwiftUI

struct DetailView: View {
    
    @State private var isCreditsPresented = false
    @State private var isSettingsPresented = false
    
    let note: Note
    let count: Int
    let index: Int
    
    var body: some View {
        VStack {
            HeaderView()
            
            Spacer()
            
            ScrollView(.vertical) {
                Text(note.text)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            .padding(3)
            
            Spacer()
            
            HStack {
                Image(systemName: "gear")
                    .imageScale(.large)
                    .onTapGesture {
                        isSettingsPresented.toggle()
                    }
                    .sheet(isPresented: $isSettingsPresented, content: {
                        SettingsView()
                    })
                Spacer()
                Text("\(index + 1) / \(count)")
                Spacer()
                Image(systemName: "info.circle")
                    .imageScale(.large)
                    .onTapGesture {
                        isCreditsPresented.toggle()
                    }
                    .sheet(isPresented: $isCreditsPresented, content: {
                        CreditsView()
                    })
            }
            .foregroundColor(.secondary)
            
        } //: VSTACK
        .padding(3)
    }
}

#Preview {
    DetailView(
        note: Note(id: UUID(), text: "Hello, World!"),
        count: 5,
        index: 1
    )
}
