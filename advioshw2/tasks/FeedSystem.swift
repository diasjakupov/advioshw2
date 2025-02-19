//
//  FeedSystem.swift
//  advioshw2
//
//  Created by Dias Jakupov on 19.02.2025.
//


class FeedSystem {
    private var userCache: [String: UserProfile] = [:]
    private var feedPosts: [Post] = []
    private var hashtags: Set<String> = []

    func addPost(_ post: Post) {
        feedPosts.insert(post, at: 0)
    }

    func removePost(_ post: Post) {
        if let index = feedPosts.firstIndex(of: post) {
            feedPosts.remove(at: index)
        }
    }

    func addUserProfile(_ profile: UserProfile) {
        userCache[profile.username] = profile
    }

    func addHashtag(_ hashtag: String) {
        hashtags.insert(hashtag)
    }

    func getFeedPosts() -> [Post] {
        return feedPosts
    }

    func getUserProfile(username: String) -> UserProfile? {
        return userCache[username]
    }

    func getHashtags() -> Set<String> {
        return hashtags
    }
}
