//
//  Post.swift
//  iOS Coding Challenge
//
//  Created by Olga Tilichenko on 19.08.21.
//

import Foundation
import SwiftUI

struct Post: Identifiable {
    var id: String
    var title: String
    var author: String
    var authorFullname: String
    var url: String
    var numComments: Int
    var score: Int
    var thumbURL: String
}

// MARK: - Decodable
extension Post: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case author
        case authorFullname = "author_fullname"
        case url
        case numComments = "num_comments"
        case score
        case thumbURL = "thumbnail"
        
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let dataContainer = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        
        id = try dataContainer.decode(String.self, forKey: .id)
        title = try dataContainer.decode(String.self, forKey: .title)
        author = try dataContainer.decode(String.self, forKey: .author)
        authorFullname = try dataContainer.decode(String.self, forKey: .authorFullname)
        url = try dataContainer.decode(String.self, forKey: .url)
        numComments = try dataContainer.decode(Int.self, forKey: .numComments)
        score = try dataContainer.decode(Int.self, forKey: .score)
        thumbURL = try dataContainer.decode(String.self, forKey: .thumbURL)
    }
}
