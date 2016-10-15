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

    // MARK: SET PROPERTIES

    var detailItem: Article!

    @IBOutlet weak var webView: UIWebView!

    
    
    // MARK: VIEWDIDLOAD

    override func viewDidLoad() {
        prepareView()
        prepareWebView()
    }

    
    // MARK: FUNCTIONS
    
    // Prepare View

    func prepareView(){
        let shareBar: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem:.action, target: self, action: #selector(handleShareButton))        
        self.navigationItem.rightBarButtonItem = shareBar
    }
    
    
    // Prepare WebView

    func prepareWebView(){
        let urlAddress = detailItem.url
        let url = URL (string: urlAddress);
        let requestObj = URLRequest(url: url!);
        self.webView.loadRequest(requestObj)
    }
    
    
    
    // MARK: ACTIONS

    // Handle Share Button

    @IBAction func handleShareButton(_ sender: UIBarButtonItem) {
        
        let urlAddress = detailItem.url
        let firstActivityItem = "Interesting article"
        let secondActivityItem : URL = URL(string: urlAddress)!
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem], applicationActivities: nil)
        
        activityViewController.excludedActivityTypes = [
            UIActivityType.postToWeibo,
            UIActivityType.print,
            UIActivityType.assignToContact,
            UIActivityType.saveToCameraRoll,
            UIActivityType.addToReadingList,
            UIActivityType.postToFlickr,
            UIActivityType.postToVimeo,
            UIActivityType.postToTencentWeibo
        ]
        self.present(activityViewController, animated: true, completion: nil)
    }

}

