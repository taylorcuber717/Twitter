//  Tweet.swift
//  twitter_alamofire_demo
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.

import Foundation

class Tweet {
    
    /*---------------Properties (Instance Variables)-------------*/
    var id: Int64? // For favoriting, retweeting & replying
    var text: String // Text content of tweet
    var favoriteCount: Int? // Update favorite count label
    var favorited: Bool? // Configure favorite button
    var retweetCount: Int // Update favorite count label
    var retweeted: Bool // Configure retweet button
    var user: User // Contains name, screenname, etc. of tweet author
    var createdAtString: String // Display date
    
    /*
     * This is the initializer for a Tweet
     * @param - dictionary: This JSON dictionary is used to populate
     * the fields of the Tweet.
     */
    init(dictionary: [String: Any]) {
        
        // These are the tweet properties
        if let twitid: NSNumber = dictionary["id"] as? NSNumber{
            id = twitid.int64Value
            
        }
        text = dictionary["text"] as! String
        favoriteCount = dictionary["favorite_count"] as? Int
        favorited = dictionary["favorited"] as? Bool
        retweetCount = dictionary["retweet_count"] as! Int
        retweeted = dictionary["retweeted"] as! Bool
        
        // These are the user properties
        let user = dictionary["user"] as! [String: Any]
        self.user = User(dictionary: user)
        
        let createdAtOriginalString = dictionary["created_at"] as! String
        let formatter = DateFormatter()
        // Configure the input format to parse the date string
        formatter.dateFormat = "E MMM d HH:mm:ss Z y"
        // Convert String to Date
        let date = formatter.date(from: createdAtOriginalString)!
        // Configure output format
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        // Convert Date to String
        createdAtString = formatter.string(from: date)
        
    }
}

