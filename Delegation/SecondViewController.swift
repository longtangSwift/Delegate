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
    //anytihng that conforms to this will have a func that receives a string.  Within the func, the func will set the text, so it doesn't need to return anything.  The method will do the work of setting the text of the label.
    func getSomeXtraInf(randNum: String)
}

class SecondViewController: UIViewController {

    
    var delegate: DataEnteredDelegate? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //--The model of our MVC live below:  we get info from the dataTextField and also from the extraInf string.
    
    @IBOutlet weak var dataTextField: UITextView!

    
    @IBAction func sendData(sender: AnyObject) {
        if delegate != nil {
            let information: String = dataTextField.text
            delegate!.userDidEnterInformation(information)
            self.navigationController?.popViewControllerAnimated(true)
            delegate!.getSomeXtraInf(extraInf)
        }
    }

    //-- the 2nd model of our MVC lives below:  The bit of extra is a random # that is generated.
    var extraInf: String {
        get{
            let randX: RandomNumberGenerator = LinearCongruentialGenerator()
            return "\(randX.random())"
        }
    }

}
