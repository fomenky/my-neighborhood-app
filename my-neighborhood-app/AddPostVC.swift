//
//  AddPostVC.swift
//  my-neighborhood-app
//
//  Created by AceGod on 8/24/16.
//  Copyright © 2016 AceGod. All rights reserved.
//

import UIKit

// This class enherits from PickerControllerDelegate which is
// Dependend on NavigationControllerDelegate
class AddPostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descField: UITextField!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postImg.layer.cornerRadius = postImg.frame.width / 2
        postImg.clipsToBounds = true
        
        imagePicker = UIImagePickerController() //Initializing imagePickr
        imagePicker.delegate = self // Setting the delegate's events to self (this viewController)
    }    

    @IBAction func makePostBtnPressed(sender: UIButton) {
        if let title = titleField.text, let desc = descField.text, let img = postImg.image
        {
            let imagePath = DataService.instance.saveImageAndCreatePath(img)
            
            let post = Post(imagePath: imagePath, title: title, postDesc: desc)
            DataService.instance.addPost(post)
            dismissViewControllerAnimated(true, completion: nil)
        }
    }

    @IBAction func cancelBtbPressed(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addPicBtnPressed(sender: UIButton) {
        sender.setTitle("", forState: .Normal)
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        postImg.image = image
        
    }
}
