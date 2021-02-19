//
//  NotificationService.swift
//  InstagramFireStore
//
//  Created by Zalzstein, Ziv on 30/01/2021.
//  Copyright © 2021 Zalzstein, Ziv. All rights reserved.
//

import Firebase

struct NotificationService {
    
    static func uploadNotification(toUid uid: String, fromUser: User, type: NotificationType, post: Post? = nil) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        guard uid != currentUid else { return }
        
        let document = COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications").document()
        let documentId = document.documentID
        
        var data: [String: Any] = ["timestamp": Timestamp(date: Date()),
                                   "uid": fromUser.uid,
                                   "type": type.rawValue,
                                   "id": documentId,
                                   "userProfileImageUrl": fromUser.profileImageUrl,
                                   "username": fromUser.username]
    
        if let post = post {
            data["postId"] = post.postId
            data["postImageUrl"] = post.imageUrl
        }
                
        document.setData(data)
        print("DEBUG: notification has worked")
    }
    
    static func fetchNotifications(completion: @escaping([Notification]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let query = COLLECTION_NOTIFICATIONS.document(uid).collection("user-notifications")
                    .order(by: "timestamp", descending: true)
        
        query.getDocuments { (snapshot, _) in
            guard let documents = snapshot?.documents else { return }
            
            let notifications = documents.map({ Notification(dictionary: $0.data()) })
            completion(notifications)
        }
    }
}
