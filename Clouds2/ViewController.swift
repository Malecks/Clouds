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
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cloudView: CloudView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshButton.layer.cornerRadius = 10.0
        self.saveButton.layer.cornerRadius = 10.0
        self.refreshButton.backgroundColor = UIColor.white
    }
    
    @IBAction func refreshView(_ sender: AnyObject) {
        self.cloudView.setNeedsDisplay()
    }
    
    @IBAction func shareCloud(_ sender: AnyObject) {
        self.createCloudImage()
    }
    
    func createCloudImage() {
        UIGraphicsBeginImageContext(cloudView.frame.size)
        self.cloudView.layer.render(in: UIGraphicsGetCurrentContext()!)
        if let cloudImage = UIGraphicsGetImageFromCurrentImageContext() {
            displayShareSheet(for: cloudImage)
        }
        UIGraphicsEndImageContext()
    }
    
    func displayShareSheet(for image: UIImage) {
        
        
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
}

