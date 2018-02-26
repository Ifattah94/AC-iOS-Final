//
//  AuthUserService.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import FirebaseAuth

class AuthUserService {
    private init() {
        self.auth = Auth.auth()
    }
   public static let manager = AuthUserService()
   private let auth: Auth!
    
    public func getCurrentUser() -> User? {
        return auth.currentUser
    }
    
    public func createAccount(withEmail email: String, andPassword password: String, completion: @escaping (User?, Error?) -> Void) {
        auth.createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                completion(nil, error)
            } else if let user = user {
                completion(user, nil)
            }
        }
    }
    
    public func signIn(withEmail email: String, andPassword password: String, completion: @escaping (User?, Error?) -> Void) {
        auth.signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print("failed to sign in")
                completion(nil, error)
            } else if let user = user {
                print("successfully signed in")
                completion(user, nil)
            }
        }
    }
    
    public func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("could not sign out")
        }
    }
    
    
    
    
}
