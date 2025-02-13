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
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(note.title)
                .font(.title)
                .bold()
                .strikethrough(note.isCompleted)
            
            Text(note.content)
                .font(.body)
                .foregroundColor(.secondary)
            
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
