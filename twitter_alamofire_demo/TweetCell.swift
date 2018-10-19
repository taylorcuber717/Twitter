//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Taylor McLaughlin on 10/8/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet: Tweet? {
        didSet {
            profilePicImageView.af_setImage(withURL: (tweet?.user.profilepic)!)
            screenNameLabel.text = tweet?.user.name
            usernameLabel.text = "@" + (tweet?.user.screenName)!
            timeStampLabel.text = tweet?.createdAtString
            tweetLabel.text = tweet?.text
            retweetButton.setTitle("\(tweet!.retweetCount)", for: .normal)
            favoriteButton.setTitle("\(tweet!.favoriteCount!)", for: .normal)
            favoriteButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
            retweetButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
            replyButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
            if (tweet?.favorited)! {
                self.favoriteButton.imageView?.image = UIImage(named: "favor-icon-red")
            } else {
                self.favoriteButton.imageView?.image = UIImage(named: "favor-icon")
            }
            if (tweet?.retweeted)! {
                self.retweetButton.imageView?.image = UIImage(named: "retweet-icon-green")
            } else {
                self.retweetButton.imageView?.image = UIImage(named: "retweet-icon")
            }
        }
    }
    var user: User?
    var indexPath: IndexPath?
    var parentView: TimelineViewController?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onFavorite(_ sender: Any) {
        
        if (tweet?.favorited)! {
            APIManager.shared.unFavorite(tweet!) { (tweet, error) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                    //self.tweet = tweet
                    self.parentView?.completeNetworkRequest()
                }
            }
        } else {
            APIManager.shared.favorite(tweet!) { (tweet, error) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                    self.parentView?.completeNetworkRequest()
                }
            }
        }
        
    }
    
    @IBAction func onRetweet(_ sender: Any) {
        
        if (tweet?.retweeted)! {
            APIManager.shared.unRetweet(tweet!) { (tweet, error) in
                if let error = error {
                    print("Error unretweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unretweeted the following Tweet: \n\(tweet.text)")
                    self.parentView?.completeNetworkRequest()
                }
            }
        } else {
            APIManager.shared.retweet(tweet!) { (tweet, error) in
                if let error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                    self.parentView?.completeNetworkRequest()
                }
            }
        }
        
    }
    

    
}
