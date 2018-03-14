//
//  SelectUserViewController.swift
//  Snapchat
//
//  Created by William Hettinger on 3/13/18.
//  Copyright © 2018 William Hettinger. All rights reserved.
//

import UIKit
import Firebase

class SelectUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var users : [User] = []
    var imageURL = ""
    var descrip = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        
       // Database.database().reference().child("users").observe(DataEventType.childAdded, with: {(snapshot) in
        Database.database().reference().child("users").observe(DataEventType.childAdded, with: {(snapshot) in
            print(snapshot)
            
            let user = User()
            //user.email = snapshot.value["email"] as! String
            //let myemail = (snapshot.value! as? [String : AnyObject])!
            //print("myEmail = \(String(describing: myemail))")
            //let thisEmail = ((snapshot.value! as? [String : AnyObject])!["email"])!
            user.email = ((snapshot.value! as? [String : AnyObject])!["email"])! as! String
            //print("this email : \(thisEmail)")
            user.uid = snapshot.key
            
            self.users.append(user)
            self.tableView.reloadData()
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let user = users[indexPath.row]
        cell.textLabel?.text = user.email
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        let snap = ["from" : user.email, "description":descrip, "imageURL":imageURL]
        Database.database().reference().child("users").child(user.uid).child("snaps").childByAutoId().setValue(snap)
     navigationController?.popToRootViewController(animated: true)
    }
}
