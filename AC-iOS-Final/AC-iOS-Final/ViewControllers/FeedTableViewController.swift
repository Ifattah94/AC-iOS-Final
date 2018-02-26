//
//  FeedTableViewController.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController {

    var posts = [Post]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DBService.manager.getAllPosts { (onlinePosts) in
            self.posts = onlinePosts
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        DBService.manager.getAllPosts { (onlinePosts) in
            self.posts = onlinePosts
        }
    }
    
    func refreshTableView() {
        tableView.beginUpdates()
        tableView.setNeedsDisplay()
        tableView.endUpdates()
    }

  
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedTableViewCell
        let post = posts[indexPath.row]
        cell.configureCell(withPost: post)
        if let imgURL = post.imageURL {
            let img1str = imgURL
            let url1 = URL(string: img1str)
            cell.feedImageView.kf.setImage(with: url1) { (image, error, cache, url) in
                if let image = image {
                    let ratio = image.size.width / image.size.height
                    if ratio > 1 {
                        let newHeight = cell.frame.width / ratio
                        cell.feedImageView.bounds.size = CGSize(width: cell.frame.width, height: newHeight)
                        self.refreshTableView()
                    } else {
                        let newWidth = cell.frame.height * ratio
                        cell.feedImageView.frame.size = CGSize(width: newWidth, height: cell.frame.height)
                        self.refreshTableView()
                    }
                }
            }
        }

        return cell
    }
   

 

}
