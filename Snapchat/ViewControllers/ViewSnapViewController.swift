//
//  ViewSnapViewController.swift
//  Snapchat
//
//  Created by William Hettinger on 3/14/18.
//  Copyright © 2018 William Hettinger. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase


class ViewSnapViewController: UIViewController {

    @IBOutlet weak var descripLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var snap = Snap()
    override func viewDidLoad() {
        super.viewDidLoad()

        descripLabel.text = snap.descrip
        imageView.sd_setImage(with: URL(string: snap.imageURL))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //print("Goodbye snap")
        Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("snaps").child(snap.key).removeValue()
    }
   

}
