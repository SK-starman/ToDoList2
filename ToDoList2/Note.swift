//
//  Note.swift
//  ToDoList2
//
//  Created by Kalidy, Sammer on 2/13/25.
//

import Foundation

struct Note: Identifiable, Codable {
    var id: UUID = UUID()
    var title: String
    var content: String
    var isCompleted: Bool
}
