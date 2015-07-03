//
//  SecondViewController.swift
//  Delegation
//
//  Created by CT MacBook Pro on 7/2/15.
//  Copyright © 2015 CT MacBook Pro. All rights reserved.
//

import UIKit

protocol DataEnteredDelegate: class{
    func userDidEnterInformation(info: String)
}

class SecondViewController: UIViewController {

    
    var delegate: DataEnteredDelegate? = nil
    
    
    @IBOutlet weak var dataTextField: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendData(sender: AnyObject) {
        if delegate != nil {
            let information: String = dataTextField.text
            delegate!.userDidEnterInformation(information)
            self.navigationController?.popViewControllerAnimated(true)
        }
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
