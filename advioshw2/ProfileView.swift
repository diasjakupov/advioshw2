//
//  ProfileView.swift
//  advioshw2
//
//  Created by Dias Jakupov on 19.02.2025.
//

import SwiftUI

class ProfileViewModel: ObservableObject, ProfileUpdateDelegate {
    @Published var profile: UserProfile?
    @Published var errorMessage: String?
    
    private var profileManager: ProfileManager?

    init() {
        profileManager = ProfileManager(delegate: self)
        profileManager?.onProfileUpdate = { [weak self] profile in
            DispatchQueue.main.async {
                self?.profile = profile
            }
        }
    }

    func loadProfile(id: String) {
        profileManager?.loadProfile(id: id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let profile):
                    self?.profile = profile
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    // MARK: - ProfileUpdateDelegate Methods
    func profileDidUpdate(_ profile: UserProfile) {
        DispatchQueue.main.async {
            self.profile = profile
        }
    }

    func profileLoadingError(_ error: Error) {
        DispatchQueue.main.async {
            self.errorMessage = error.localizedDescription
        }
    }
}

class ImageLoaderViewModel: ObservableObject, ImageLoaderDelegate {
    @Published var image: UIImage?
    private var imageLoader: ImageLoader?

    init() {
        imageLoader = ImageLoader()
        imageLoader?.delegate = self
    }

    func loadImage(url: URL) {
        imageLoader?.loadImage(url: url)
    }

    // MARK: - ImageLoaderDelegate Methods
    func imageLoader(_ loader: ImageLoader, didLoad image: UIImage) {
        DispatchQueue.main.async {
            self.image = image
        }
    }

    func imageLoader(_ loader: ImageLoader, didFailWith error: Error) {
        print("Image loading failed: \(error.localizedDescription)")
    }
}

struct ProfileView: View {
    @StateObject private var profileVM = ProfileViewModel()
    @StateObject private var imageLoaderVM = ImageLoaderViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                if let img = imageLoaderVM.image {
                    Image(uiImage: img)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                } else {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 100, height: 100)
                }
                
                if let profile = profileVM.profile {
                    Text(profile.username)
                        .font(.title)
                    Text(profile.bio)
                        .font(.body)
                        .padding(.horizontal)
                    Text("Followers: \(profile.followers)")
                        .font(.subheadline)
                } else {
                    Text("Loading profile...")
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Profile")
            .onAppear {
                profileVM.loadProfile(id: "123")
                if let url = URL(string: "https://example.com/image.png") {
                    imageLoaderVM.loadImage(url: url)
                }
            }
        }
    }
}

