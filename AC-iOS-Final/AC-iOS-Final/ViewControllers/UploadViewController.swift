//
//  UploadViewController.swift
//  AC-iOS-Final
//
//  Created by C4Q on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class UploadViewController: UIViewController {

    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var commentTextField: UITextField!
    private let imagePickerController = UIImagePickerController()
    private var selectedImage: UIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        commentTextField.delegate = self
        

        
    }
    
    @IBAction func chooseImage(_ sender: UIButton) {
        showActionSheet()
    }
    
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        guard let commentText = commentTextField.text, !commentText.isEmpty else {
            showAlert(title: "Error", message: "leave a comment")
            return
        }
        guard postImageView.image != nil else {
            showAlert(title: "Error", message: "Please choose an image")
            return
        }
        DBService.manager.newPost(comment: commentText, image: postImageView.image)
        showAlert(title: "Success", message: "your post was added!")
        self.commentTextField.text = nil
        self.postImageView.image = nil 
        
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in}
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    

    func showActionSheet() {
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action) in
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.self.imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    

  

}

extension UploadViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        postImageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension UploadViewController: UINavigationControllerDelegate {
    
}

extension UploadViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
}


