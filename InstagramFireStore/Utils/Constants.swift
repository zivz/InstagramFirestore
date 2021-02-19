//
//  Constants.swift
//  InstagramFireStore
//
//  Created by Zalzstein, Ziv on 25/01/2021.
//  Copyright © 2021 Zalzstein, Ziv. All rights reserved.
//

import Firebase

let COLLECTION_USERS = Firestore.firestore().collection("users")
let COLLECTION_FOLLOWERS = Firestore.firestore().collection("followers")
let COLLECTION_FOLLOWING = Firestore.firestore().collection("following")
let COLLECTION_POSTS = Firestore.firestore().collection("posts")
let COLLECTION_NOTIFICATIONS = Firestore.firestore().collection("notifications")
