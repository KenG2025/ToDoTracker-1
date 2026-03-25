//
//  DashboardView.swift
//  ToDoTracker
//
//  Created by Ken Gonzalez on 3/17/26.
//

import SwiftUI

struct DashboardView: View {
    @State private var profiles: [Profile] = Profile.sample //Mock data on TaskModels
    @State private var path = NavigationPath()
    
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
        
    ]
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                ScrollView {
                    VStack {
                        VStack(spacing: 10){
                            Text("Welcome Back")
                                .font(.headline)
                                .textCase(.uppercase)
                            Text("Who is working today")
                                .font(.subheadline)
                        }//VStack
                        LazyVGrid(columns: columns, spacing: 25) {
                            ForEach($profiles) { $profile in
                                NavigationLink(value: profile){
                                    Image(profile.profileImage)
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(RoundedRectangle(cornerRadius: 22))
                                    Text(profile.name)
                                        .fontWeight(.bold)
                                        .foregroundColor(.orange)
                                }//NavigationLink
                                .buttonStyle(PlainButtonStyle())
                            }//ForEach
                        }//LazyVGrid
                    }//VStack
                }//ScrollView
                .navigationTitle("Home")
                .navigationDestination(for: Profile.self) { selectedProfile in
                    if let index = profiles.firstIndex(where: {$0.id == selectedProfile.id}) {
                        
                        ContentView(profile: $profiles[index])
                    }
                }
            }//ZStack
        }//NavigationStack
    }//var body
}//struct


