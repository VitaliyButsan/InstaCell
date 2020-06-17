//
//  InstaPostViewModel.swift
//  InstaCell
//
//  Created by Vitaliy on 17.06.2020.
//  Copyright © 2020 Vitaliy. All rights reserved.
//

import Foundation

class InstaPostsViewModel {
    
    func getPosts() -> [Post]? {
        do {
            let postsData = try PostsData(fileName: "Data")
            return postsData.posts
        } catch {
            print(error)
            return nil
        }
    }
}
