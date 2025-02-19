//
//  FeedView.swift
//  advioshw2
//
//  Created by Dias Jakupov on 19.02.2025.
//

import SwiftUI

class FeedViewModel: ObservableObject {
    @Published var posts: [Post] = []
    private let feedSystem = FeedSystem()

    init() {
        loadDummyPosts()
    }

    func loadDummyPosts() {
        let post1 = Post(id: UUID(), authorId: UUID(), content: "Hello, world!", likes: 5)
        let post2 = Post(id: UUID(), authorId: UUID(), content: "SwiftUI is awesome!", likes: 15)
        let post3 = Post(id: UUID(), authorId: UUID(), content: "Just another post in the feed.", likes: 8)
        
        feedSystem.addPost(post1)
        feedSystem.addPost(post2)
        feedSystem.addPost(post3)
        
        posts = feedSystem.getFeedPosts()
    }
    
    func addPost(content: String) {
        let newPost = Post(id: UUID(), authorId: UUID(), content: content, likes: 0)
        feedSystem.addPost(newPost)
        posts = feedSystem.getFeedPosts()
    }
}


struct FeedView: View {
    @StateObject private var feedVM = FeedViewModel()
    @State private var showNewPostSheet = false
    @State private var newPostContent = ""
    
    var body: some View {
        NavigationView {
            List(feedVM.posts) { post in
                VStack(alignment: .leading, spacing: 8) {
                    Text(post.content)
                        .font(.body)
                    HStack {
                        Image(systemName: "hand.thumbsup")
                        Text("\(post.likes)")
                            .font(.subheadline)
                    }
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Feed")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showNewPostSheet = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showNewPostSheet) {
                VStack(spacing: 16) {
                    Text("New Post")
                        .font(.headline)
                    TextField("Enter post content", text: $newPostContent)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    Button("Add Post") {
                        if !newPostContent.isEmpty {
                            feedVM.addPost(content: newPostContent)
                            newPostContent = ""
                            showNewPostSheet = false
                        }
                    }
                    .padding()
                    Spacer()
                }
                .padding()
            }
        }
    }
}
