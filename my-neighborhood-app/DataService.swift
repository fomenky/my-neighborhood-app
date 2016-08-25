//
//  DataService.swift
//  my-neighborhood-app
//
//  Created by AceGod on 8/24/16.
//  Copyright © 2016 AceGod. All rights reserved.
//
//  My-Singleton


import Foundation
import UIKit

class DataService {
    static let instance = DataService()
    
    let KEY_POSTS = "posts"
    
    private var _loadedPosts = [Post]() // initializing array (Save practice)
    var loadedPosts: [Post] {
        return _loadedPosts
    }
    
    // Save as NSUserDefaults
    func savePosts() {
        let postData = NSKeyedArchiver.archivedDataWithRootObject(_loadedPosts)
        NSUserDefaults.standardUserDefaults().setObject(postData, forKey: KEY_POSTS)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    // Return NSUserDefaults as? NSData
    func loadPosts() {
        
        //FIRST: Grab the data
        if let postData = NSUserDefaults.standardUserDefaults().objectForKey(KEY_POSTS) as? NSData{
            
            //NEXT: Convert data back to an object we can mess with [Post]
            if let postArray = NSKeyedUnarchiver.unarchiveObjectWithData(postData) as? [Post]{
                _loadedPosts = postArray
            }
        }
        
        // Add NSNotification 
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "postsLoaded", object: nil))
    }
    
    // Convert image to data with PNGRepresentation
    func saveImageAndCreatePath(image: UIImage) -> String {
        let imageData = UIImagePNGRepresentation(image)
        let imagePath = "image\(NSDate.timeIntervalSinceReferenceDate()).png"
        let fullPath = documentsPathForFileName(imagePath)
        imageData?.writeToFile(fullPath, atomically: true)
        
        return imagePath
    }
    
    func imageForPath(path: String) -> UIImage? {
        let fullPath = documentsPathForFileName(path)
        let image = UIImage(named: fullPath)
        
        return image
    }
    
    func addPost(post: Post) {
        _loadedPosts.append(post)
        savePosts()
        loadPosts()
    }
    
    //Images are stored in a documents directory
    func documentsPathForFileName(name: String) -> String {
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let fullpath = path[0] as NSString
        
        return fullpath.stringByAppendingPathComponent(name)
    }
}
