//
//  Models.swift
//  advioshw2
//
//  Created by Dias Jakupov on 19.02.2025.
//

import SwiftUI


struct UserProfile: Hashable {
    let id: UUID
    let username: String
    var bio: String
    var followers: Int

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(username)
    }

    static func == (lhs: UserProfile, rhs: UserProfile) -> Bool {
        return lhs.id == rhs.id && lhs.username == rhs.username
    }
}

struct Post: Hashable, Identifiable {
    let id: UUID
    let authorId: UUID
    var content: String
    var likes: Int

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id
    }
}
