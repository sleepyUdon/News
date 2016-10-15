//
//  WeatherViewController.swift
//  CBCNews
//
//  Created by Viviane Chan on 2016-10-12.
//  Copyright © 2016 Komrad. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var scrollview: UIScrollView!
    
    // setup properties
    var firstViewController :UIViewController!
    var secondViewController :UIViewController!
    var pages = [WeatherDetailViewController]()



    // MARK: VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup scrollview
        scrollview.isPagingEnabled = true
        scrollview.bounces = false
        scrollview.isDirectionalLockEnabled = true
        
        // create pages
        let page1 = createWeatherViewController(imageViewColor: UIColor.blue)
        let page2 = createWeatherViewController(imageViewColor: UIColor.purple)
        pages = [page1, page2]
        let views: [String: UIView]  = ["view": view,
                                        "page1":page1.view,
                                        "page2":page2.view]
        
        // set pages constraints
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[page1(==view)]|",
                                                                 options: [], metrics: [:], views: views)
        NSLayoutConstraint.activate(verticalConstraints)
        
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[page1(==view)][page2(==view)]|", options: [.alignAllTop,.alignAllBottom], metrics: [:], views: views)
        NSLayoutConstraint.activate(horizontalConstraints)
    }

    
    
    // MARK: FUNCTIONS

    
    // create view controllers
    func createWeatherViewController(imageViewColor: UIColor) -> WeatherDetailViewController {
        let weatherViewController = storyboard?.instantiateViewController(withIdentifier: "WeatherDetailViewController") as! WeatherDetailViewController
        weatherViewController.view.translatesAutoresizingMaskIntoConstraints = false
        weatherViewController.backgroundView.backgroundColor = imageViewColor
        scrollview.addSubview(weatherViewController.view)
        addChildViewController(weatherViewController)
        weatherViewController.didMove(toParentViewController: self)
        return weatherViewController
    }
    
    
    
    
} // End bracket
