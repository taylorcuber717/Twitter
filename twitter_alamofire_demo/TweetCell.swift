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
    @IBOutlet weak var replyImageView: UIImageView!
    @IBOutlet weak var replyCountLabel: UILabel!
    @IBOutlet weak var retweetImageView: UIImageView!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    var tweet: Tweet? {
        didSet {
            screenNameLabel.text = tweet?.user.screenName
            usernameLabel.text = tweet?.user.name
            timeStampLabel.text = tweet?.createdAtString
            tweetLabel.text = tweet?.text
            retweetCountLabel.text = "\(tweet!.retweetCount)"
            favoriteCountLabel.text = "\(tweet!.favoriteCount!)"
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

}
