//
//  ListingViewModel.swift
//  iOS Coding Challenge
//
//  Created by Olga Tilichenko on 19.08.21.
//

import Combine
import Foundation
import SwiftUI

class ListingViewModel: ObservableObject {
    let service: RedditService
    
    @Published var posts = [Post]()
    
    @Published var isLoadingPage = false
    
    init(service: RedditService) {
        self.service = service
    }
    
    func fetchListing(after postURL: String?) {
        guard !isLoadingPage else { return }
        
        isLoadingPage = true
        
        service.searchSubreddit(after: postURL) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoadingPage = false
                
                switch result {
                case .success(let posts):
                    let filteredPosts = posts.filter { $0.thumbURL != "self" && $0.thumbURL != "default" }
                    print(filteredPosts.count)
                    self?.posts += filteredPosts
                    print("fetch data")
                case .failure:
                    self?.posts = []
                }
            }
        }
    }
}
