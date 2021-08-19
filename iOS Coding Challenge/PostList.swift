//
//  ContentView.swift
//  iOS Coding Challenge
//
//  Created by Olga Tilichenko on 19.08.21.
//

import SwiftUI

struct PostsList: View {
    @StateObject var listingViewModel: ListingViewModel

    
    var body: some View {
            List {
                ForEach(listingViewModel.posts) { post in
                    PostRow(post: post).onAppear {
                        if post.id == listingViewModel.posts.last?.id {
                        fetchListing(postUrl: post.authorFullname)
                        }
                      }
                                }
                if listingViewModel.isLoadingPage {
                        ProgressView()
                      }
            }
        .onAppear {
            fetchListing(postUrl: nil)
        }
    }
    
    private func fetchListing(postUrl: String?) {
        listingViewModel.fetchListing(after: postUrl)
    }
}

#if DEBUG
struct PostsList_Previews : PreviewProvider {
    static var previews: some View {
        PostsList(listingViewModel: ListingViewModel(service: RedditService()))
    }
}
#endif
