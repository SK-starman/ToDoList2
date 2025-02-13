//
//  ContentView.swift
//  ToDoList2
//
//  Created by Kalidy, Sammer on 2/13/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = NotesViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.notes) { note in
                    NavigationLink(destination: NoteDetailView(note: note, viewModel: viewModel)) {
                        HStack {
                            Image(systemName: note.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(note.isCompleted ? .green : .gray)
                            VStack(alignment: .leading) {
                                Text(note.title)
                                    .strikethrough(note.isCompleted)
                                    .foregroundColor(note.isCompleted ? .gray : .black)
                                Text(note.content)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: viewModel.deleteNote)
            }
            .navigationTitle("ToDo List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddEditNoteView(viewModel: viewModel)) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}
