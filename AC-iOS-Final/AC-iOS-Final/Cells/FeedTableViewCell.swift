//
//  FeedTableViewCell.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import Kingfisher

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var feedImageView: UIImageView!
    
    @IBOutlet weak var feedCommentLabel: UILabel!
    
    public func configureCell(withPost post: Post) {
        self.feedCommentLabel.text = post.comment
        
    }
    
    func setPostImage(withPost post: Post) {
        
        if let postURLString = post.imageURL, let imageURL = URL(string: postURLString) {
            ImageCache(name: post.imageURL!).retrieveImage(forKey: post.imageURL!, options: nil, completionHandler: { (image, _) in
                if let image = image {
                    self.feedImageView.image = image
                    self.layoutIfNeeded()
                } else {
                    self.feedImageView.kf.setImage(with: imageURL, placeholder: #imageLiteral(resourceName: "placeholder-image"), options: nil, progressBlock: nil, completionHandler: { (image, error, _, _) in
                        if let image = image {
                            ImageCache(name: post.userID).store(image, forKey: post.userID) }
                    })
                }
            })
        }
    }
    
    
    
    
}
