//
//  User.swift
//  ToDoFire
//
//  Created by Ilya Dombrovsky on 2.07.22.
//

import Foundation
import Firebase

struct User {
    let uid: String
    let email: String
    init(user: FirebaseAuth.User) {
        self.uid = user.uid
        self.email = user.email!
 
    }
    
}
