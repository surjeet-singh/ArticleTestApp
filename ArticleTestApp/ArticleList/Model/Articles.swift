//
//  Articles.swift
//  AtticleTestApp
//
//  Created by Surjeet on 16/06/20.
//  Copyright © 2020 Surjeet. All rights reserved.
//

import UIKit

struct Article: Codable {

    var id: String?
    var content: String?
    var createdAt: String?
    var comments: Double?
    var likes: Double?
    
    var media: [Media]?
    var user: [User]?
}

struct Media: Codable {
    var id: String?
    var blogId: String?
    var createdAt: String?
    var image: String?
    var title: String?
    var url: String?
}

struct User: Codable {
    var id: String?
    var blogId: String?
    var createdAt: String?
    var name: String?
    var avatar: String?
    var lastname: String?
    var city: String?
    var designation: String?
    var about: String?
}
