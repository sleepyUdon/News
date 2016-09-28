//
//  DetailViewController.swift
//  CBCNews
//
//  Created by Viviane Chan on 2016-09-28.
//  Copyright © 2016 Komrad. All rights reserved.
//

import UIKit
import MessageUI

class DetailViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    var detailItem: Article!

    @IBOutlet weak var webView: UIWebView!

 
    override func viewDidLoad() {
        prepareView()
        prepareWebView()
    }

    func prepareView(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .Plain, target: self, action: #selector(handleShareButton))
    }
    
    func prepareWebView(){
        let urlAddress = detailItem.url
        let url = NSURL (string: urlAddress);
        let requestObj = NSURLRequest(URL: url!);
        self.webView.loadRequest(requestObj)
    }
    
    @IBAction func handleShareButton(sender: UIBarButtonItem) {
        
        let urlAddress = detailItem.url

        let firstActivityItem = "Interesting article"
        let secondActivityItem : NSURL = NSURL(string: urlAddress)!
        
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem], applicationActivities: nil)
        
        activityViewController.excludedActivityTypes = [
            UIActivityTypePostToWeibo,
            UIActivityTypePrint,
            UIActivityTypeAssignToContact,
            UIActivityTypeSaveToCameraRoll,
            UIActivityTypeAddToReadingList,
            UIActivityTypePostToFlickr,
            UIActivityTypePostToVimeo,
            UIActivityTypePostToTencentWeibo
        ]
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }

}

