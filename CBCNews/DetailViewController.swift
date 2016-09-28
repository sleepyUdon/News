//
//  DetailViewController.swift
//  CBCNews
//
//  Created by Viviane Chan on 2016-09-28.
//  Copyright © 2016 Komrad. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var detailItem: Article!

    @IBOutlet weak var webView: UIWebView!

 

    override func viewDidLoad() {
        let urlAddress = detailItem.url
        let url = NSURL (string: urlAddress);
        let requestObj = NSURLRequest(URL: url!);
        self.webView.loadRequest(requestObj);
    }



}

