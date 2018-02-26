//
//  DBService.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import FirebaseDatabase


class DBService: NSObject {
    private override init() {
        rootRef = Database.database().reference()
        postsRef = rootRef.child("Posts")
    }
    static let manager = DBService()
    
    var rootRef: DatabaseReference!
    var postsRef: DatabaseReference
    
    public func addImage(url: String, ref: DatabaseReference, id: String) {
        ref.child(id).child("imageURL").setValue(url)
        
    }
}
