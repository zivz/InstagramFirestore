//
//  Comment.swift
//  InstagramFireStore
//
//  Created by Zalzstein, Ziv on 29/01/2021.
//  Copyright © 2021 Zalzstein, Ziv. All rights reserved.
//

import Firebase

struct Comment {
    let uid: String
    let username: String
    let profileImageUrl: String
    let timestamp: Timestamp
    let commentText: String
    
    init(dictionary: [String: Any]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.commentText = dictionary["comment"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
    }
}
