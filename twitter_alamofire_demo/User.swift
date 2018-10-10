//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Taylor McLaughlin on 10/8/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import Foundation

class User{
    
    var name: String
    var screenName: String?
    var profilepic: URL?
    var bannerpic: URL?
    var friendcount: Int?
    var followercount: Int?
    var userid: Int64?
    var favoritecount: Int?
    var statuscCount: Int?
    
    var dictionary: [String: Any]?
    
    /*----Properties----*/
    
    /*-----Initializer----*/
    init(dictionary: [String: Any]) {
        self.dictionary = dictionary
        name = dictionary["name"] as! String
        if let profile: String = dictionary["profile_image_url_https"] as? String {
            profilepic = URL(string: profile)!
        }
        
        if let banner: String = dictionary["profile_banner_url"] as? String {
            bannerpic = URL(string: banner)!
        }
        
        if let screen = dictionary["screen_name"] as? String {
            self.screenName = screen
        }
        
        friendcount = dictionary["friends_count"] as! Int
        followercount = dictionary["followers_count"] as! Int
        statuscCount = dictionary["statuses_count"] as! Int
        favoritecount = dictionary["favourites_count"] as! Int
        
        guard let twitid: NSNumber = dictionary["id"] as? NSNumber else {
            print("Twitter ID Error")
            return
        }
        
        userid = twitid.int64Value
        
    }
    
    static var _current: User?
    static var current: User? {
        get {
            let defaults = UserDefaults.standard
            if let userData = defaults.data(forKey: "currentUserData") {
                let dicionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! [String: Any]
                return User(dictionary: dicionary)
            }
            return nil
        }
        set(user) {
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
        }
    }
    
    func getHomeTimeLine(completion: ([Tweet]?, Error?) -> ()) {
        //TODO: Call Alamofire request method
    }
    
}
