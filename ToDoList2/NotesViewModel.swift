//
//  NotesViewModel.swift
//  ToDoList2
//
//  Created by Kalidy, Sammer on 2/13/25.
//

import SwiftUI

class NotesViewModel: ObservableObject {
    @Published var notes: [Note] = []
    
    private let storageKey = "savedNotes"
    
    init() {
        loadNotes()
    }
    
    func addNote(title: String, content: String) {
        let newNote = Note(title: title, content: content, isCompleted: false)
        notes.append(newNote)
        saveNotes()
    }
    
    func updateNote(_ note: Note, newTitle: String, newContent: String) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index].title = newTitle
            notes[index].content = newContent
            saveNotes()
        }
    }
    
    func toggleCompletion(for note: Note) {
        if let index = notes.firstIndex(where: { $0.id == note.id }) {
            notes[index].isCompleted.toggle()
            saveNotes()
        }
    }
    
    func deleteNote(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
        saveNotes()
    }
    
    private func saveNotes() {
        if let encoded = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(encoded, forKey: storageKey)
        }
    }
    
    private func loadNotes() {
        if let savedData = UserDefaults.standard.data(forKey: storageKey),
           let decodedNotes = try? JSONDecoder().decode([Note].self, from: savedData) {
            notes = decodedNotes
        }
    }
}
