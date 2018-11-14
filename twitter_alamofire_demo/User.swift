//  User.swift
//  twitter_alamofire_demo
//  Created by Taylor McLaughlin on 10/8/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.

import Foundation

class User{
    
    /*---------------Properties (Instance Variables)-------------*/
    var name: String
    var screenName: String?
    var profilepic: URL?
    var bannerpic: URL?
    var friendcount: Int?
    var followercount: Int?
    var userid: Int64?
    var favoritecount: Int?
    var statuscCount: Int?
    
    // This idctionary is used to hold the JSON even after it is
    // used to initialize the User
    var dictionary: [String: Any]?
    
    /**
     * @param - dictionary: This JSON dictionary is used to populate
     * the fields for the User
     */
    init(dictionary: [String: Any]) {
        
        self.dictionary = dictionary // Saving JSON into my private fields
        
        name = dictionary["name"] as! String
        
        // These are extracting images
        if let profile: String = dictionary["profile_image_url_https"] as? String {
            profilepic = URL(string: profile)!
        }
        
        if let banner: String = dictionary["profile_banner_url"] as? String {
            bannerpic = URL(string: banner)!
        }
        
        if let screen = dictionary["screen_name"] as? String {
            self.screenName = screen
        }
        
        // These are the user's counts
        friendcount = dictionary["friends_count"] as! Int
        followercount = dictionary["followers_count"] as! Int
        statuscCount = dictionary["statuses_count"] as! Int
        favoritecount = dictionary["favourites_count"] as! Int
        
        // Retrieve the Tweet ID, if possible
        guard let twitid: NSNumber = dictionary["id"] as? NSNumber else {
            print("Twitter ID Error")
            return
        }
        
        userid = twitid.int64Value
        
    }
    
    /*---------------Code for Persistence-------------*/
    static var _current: User?
    
    // This property observer sets and gets User information as needed
    static var current: User? {
        // When getting, you access UserDefaults
        get {
            let defaults = UserDefaults.standard
            if let userData = defaults.data(forKey: "currentUserData") {
                let dicionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! [String: Any]
                return User(dictionary: dicionary)
            }
            return nil
        }
        // When setting...
        set(user) {
            let defaults = UserDefaults.standard
            // ...you either svae the defaults...
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
            // ... or remove them...
        }
    }
    
    func getHomeTimeLine(completion: ([Tweet]?, Error?) -> ()) {
        //TODO: Call Alamofire request method
    }
    
}
