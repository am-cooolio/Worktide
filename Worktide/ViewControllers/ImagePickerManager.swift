//
//  ImagePickerManager.swift
//  Worktide
//
//  Created by Kristofer Huang on 2019-10-31.
//  Copyright © 2019 Kristofer Huang. All rights reserved.
//


import Foundation
import UIKit


class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var picker = UIImagePickerController();
    var alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    var viewController: UIViewController?
    var pickImageCallback : ((UIImage) -> ())?;

    override init(){
        super.init()
    }

    func pickImage(_ viewController: UIViewController, _ callback: @escaping ((UIImage) -> ())) {
        pickImageCallback = callback;
        self.viewController = viewController;

        let cameraAction = UIAlertAction(title: "Camera", style: .default){
            UIAlertAction in
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title: "Gallery", style: .default){
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
            UIAlertAction in
        }

        // Add the actions
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
        alert.popoverPresentationController?.sourceView = self.viewController!.view
        viewController.present(alert, animated: true, completion: nil)
    }
    func openCamera(){
        alert.dismiss(animated: true, completion: nil)
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            self.viewController!.present(picker, animated: true, completion: nil)
        }
    }
    func openGallery(){
        alert.dismiss(animated: true, completion: nil)
        picker.sourceType = .photoLibrary
        self.viewController!.present(picker, animated: true, completion: nil)
    }


    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }


    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:       [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        pickImageCallback?(image)
  }



    @objc func imagePickerController(_ picker: UIImagePickerController, pickedImage: UIImage?) {
    }

}
