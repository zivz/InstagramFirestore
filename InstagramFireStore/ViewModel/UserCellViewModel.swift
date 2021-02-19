//
//  UserCellViewModel.swift
//  InstagramFireStore
//
//  Created by Zalzstein, Ziv on 26/01/2021.
//  Copyright © 2021 Zalzstein, Ziv. All rights reserved.
//

import Foundation

struct UserCellViewModel {
    private let user: User
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImageUrl)
    }
    
    var username: String {
        return user.username
    }
    
    var fullname: String {
        return user.fullname
    }
    
    init(user: User) {
        self.user = user
    }
}
