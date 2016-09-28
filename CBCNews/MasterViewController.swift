//
//  MasterViewController.swift
//  CBCNews
//
//  Created by Viviane Chan on 2016-09-28.
//  Copyright © 2016 Komrad. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    // MARK: Set properties
    
    @IBOutlet weak var tableView: UITableView!
    
    var article: Article!
    var listOfTitles = []
    var arrayOfArticles = [Article]()

    

    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        parseJSON()
    }
    
    
    
    // MARK: ViewWillAppear
    
    override func viewWillAppear(animated: Bool) {
    }
    
    
    
    // MARK: functions
    
    // parseJSON

    func parseJSON(){
        let requestURL: NSURL = NSURL(string: "http://www.cbc.ca/m/config/apps/samples/cbc-sample-lineup.json")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(URL: requestURL)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(urlRequest) {
            (data, response, error) -> Void in
            let httpResponse = response as! NSHTTPURLResponse
            let statusCode = httpResponse.statusCode
            if (statusCode == 200) {
                
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    
                    if let articles = json as? [[String: AnyObject]] {
                        for article in articles {
                            if let title = article["title"] as? String {
                                if let picture = article["imageLarge"] as? String {
                                    if let url = article["url"] as? String {
                                        let article = Article(picture: picture, title: title, url: url)
                                        self.arrayOfArticles.append(article)
                                        
                                    }
                                }
                            }
                        }
                    }
                    dispatch_async(dispatch_get_main_queue(), {
                        self.tableView.reloadData()
                    })
                }
                catch {
                    print("error serializing JSON: \(error)")
                }
            }
            print(self.arrayOfArticles)
        }
        task.resume()
    }
    


    // prepare View
    
    func prepareView(){
        tableView.separatorStyle = .SingleLine
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        tableView.frame =  CGRectMake(0, statusBarHeight, self.view.frame.width, self.view.frame.height-statusBarHeight)
        tableView.sectionHeaderHeight = 50
    }
    

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = self.arrayOfArticles[indexPath.row]
                let controller = segue.destinationViewController as! DetailViewController
                controller.detailItem = object
                

            }
        }
    }

    // MARK: - Table View
    
    
    // number of sections

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    // number of rowns

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.arrayOfArticles.count
    }

    
    // cellForRowAtIndexPath

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! StoriesTableViewCell
        
        cell.titleLabel.text  = self.arrayOfArticles[indexPath.row].title
        cell.pictureView.image = UIImage(data: NSData(contentsOfURL: NSURL(string:self.arrayOfArticles[indexPath.row].picture)!)!)
        return cell
    }
    

    // title for Header
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "News"
    }
    
    // format for title for Header

    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let title = UILabel()
        title.font = UIFont(name: "GillSans-Bold", size: 22)!
        let header = view as! UITableViewHeaderFooterView
        header.backgroundView?.backgroundColor = UIColor.whiteColor()
        header.textLabel?.font=title.font
    }
    


}

