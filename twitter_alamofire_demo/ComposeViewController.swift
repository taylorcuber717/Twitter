//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Taylor McLaughlin on 10/15/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import Alamofire

class ComposeViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postTextView: UITextView!
    @IBOutlet weak var remainingCharactersLabel: UILabel!
    @IBOutlet weak var postButton: UIBarButtonItem!
    
    var user: User?
    weak var delegate: ComposeViewControllerDelegate?
    
    @IBAction func onCancel(_ sender: Any) {
        self.performSegue(withIdentifier: "CancelSegue", sender: nil)
    }
    
    @IBAction func didTapPost(_ sender: Any) {
        
        APIManager.shared.composeTweet(with: postTextView.text) { (tweet, error) in
            if let error = error {
                print("Error Composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success")
            }
        }
        
        self.performSegue(withIdentifier: "CancelSegue", sender: nil)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if postTextView.text.count == 0 {
            postButton.isEnabled = false
        } else {
            postButton.isEnabled = true
        }
        remainingCharactersLabel.text = "\(140 - postTextView.text.count)/140 characters remaining"
        if postTextView.text.count >= 140 {
            return false
        } else {
            return true
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        remainingCharactersLabel.text = "\(140)/140 characters remaining"
        postButton.isEnabled = false
        postTextView.delegate = self as UITextViewDelegate
        updateUserInformation()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func updateUserInformation() {
        profilePicImageView.af_setImage(withURL: (user?.profilepic)!)
        screenNameLabel.text = user?.screenName
        usernameLabel.text = user?.name
    }

}

protocol ComposeViewControllerDelegate : class {
    func did(post: Tweet)
}
