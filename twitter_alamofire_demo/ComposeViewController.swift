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
    
    var user: User?
    weak var delegate: ComposeViewControllerDelegate?

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
        profilePicImageView.af_setImage(withURL: (user?.profilepic)!)
        screenNameLabel.text = user?.screenName
        usernameLabel.text = user?.name
    }

}

protocol ComposeViewControllerDelegate : class {
    func did(post: Tweet)
}
