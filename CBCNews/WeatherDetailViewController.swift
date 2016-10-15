//
//  WeatherDetailViewController.swift
//  Pods
//
//  Created by Viviane Chan on 2016-10-14.
//
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    
//    override func viewWillAppear(_ animated: Bool) {
//        backgroundView.backgroundColor = UIColor.blue
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    
    @IBAction func handleCloseButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
        
    }

} // closing bracket
