//
//  SourceJSON.swift
//  InstaCell
//
//  Created by Vitaliy on 17.06.2020.
//  Copyright © 2020 Vitaliy. All rights reserved.
//

import Foundation

public func getJSONData() -> Data? {
    if JSONSerialization.isValidJSONObject(jsonObject) {
        do {
            return try JSONSerialization.data(withJSONObject: jsonObject, options: .sortedKeys)
        } catch {
            print(error)
            return nil
        }
    } else {
        print("ERROR: JSON data is incorrect!")
        return nil
    }
}

let jsonObject: [String: Any] = [
    "posts" : jsonPost
]

let jsonPost: [String: Any] = [
    "postOwnerIconURL" : "",
    "postOwnerName" : "",
    "postImages" : postImages,
    "postLinkers" : postLinkers,
    "postIsLiked" : false,
    "postPublishedDate": "",
    "postFollowers" : followers
]

let followers: [String] = [
    "milena_thebrowbar",
    "Beauty",
    #"@anna_zavadskaya 💙🌍💫"#,
    "@covernumberone",
    "#thebrowbarkharkov",
    "#makeup",
    "#inlove",
    "#thebrowbarkharkov"
]

let postImages: [String] = [
    "link1",
    "link2",
    "link3"
]

let postLinkers = [
    "milena_trump",
    "lenka_taranets_tensnailkitchen",
    "barak_obama",
    "donald_trump",
    "vladimir_zelensky",
    "leonid_kuchma",
    "bill_clinton",
]
