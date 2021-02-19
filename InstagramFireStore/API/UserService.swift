//
//  UserService.swift
//  InstagramFireStore
//
//  Created by Zalzstein, Ziv on 25/01/2021.
//  Copyright © 2021 Zalzstein, Ziv. All rights reserved.
//

import Foundation
import Firebase

typealias FirestoreCompletion = (Error?) -> Void

struct UserService {
    static func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        COLLECTION_USERS.document(uid).getDocument { (snapshot, error) in
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
    
    static func fetchUsers(completion: @escaping([User]) -> Void) {
        COLLECTION_USERS.getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            
            let users = snapshot.documents.map({ User(dictionary: $0.data() )})
            completion(users)
        }
    }
    
    static func follow(uid: String, completion: @escaping(FirestoreCompletion)) {
        guard let currentUId = Auth.auth().currentUser?.uid else { return }
        COLLECTION_FOLLOWING.document(currentUId).collection("user-following").document(uid).setData([:]) { (error) in
                    
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUId).setData([:], completion: completion)
        }
    }
    
    static func unfollow(uid: String, completion: @escaping(FirestoreCompletion)) {
        guard let currentUId = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_FOLLOWING.document(currentUId).collection("user-following").document(uid).delete { (error) in
            
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUId).delete(completion: completion)
        }
    }
    
    static func checkIfUserIsFollowed(uid: String, completion: @escaping(Bool) -> Void ) {
        guard let currentUId = Auth.auth().currentUser?.uid else { return }

        COLLECTION_FOLLOWING.document(currentUId).collection("user-following").document(uid).getDocument { (snapshot, error) in
            guard let isFollowed = snapshot?.exists else { return }
            completion(isFollowed)
        }
    }
    
    static func fetchUserStats(uid: String, completion: @escaping(UserStats) -> Void) {
        COLLECTION_FOLLOWERS.document(uid).collection("user-followrs").getDocuments { (snapshot, _) in
            let followers = snapshot?.documents.count ?? 0
            
            COLLECTION_FOLLOWING.document(uid).collection("user-following").getDocuments { (snapshot, _) in
                let following = snapshot?.documents.count ?? 0
                
                COLLECTION_POSTS.whereField("ownerUid", isEqualTo: uid).getDocuments { (snapshot, _) in
                    let posts = snapshot?.documents.count ?? 0
                    completion(UserStats(followers: followers, following: following, posts: posts))
                }
            }
        }
    }
}
