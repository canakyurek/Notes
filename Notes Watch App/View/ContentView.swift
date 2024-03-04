//
//  ContentView.swift
//  Notes Watch App
//
//  Created by Can Akyürek on 26.02.2024.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTY
    
    @State private var text = ""
    @State private var notes: [Note] = []
    @AppStorage("lineCount") var lineCount = 1
    
    // MARK: - FUNCTION
    
    func save() {
        do {
            let data = try JSONEncoder().encode(notes)
            let url = getDocumentDirectory().appendingPathComponent("notes")
            try data.write(to: url)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func load() {
        DispatchQueue.main.async {
            do {
                let url = getDocumentDirectory().appendingPathComponent("notes")
                let data = try Data(contentsOf: url)
                notes = try JSONDecoder().decode([Note].self, from: data)
            } catch {
                
            }
        }
    }
    
    func delete(offset: IndexSet) {
        notes.remove(atOffsets: offset)
        save()
    }
    
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        )
        return path[0]
    }
    
    var body: some View {
        VStack(spacing: 6) {
            HStack(alignment: .center, spacing: 4) {
                TextField("Add new note", text: $text)
                Button(action: {
                    // TODO: - Add new note action
                    guard text.isEmpty == false else { return }
                    let note = Note(id: UUID(), text: text)
                    notes.append(note)
                    text = ""
                    
                    save()
                }, label: {
                    Image(systemName: "plus.circle")
                        .font(.system(size: 42, weight: .semibold))
                }) //: BUTTON
                .fixedSize()
                .buttonStyle(PlainButtonStyle())
                .foregroundColor(.accentColor)
            } //: HSTACK
            
            Spacer()
            
            if notes.isEmpty == false {
                List {
                    ForEach(0..<notes.count, id: \.self) { i in
                        NavigationLink(destination: DetailView(note: notes[i], count: notes.count, index: i)) {
                            HStack {
                                Capsule()
                                    .frame(width: 4)
                                    .foregroundColor(.accentColor)
                                Text(notes[i].text)
                                    .lineLimit(lineCount)
                            } //: HSTACK
                        } //: NAVIGATION LINK
                    } //: FOREACH
                    .onDelete(perform: { indexSet in
                        delete(offset: indexSet)
                    })
                }
            } else {
                Spacer()
                Image(systemName: "note.text")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
                    .opacity(0.25)
                    .padding(10)
                Spacer()
            } //: LIST
        } //: VSTACK
        .navigationTitle("Notes")
        .onAppear(perform: {
            load()
        })
    }
}

#Preview {
    NavigationView {
        ContentView()
    }
}
