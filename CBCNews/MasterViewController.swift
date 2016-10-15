//
//  MasterViewController.swift
//  CBCNews
//
//  Created by Viviane Chan on 2016-09-28.
//  Copyright © 2016 Komrad. All rights reserved.
//

import UIKit
import GoogleMobileAds


class MasterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    // MARK: SET PROPERTIES
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bannerView: GADBannerView!
    
    var article: Article!
    var arrayOfArticles = [Article]()
    
    
    // MARK: VIEWDIDLOAD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        prepareBanner()
        parseJSON()
    }
    
    
    // MARK: VIEWWILLAPPEAR
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    
    
    // MARK: FUNCTIONS
    
    // parseJSON
    
    func parseJSON(){
        let requestURL: URL = URL(string: "http://www.cbc.ca/m/config/apps/samples/cbc-sample-lineup.json")!
        let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL)
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest as URLRequest) {
            (data, response, error) -> Void in
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            if (statusCode == 200) {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    
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
                    DispatchQueue.main.async(execute: {
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
        tableView.separatorStyle = .singleLine
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        tableView.frame =  CGRect(x: 0, y: statusBarHeight, width: self.view.frame.width, height: self.view.frame.height-statusBarHeight)
        tableView.sectionHeaderHeight = 45
        
        // title logo
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 27))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "CBCLogo")
        self.navigationItem.titleView = imageView
    }
    
    
    
    // prepare Ad Banner
    
    func prepareBanner() {
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    
    
    // MARK: SEGUES
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = self.arrayOfArticles[(indexPath as NSIndexPath).row]
                let controller = segue.destination as! DetailViewController
                controller.detailItem = object
            }
        }
    }
    
    
    
    // MARK: TABLEVIEW
    
    // number of sections
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    // number of rows
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfArticles.count
    }
    
    
    // cellForRowAtIndexPath
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! StoriesTableViewCell
        
        cell.titleLabel.text  = self.arrayOfArticles[(indexPath as NSIndexPath).row].title
        cell.pictureView.image = UIImage(data: try! Data(contentsOf: URL(string:self.arrayOfArticles[(indexPath as NSIndexPath).row].picture)!))
        return cell
    }
    
    
    // title for Header
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "TOP STORIES"
    }
    
    
    // format for Header 
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let title = UILabel()
        title.font = UIFont(name: "GillSans-Bold", size: 26)!
        let header = view as! UITableViewHeaderFooterView
        header.backgroundView?.backgroundColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1)
        header.textLabel?.font=title.font
    }
    
}

