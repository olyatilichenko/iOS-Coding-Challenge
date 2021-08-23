//
//  RedditService.swift
//  iOS Coding Challenge
//
//  Created by Olga Tilichenko on 19.08.21.
//

import Foundation

class RedditService {
    
    private let session: URLSession
    private let decoder: JSONDecoder
    private let limit = 21
    
    init(session: URLSession = .shared, decoder: JSONDecoder = .init()) {
        self.session = session
        self.decoder = decoder
    }
    
    func getReddit(after postUrl: String?, completion: @escaping (Result<[Post], Error>) -> Void) {
        guard var url = URL(string: "https://www.reddit.com/.json?sort=new&limit=\(limit)") else {
            preconditionFailure("Failed to construct URL")
        }
        
        // Used before to get the older posts
        
        if let lastPost = postUrl, let newUrl = URL(string: url.absoluteString + "&before=\(lastPost)") {
            url = newUrl
        }
        
        print(url)
        
        session.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else {
                do {
                    let data = data ?? Data()
                    let response = try self?.decoder.decode(Listing.self, from: data)
                    completion(.success(response?.posts ?? []))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
