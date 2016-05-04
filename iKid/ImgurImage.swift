//
//  ImgurImage.swift
//  iKid
//
//  Created by Trevor Allen on 5/3/16.
//  Copyright © 2016 Trevor Allen. All rights reserved.
//

import Foundation

public class ImgurImage {
    
    private var attrs : Dictionary<String, AnyObject> = Dictionary<String, AnyObject>()
    
    init(object: Dictionary<String, AnyObject>) {
        self.attrs = object
    }
    
    public func GetAttrs() -> Dictionary<String, AnyObject> {
        return self.attrs
    }
    
    public func addKey(key: String, value: AnyObject) {
        self.attrs[key] = value
    }
}
