//
//  InstaPostViewModel.swift
//  InstaCell
//
//  Created by Vitaliy on 17.06.2020.
//  Copyright © 2020 Vitaliy. All rights reserved.
//

import Foundation

class InstaPostsViewModel {
    
    var posts: [Post] = []
    
    func getPosts() -> Bool {
        do {
            let postsData = try PostsData(fileName: "Data")
            self.posts = postsData.posts
            return true
        } catch {
            print(error)
            return false
        }
    }
}
