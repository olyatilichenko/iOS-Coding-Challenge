//
//  PostRow.swift
//  iOS Coding Challenge
//
//  Created by Olga Tilichenko on 19.08.21.
//

import SwiftUI

struct PostRow: View {
    let post: Post
    
    var body: some View {
        VStack(spacing: 8.0) {
            Text(post.title)
                .font(.headline)
                .lineLimit(nil)
        
            RemoteImage(url: post.thumbURL)
                .aspectRatio(contentMode: .fit)
            
            HStack {
                Text("\(post.score)")
                    .frame(maxWidth: .infinity)
                Text("\(post.numComments)")
                    .frame(maxWidth: .infinity)
            }
        }
    }
}
