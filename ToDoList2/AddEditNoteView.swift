//
//  AddEditNoteView.swift
//  ToDoList2
//
//  Created by Kalidy, Sammer on 2/13/25.
//

import SwiftUI

struct AddEditNoteView: View {
    @ObservedObject var viewModel: NotesViewModel
    var note: Note? = nil
    
    @State private var title: String = ""
    @State private var content: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextEditor(text: $content)
                .frame(minHeight: 150)
            
            Button("Save") {
                if let note = note {
                    viewModel.updateNote(note, newTitle: title, newContent: content)
                } else {
                    viewModel.addNote(title: title, content: content)
                }
                presentationMode.wrappedValue.dismiss()
            }
            .disabled(title.isEmpty || content.isEmpty)
        }
        .navigationTitle(note == nil ? "New Note" : "Edit Note")
        .onAppear {
            if let note = note {
                title = note.title
                content = note.content
            }
        }
    }
}
