//
//  File.swift
//  InstaCell
//
//  Created by Vitaliy on 17.06.2020.
//  Copyright © 2020 Vitaliy. All rights reserved.
//

import Foundation

struct PostsData: Decodable {
    let posts: [Post]
    
    enum DecodingError: Error {
        case missingFile
    }
    
    init(fileName: String) throws {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            throw DecodingError.missingFile
        }
        
        let data = try Data(contentsOf: url)
        self = try JSONDecoder().decode(PostsData.self, from: data)
    }
}

struct Post: Decodable {
    let postOwnerIconURL: String
    let postOwnerName: String
    let whereFromUser: String
    let postFollowers: [String]
    let postLinkers: [String]
    let followersLinks: [String?]
    let postImages: [String]
    let postDate: String
}
