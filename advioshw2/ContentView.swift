//
//  ContentView.swift
//  advioshw2
//
//  Created by Dias Jakupov on 19.02.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            FeedView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Feed")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
        }
    }
}
