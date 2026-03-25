//
//  TaskModels.swift
//  ToDoTracker
//
//  Created by Ken Gonzalez on 3/3/26.
//

// This file will be the logic (brain) of our app.

import Foundation


struct TaskItem: Identifiable, Hashable, Codable {
    var id = UUID()
    var title: String
    var isCompleted: Bool = false
    var isDarkMode: Bool = false
}

struct TaskGroup: Identifiable, Hashable, Codable{
    var id = UUID()
    var title: String
    var symbolName: String
    var tasks: [TaskItem]
}

struct Profile: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var profileImage: String
    var groups: [TaskGroup]
}

//Mock-data to test our app
extension TaskGroup {
    static let sampleData: [TaskGroup] = [
        TaskGroup(title: "school", symbolName: "book.fill", tasks: [TaskItem(title: "Graded Assignments"), TaskItem(title: "Prepare Lecture")]),
        TaskGroup(title: "Home", symbolName: "house.fill", tasks: [TaskItem(title: "Buy Gooceries"), TaskItem(title: "Cook Dinner")])
    ]
}

extension Profile {
    static let sample: [Profile] = [
        Profile(name: "Professor" , profileImage: "professor_img", groups: TaskGroup.sampleData),
        Profile(name: "Student" , profileImage: "student_img", groups: [])
    ]
}
