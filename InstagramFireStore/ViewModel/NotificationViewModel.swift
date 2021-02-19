//
//  NotificationViewModel.swift
//  InstagramFireStore
//
//  Created by Zalzstein, Ziv on 30/01/2021.
//  Copyright © 2021 Zalzstein, Ziv. All rights reserved.
//

import UIKit

struct NotificationViewModel {
    var notification: Notification
    
    init(notification: Notification) {
        self.notification = notification
    }
        
    var postImageUrl: URL? { return URL(string: notification.postImageUrl ?? "") }
    
    var profileImageUrl: URL? { return URL(string: notification.userProfileImageUrl)}
    
    var timestampString: String? {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: notification.timestamp.dateValue(), to: Date())
    }
    
    var notificationMessage: NSAttributedString {
        let username = notification.username
        let message = notification.type.notificationMessage
        
        let usernameAttributedText = NSAttributedString(string: username, attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        
        let messageAttributedText = NSAttributedString(string: message, attributes: [.font: UIFont.systemFont(ofSize: 14)])
        
        let dateAttributedText = NSAttributedString(string: " \(timestampString ?? "")", attributes: [.font: UIFont.boldSystemFont(ofSize: 12), .foregroundColor: UIColor.lightGray])
        
        let attributedText = NSMutableAttributedString()
        attributedText.append(usernameAttributedText)
        attributedText.append(messageAttributedText)
        attributedText.append(dateAttributedText)
        
        return attributedText
    }
    
    var shouldHidePostImage: Bool { return notification.type == .follow }
    
    var followButtonText: String { return notification.userIsFollowed ? "Following" : "Follow" }
    var followButtonBackgroundColor: UIColor { return notification.userIsFollowed ? .white : .systemBlue }
    var followButtonTextColor: UIColor { return notification.userIsFollowed ? .black : .white }
}
