//
//  ProfileManager.swift
//  advioshw2
//
//  Created by Dias Jakupov on 19.02.2025.
//

import SwiftUI

protocol ProfileUpdateDelegate: AnyObject {
    func profileDidUpdate(_ profile: UserProfile)
    func profileLoadingError(_ error: Error)
}

class ProfileManager {
    private var activeProfiles: [String: UserProfile] = [:]
    weak var delegate: ProfileUpdateDelegate?
    var onProfileUpdate: ((UserProfile) -> Void)?

    init(delegate: ProfileUpdateDelegate) {
        self.delegate = delegate
    }

    func loadProfile(id: String, completion: @escaping (Result<UserProfile, Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) { [weak self] in
            let profile = UserProfile(id: UUID(), username: "User\(id)", bio: "This is user \(id)'s bio", followers: 100)
            self?.activeProfiles[id] = profile
            DispatchQueue.main.async {
                completion(.success(profile))
                self?.delegate?.profileDidUpdate(profile)
                self?.onProfileUpdate?(profile)
            }
        }
    }
}
