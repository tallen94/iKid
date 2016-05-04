//
//  ImgurAPI.swift
//  iKid
//
//  Created by Trevor Allen on 5/3/16.
//  Copyright © 2016 Trevor Allen. All rights reserved.
//

import Foundation
import Alamofire

public class ImgurAPI {
    
    private let client_id = "49895d7b0071e43"
    private let client_secret = "d464a14a3aba4f1f3ec7165d4ddf0aacd7832268"
    private static var authenticated : Bool = false
    private let manager = Manager.sharedInstance
    
    private var _images : [ImgurImage] = [ImgurImage]()
    
    public var Images : [ImgurImage] {
        get {return _images}
    }
    
    private static let _instance : ImgurAPI = ImgurAPI()
    
    public static var Instance : ImgurAPI {
        get {return _instance}
    }
    
    
    public func GetGallery(completionHandler: (Bool) -> ()) -> Void {
        manager.session.configuration.HTTPAdditionalHeaders = [
            "Authorization": "Client-ID \(client_id)"
        ]
        if let url = NSURL(string: "https://api.imgur.com/3/g/memes/") {
            let URLRequest = NSMutableURLRequest(URL: url)
            URLRequest.setValue("Client-ID \(client_id)", forHTTPHeaderField: "Authorization")
            URLRequest.HTTPMethod = "GET"
            Alamofire.request(URLRequest).responseJSON { response in
                
                if let JSON = response.result.value {
                    for item in JSON["data"] as! [Dictionary<String, AnyObject>] {
                        let imgur_image : ImgurImage = ImgurImage(object: item)
                        if imgur_image.GetAttrs()["is_album"] as! Int == 0 {
                            self._images.append(imgur_image)
                        }
                    }
                    completionHandler(true)
                } else {
                    completionHandler(false)
                }
            }
        } else {
            completionHandler(false)
        }
    }
}