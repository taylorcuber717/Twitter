//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Taylor McLaughlin on 10/19/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import Alamofire

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var numberOfTweetsLabel: UILabel!
    @IBOutlet weak var numberOfFollowingLabel: UILabel!
    @IBOutlet weak var numberOfFollowersLabel: UILabel!
    @IBOutlet weak var tweetTableView: UITableView!
    
    var user: User?
    var tweets: [Tweet]? = []
    
    @IBAction func backButton(_ sender: Any) {
        self.performSegue(withIdentifier: "BackSegue", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTableView.delegate = self
        tweetTableView.dataSource = self
        if let bannerPic = user?.bannerpic {
            backgroundImageView.af_setImage(withURL: bannerPic)
        }
        
        profileImageView.af_setImage(withURL: (user?.profilepic)!)
        usernameLabel.text = user?.name
        screenNameLabel.text = "@\((user?.screenName)!)"
        numberOfTweetsLabel.text = "\((user?.statuscCount)!) Tweets"
        numberOfFollowingLabel.text = "\((user?.friendcount)!) Following"
        numberOfFollowersLabel.text = "\((user?.followercount)!) Followers"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tweetTableView.dequeueReusableCell(withIdentifier: "TweetCell") as! TweetCell
        let tweet = tweets![indexPath.row]
        cell.tweet = tweet
        //cell.parentView = self as ProfileViewController
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
