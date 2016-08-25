//
//  Post.swift
//  my-neighborhood-app
//
//  Created by AceGod on 8/22/16.
//  Copyright © 2016 AceGod. All rights reserved.
//

import Foundation

class Post: NSObject, NSCoding {
    
    private var _imagePath: String!
    private var _title: String!
    private var _postDesc: String!
    
    var imagePath: String{
        return _imagePath        
    }
    
    var title: String{
        return _title
    }
    
    var postDesc: String{
        return _postDesc
    }
    
    // Constructor
    init(imagePath: String, title: String, postDesc: String){
        self._imagePath = imagePath
        self._title = title
        self._postDesc = postDesc
    }
    
    override init() {
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        self._imagePath = aDecoder.decodeObjectForKey("imagePath") as? String
        self._title = aDecoder.decodeObjectForKey("title") as? String
        self._postDesc = aDecoder.decodeObjectForKey("postDesc") as? String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self._imagePath, forKey: "imagePath")
        aCoder.encodeObject(self._title, forKey: "title")
        aCoder.encodeObject(self._postDesc, forKey: "postDesc")
    }
    
    
}