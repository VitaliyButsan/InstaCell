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
        
        let decoder = JSONDecoder()
        let data = try Data(contentsOf: url)
        self = try decoder.decode(PostsData.self, from: data)
    }
}

struct Post: Decodable {
    let postOwnerName: String
    let postFollowers: [String]
    let postImages: [String]
}
