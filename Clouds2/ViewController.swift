//
//  ViewController.swift
//  Clouds2
//
//  Created by Alex Mathers on 2016-09-16.
//  Copyright © 2016 Malecks. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var cloudView: CloudView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshButton.layer.cornerRadius = 10.0 //(self.refreshButton.frame.width / 2.0)
        self.refreshButton.backgroundColor = UIColor.white
    }
    
    @IBAction func refreshView(_ sender: AnyObject) {
        self.cloudView.setNeedsDisplay()
    }
}

