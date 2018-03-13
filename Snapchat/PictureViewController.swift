//
//  PictureViewController.swift
//  Snapchat
//
//  Created by William Hettinger on 3/8/18.
//  Copyright © 2018 William Hettinger. All rights reserved.
//

import UIKit
import Firebase

class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var pictureView: UIImageView!
    
    @IBOutlet weak var DescriptionTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
    }

    @IBAction func nextTapped(_ sender: Any) {
        self.nextButton.isEnabled = false
        let imagesFolder = Storage.storage().reference().child("images")
        
        let imageData = UIImageJPEGRepresentation(pictureView.image!, 0.1)
        imagesFolder.child("\(NSUUID().uuidString).jpg").putData(imageData!, metadata: nil, completion: {(metadata, error) in
            
            if error != nil {
                print("error putting image: \(String(describing: error))")
            } else {
                print(metadata?.downloadURL())
                self.performSegue(withIdentifier: "selectUserSegue", sender: nil)
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum //while testing
        imagePicker.allowsEditing = false //while testing
        present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        pictureView.image = image
        pictureView.backgroundColor = UIColor.clear
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
