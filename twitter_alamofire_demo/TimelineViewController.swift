//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Aristotle on 2018-08-11.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import Alamofire

class TimelineViewController: UIViewController, UITableViewDataSource, ComposeViewControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBAction func didTapLogout(_ sender: Any) {
        APIManager.logout()
    }
    @IBAction func newPost(_ sender: Any) {
        self.performSegue(withIdentifier: "ComposeSegue", sender: nil)
    }
    @IBAction func onReply(_ sender: Any) {
        
        replyName = true
        self.performSegue(withIdentifier: "ComposeSegue", sender: nil)
        
    }
    @IBAction func goToProfile(_ sender: Any) {
        self.performSegue(withIdentifier: "ProfileSegue", sender: nil)
    }
    
    var replyName = false
    var tweets: [Tweet]? = []
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = self as UITableViewDataSource
        refreshControl.addTarget(self, action: #selector(completeNetworkRequest), for: UIControlEvents.valueChanged)
        // add refresh control to table view
        tableView.insertSubview(refreshControl, at: 0)
        completeNetworkRequest()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func completeNetworkRequest() {
        
        APIManager.shared.getHomeTimeLine { (tweets, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.tweets = tweets!
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell") as! TweetCell
        let tweet = tweets![indexPath.row]
        cell.tweet = tweet
        cell.parentView = self as TimelineViewController
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ComposeSegue" {
            let user = User.current
            if let composeViewController = segue.destination as? ComposeViewController {
                if replyName {
                    
                }
                composeViewController.delegate = self
                composeViewController.user = User.current
            }
        } else if segue.identifier == "DetailSegue" {
            let cell = sender as! TweetCell
            if let indexPath = tableView.indexPath(for: cell) {
                let tweet = tweets![indexPath.row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.tweet = tweet
                detailViewController.user = tweet.user
            }
        } else if segue.identifier == "ProfileSegue" {
            let user = User.current
            if let profileViewController = segue.destination as? ProfileViewController {
                profileViewController.user = user
                profileViewController.tweets = tweets
            }
        }
        
    }
    
    func did(post: Tweet) {
        
    }

}
