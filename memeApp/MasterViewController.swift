//
//  MasterViewController.swift
//  memeApp
//
//  Created by masters3d on 5/12/15.
//  Copyright (c) 2015 masters3d. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
    var myDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
//    var objects = Array(Repeat(count: 6, repeatedValue: MemePicText(topLabel: "TOP1", bottomLabel: "Bottom2", image: UIImage(named: "masters3dLogo")!, editedImage: nil)))
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "presentCameraFromFirstViewController:")
        
        self.navigationItem.rightBarButtonItem = addButton
        
        self.navigationItem.leftItemsSupplementBackButton = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func presentCameraFromFirstViewController(sender: AnyObject){
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard?.instantiateViewControllerWithIdentifier("MasterNavigation") as! UINavigationController
        
        self.presentViewController(vc, animated: true, completion: nil)
        
    }

//    func insertNewObject(sender: AnyObject) {
    func insertNewObject(meme: MemePicText) {
        
        (UIApplication.sharedApplication().delegate as! AppDelegate).memes.insert(meme, atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        println((UIApplication.sharedApplication().delegate as! AppDelegate).memes)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let object = (UIApplication.sharedApplication().delegate as! AppDelegate).memes[indexPath.row]
            (segue.destinationViewController as! DetailViewController).detailItem = object
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes.count
    }

//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
//
//        let object = objects[indexPath.row] as! NSDate
//        cell.textLabel!.text = object.description
//        return cell
//    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellCustom = tableView.dequeueReusableCellWithIdentifier("CellCustom", forIndexPath: indexPath) as! UITableViewCell
        
        let object = (UIApplication.sharedApplication().delegate as! AppDelegate).memes[indexPath.row]
        
        let labelTop = cellCustom.viewWithTag(1) as! UILabel
        let labelBottom = cellCustom.viewWithTag(2) as! UILabel

        
        labelTop.text = object.topLabel
        labelBottom.text = object.bottomLabel
        cellCustom.imageView?.image = object.editedImage ?? object.image
        
        return cellCustom
    }
    

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            (UIApplication.sharedApplication().delegate as! AppDelegate).memes.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

