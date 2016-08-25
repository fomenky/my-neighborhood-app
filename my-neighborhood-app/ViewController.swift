//
//  ViewController.swift
//  my-neighborhood-app
//
//  Created by AceGod on 8/22/16.
//  Copyright © 2016 AceGod. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    //var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.estimatedRowHeight = 88.0 // Set row heigh limit
        
        DataService.instance.loadPosts()
        
        // Add Observer to NSNotification
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(onPostsLoaded), name: "postsLoaded", object: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let post = DataService.instance.loadedPosts[indexPath.row]
        if let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as? PostCell!
        {
            cell.configureCell(post) // This glues EVERYTHING together!
            return cell
        }else{
            let cell = PostCell()
            cell.configureCell(post)
            return cell;
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 88.0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.loadedPosts.count
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Implement if you want to show more details in another VC
    }
    
    func onPostsLoaded (notif: AnyObject) {
        tableView.reloadData()
        
    }
    
}

