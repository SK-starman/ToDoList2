//
//  NotesDetailView.swift
//  ToDoList2
//
//  Created by Kalidy, Sammer on 2/13/25.
//

import SwiftUI

struct NoteDetailView: View {
    var note: Note
    @ObservedObject var viewModel: NotesViewModel
    @Environment(\.presentationMode) var presentationMode  // Allows closing the view after deleting
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(note.title)
                .font(.title)
                .bold()
                .strikethrough(note.isCompleted)
            
            Text(note.content)
                .font(.body)
                .foregroundColor(.secondary)
            
            // Toggle Completion Button
            Button(action: {
                viewModel.toggleCompletion(for: note)
            }) {
                Text(note.isCompleted ? "Mark as Incomplete" : "Mark as Completed")
                    .padding()
                    .background(note.isCompleted ? Color.gray : Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.top)
            
            Spacer()
            
            // Delete Button
            Button(action: {
                if let index = viewModel.notes.firstIndex(where: { $0.id == note.id }) {
                    viewModel.notes.remove(at: index)  // Remove the note from the array
                    viewModel.saveNotes()  // Save changes
                    presentationMode.wrappedValue.dismiss()  // Close the view
                }
            }) {
                Text("Delete Note")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .navigationTitle("Note Details")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: AddEditNoteView(viewModel: viewModel, note: note)) {
                    Text("Edit")
                }
            }
        }
    }
}
