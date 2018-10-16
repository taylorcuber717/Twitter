//
//  DetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Taylor McLaughlin on 10/15/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet: Tweet?
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUserInformation()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUserInformation() {
        
        if let tweet = self.tweet, let user = self.user {
            
            profilePicImageView.af_setImage(withURL: tweet.user.profilepic!)
            screenNameLabel.text = tweet.user.name
            usernameLabel.text = tweet.user.screenName
            tweetLabel.text = tweet.text
            timeStampLabel.text = tweet.createdAtString
            retweetCountLabel.text = "\(tweet.retweetCount)"
            favoriteCountLabel.text = "\(tweet.favoriteCount)"
            
        }
        
    }

}
