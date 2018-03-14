//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by William Hettinger on 3/8/18.
//  Copyright © 2018 William Hettinger. All rights reserved.
//

import UIKit
import Firebase

class SnapsViewController: UIViewController {

    var snaps : [Snap] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Database.database().reference().child("users").observe(DataEventType.childAdded, with: {(snapshot) in
        Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("snaps").observe(DataEventType.childAdded, with:  {(snapshot) in
        print(snapshot)
            
            let snap = Snap()
//            snap.imageURL = snapshot.value!["imageURL"] as! String
//            snap.descrip = snapshot.value!["description"] as! String
//            snap.from = snapshot.value!["from"] as! String
//            //user.email = snapshot.value["email"] as! String
//            let myemail = (snapshot.value! as? [String : AnyObject])!
//            print("myEmail = \(String(describing: myemail))")
//            let thisEmail = (myemail["email"])!
//            user.email = thisEmail as! String
//            print("this email : \(thisEmail)")
//            user.uid = snapshot.key
        
            self.snaps.append(snap)
            self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func logOutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
