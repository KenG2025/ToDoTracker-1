//
//  ContentView.swift
//  ToDoTracker
//
//  Created by Ken Gonzalez on 3/3/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var taskGroups: [TaskGroup] = []
    @State private var selectedGroup: TaskGroup?
    //Core difference between iPhone and iPad
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    @State private var isShowingAddGroup = false
    @Environment(\.scenePhase) private var scenePhase
    let saveKey = "saveTaskGroups"
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @AppStorage("isDarkModeOff") private var isDarkModeOff = false
    //MARK: Have a dark mode feature added into your app
    //@AppStorage: To modify to complete behavior of fyour applicaton
    @Environment(\.dismiss) private var dismiss
    @Binding var profile: Profile
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            //Column 1: let of navigation
            List(selection: $selectedGroup) {
                ForEach(profile.groups) {group in
                    NavigationLink(value: group) {
                        Label(group.title, systemImage: group.symbolName)
                    }
                }
            }
            .navigationTitle(profile.name)
            .listStyle(.sidebar)
            .toolbar {
                ToolbarItem(placement: .primaryAction){
                    Button {
                        isShowingAddGroup = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                }
                ToolbarItem(placement: .topBarLeading){
                    Toggle(isOn: $isDarkMode) {
                        Image(systemName: isDarkMode ? "sun.max.fill" : "moon.fill")
                        
                    }
                }
            }
            
        } detail: {
            if let group = selectedGroup {
                if let index = profile.groups.firstIndex(where: { $0.id == group.id}) {
                    TaskGroupDetailView(group: $profile.groups [index])
                }else{
                    ContentUnavailableView("Select a Group", systemImage: "sidebar.left")
                }
            }
        }
        //        .preferredColorScheme(isDarkMode ? .dark : .light )
        //        .toolbar {
        //            Toggle(isOn: $isDarkMode){
        //                Image(systemName: isDarkMode ? "moon.fill" : "sun.max.fill")
        //            }
        //        }
        .sheet(isPresented: $isShowingAddGroup){
            NewGroupView {newGroup in
                taskGroups.append(newGroup)
                selectedGroup = newGroup}
        }
        .onAppear{
            loadData() //New function
        }
        .onChange(of: scenePhase) { oldValue, newValue in
            if newValue == .active{
                print("🟢 app is active")
            }else if newValue == .inactive {
                print("🔴 App is inactive")
            }else if newValue == .background {
                print("🟡 Background state, saving data...")
                saveData() //New function
            }
            
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        
    }
    func loadData() {
        if let saveData = UserDefaults.standard.data(forKey: saveKey){
            if let decodedGroups = try? JSONDecoder().decode([TaskGroup].self, from: saveData){
                profile.groups = decodedGroups
                return //Success
            }
        }
        if profile.groups.isEmpty { profile.groups = TaskGroup.sampleData //Default data if there is no data
        }
        
    }
    
    func saveData() {
        if let encodedGroups = try? JSONEncoder().encode(profile.groups){
            UserDefaults.standard.set(encodedGroups, forKey: saveKey)
        }
    }
}
