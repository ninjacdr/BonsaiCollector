//
//  BonsaiViewController.swift
//  BonsaiCollector
//
//  Created by weeZie on 12/2/16.
//  Copyright © 2016 weeZie. All rights reserved.
//

import UIKit

class BonsaiViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var addUpdateButton: UIButton!
    @IBOutlet weak var bonsaiImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    var bonsai : Bonsai? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        if bonsai != nil {
            bonsaiImageView.image = UIImage(data: bonsai!.image as! Data)
            titleTextField.text = bonsai!.title
            
            addUpdateButton.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true
        }
        
        // Do any additional setup after loading the view.
    }

    
    @IBAction func photosTapped(_ sender: Any) {
        
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        bonsaiImageView.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        if bonsai != nil {
            bonsai!.title = titleTextField.text
            bonsai!.image = UIImagePNGRepresentation(bonsaiImageView.image!) as NSData?
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let bonsai = Bonsai(context: context)
            bonsai.title = titleTextField.text
            bonsai.image = UIImagePNGRepresentation(bonsaiImageView.image!) as NSData?
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
        
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        context.delete(bonsai!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
    }
}

