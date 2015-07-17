//
//  FirstViewController.swift
//  memeApp
//
//  Created by masters3d on 5/12/15.
//  Copyright (c) 2015 masters3d. All rights reserved.
//

import UIKit
import MobileCoreServices


class FirstViewController: UIViewController, UIImagePickerControllerDelegate, UIAlertViewDelegate, UINavigationControllerDelegate,
UITextFieldDelegate{
    
    @IBAction func cameraButton(sender: AnyObject) {
        showCameraPicker()
    }
    
    @IBOutlet var viewComposite: UIView!
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var topText: UITextField!
    
    @IBOutlet var bottomText: UITextField!
    
    var cameraUI = UIImagePickerController()
    
    @IBAction func share(sender: AnyObject) {
        let image2share = viewComposite.jj_takeSnapshotOfCurrentFrame()
        shareImage(image2share)
    }
    
    @IBOutlet var cancelLabel: UIBarButtonItem!
    
    @IBAction func cancelButton(sender: AnyObject) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Checks to see if font exist
        
        assert(contains((UIFont.familyNames() as! [String]), "Impact"), "Impact font does not exist")
        
        // Sets custom font

        topText.text = "TOP"
        bottomText.text = "BOTTOM"

        
        func setTextAttibutes(input:UITextField){
            input.defaultTextAttributes = [
                    NSStrokeColorAttributeName : UIColor.blackColor(),
                    NSForegroundColorAttributeName : UIColor.whiteColor(),
                    NSFontAttributeName : UIFont(name: "Impact", size: 38)!,
                    NSStrokeWidthAttributeName : -2 ]
            input.textAlignment  = .Center
            input.delegate = self
            input.placeholder = nil
        }
        
        setTextAttibutes(topText)
        setTextAttibutes(bottomText)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        //self.navigationController?.navigationBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        //self.navigationController?.navigationBarHidden = false
    }
    
    func showCameraPicker(){
        self.presentCamera()
    }
    
    //MARK: - Image Saving
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]){
        
        var image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        self.imageView.image = image
        
        
        println(saveImageToUserFolder(image))
        
        imagePickerControllerDidCancel(self.cameraUI)
    }
    //MARK: - Sharing Feature
    
    func shareImage(image:UIImage){
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        
        self.presentViewController(activityVC, animated: true, completion: nil)
        
    }
    
    //MARK: - Camera
    
    func presentCamera(){
        cameraUI.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            cameraUI.sourceType = UIImagePickerControllerSourceType.Camera
        } else {
            cameraUI.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        cameraUI.mediaTypes = [kUTTypeImage] // This is the default
        cameraUI.allowsEditing = true
        
        self.presentViewController(cameraUI, animated: true, completion: nil)
    }
    
    //MARK: - Cancel
    
    func imagePickerControllerDidCancel(picker:UIImagePickerController){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "imageToTable" {
            if let image = self.imageView.image {
                let newMeme = MemePicText(topLabel: topText.text, bottomLabel: bottomText.text, image: image, editedImage: viewComposite.jj_takeSnapshotOfCurrentFrame())

                
                (segue.destinationViewController as! MasterViewController).insertNewObject(newMeme)
            }
        }
    }
    
    //MARK: - Keyboard Text Field Related
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""

    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    
    
    
}
