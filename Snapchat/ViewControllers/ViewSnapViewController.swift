//
//  ViewSnapViewController.swift
//  Snapchat
//
//  Created by William Hettinger on 3/14/18.
//  Copyright © 2018 William Hettinger. All rights reserved.
//

import UIKit
//import SDWebImage


class ViewSnapViewController: UIViewController {

    @IBOutlet weak var descripLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var snap = Snap()
    override func viewDidLoad() {
        super.viewDidLoad()

        descripLabel.text = snap.descrip
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
