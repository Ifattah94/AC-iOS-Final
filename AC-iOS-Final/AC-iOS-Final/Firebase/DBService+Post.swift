//
//  DBService+Post.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

extension DBService {
    func newPost(comment: String, image: UIImage?) {
        guard let currentUser = AuthUserService.manager.getCurrentUser() else {print("could not get current user"); return}
        let ref = postsRef.childByAutoId()
        
        let post = Post(comment: comment, userID: currentUser.uid)
        ref.setValue(["comment": post.comment,
                      "userID": post.userID
                      ])
        StorageService.manager.storePostImage(image: image, userID: ref.key)
        
    }
    
    func getAllPosts(completion: @escaping (_ posts: [Post]) -> Void) {
        postsRef.observe(.value) { (dataSnapshot) in
            var posts: [Post] = []
            guard let postSnapshots = dataSnapshot.children.allObjects as? [DataSnapshot] else {return}
            for postSnapshot in postSnapshots {
                guard let postObject = postSnapshot.value as? [String: Any] else {
                    return
                }
                guard let comment = postObject["comment"] as? String,
                let userID = postObject["userID"] as? String
                else { print("error getting posts");return}
                let imageURL = postObject["imageURL"] as? String
                let thisPost = Post(imageURL: imageURL, comment: comment, userID: userID)
                posts.append(thisPost)
                completion(posts)
            }
        }
    }
    
    public func addImageToPost(url: String, userID: String) {
        addImage(url: url, ref: postsRef, id: userID)
    }

}
