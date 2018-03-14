//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by William Hettinger on 3/8/18.
//  Copyright © 2018 William Hettinger. All rights reserved.
//

import UIKit
import Firebase

class SnapsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var snaps : [Snap] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        //Database.database().reference().child("users").observe(DataEventType.childAdded, with: {(snapshot) in
        Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("snaps").observe(DataEventType.childAdded, with:  {(snapshot) in
        print(snapshot)
            
            let snap = Snap()
            //((snapshot.value! as? [String : AnyObject])!["email"])! as! String
            snap.imageURL = ((snapshot.value! as? [String : AnyObject])!["imageURL"])! as! String
            snap.descrip = ((snapshot.value! as? [String : AnyObject])!["description"])! as! String
            snap.from = ((snapshot.value! as? [String : AnyObject])!["from"])! as! String
//            -> not working //user.email = snapshot.value["email"] as! String
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snaps.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = snaps[indexPath.row].from
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snap = snaps[indexPath.row]
        performSegue(withIdentifier: "viewSnapSegue", sender: snap)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewSnapSegue" {
        let nextVC = segue.destination as! ViewSnapViewController
        nextVC.snap = sender as! Snap
        }
    }
}
