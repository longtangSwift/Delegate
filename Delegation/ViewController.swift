//
//  ViewController.swift
//  Delegation
//
//  Created by CT MacBook Pro on 7/2/15.
//  Copyright © 2015 CT MacBook Pro. All rights reserved.
//

import UIKit

protocol GetStuffFromFirstViewDelegate {
    func getInfoFromFirstView (String?)
}

class ViewController: UIViewController, DataEnteredDelegate {
    
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var extraInfo: UILabel!
    @IBOutlet weak var passedByMethodDataLabel: UILabel!
    var delegateActingOnBehalfOfViewTwoToGetThingsFromViewOne: GetStuffFromFirstViewDelegate? = nil
    var holdString = String() //use a holding string to get the info and hold it; because I think we are getting that info before the viewDidLoad.  Once ViewDidLoad, then we can set the dataLabel.text; has to be a public var
    var holdStringExtraInfo = String() //use this holding string to get extra bonus info
    override func viewDidLoad() {
        dataLabel.text = holdString
        extraInfo.text = holdStringExtraInfo
    }
    
    
    //these first two methods won't hold because they happen before viewDidLoad because we are segueing to it.

    func userDidEnterInformation(info: String) {
        dataLabel.text = info
        holdString = info
        print("we are in userDidEI and holdString is \(holdString)")
    }
    func getSomeXtraInf(randNumStr: String) {
        extraInfo.text = "bonus " + randNumStr
        print("we are in getSomeXtraInf and randNumStr is \(randNumStr)")
    }
    
    //this next method will hold because we are not using segue, so now the view is preserved rather than wiped out in the heap.
    func pasByaMethod(str: String){
        passedByMethodDataLabel.text = str
        print("by not using segue, view is preserved. str= \(str)")
    }


//    func getExtraInfo(inf: String){
//        extraInfo.text = inf  //make some extra info to delegate
//    }
    //we make a var called SecondVC. It is made before we press on the Bar Item "+" sign.  It is of the class SecondViewControler.  Anything in the SecondViewControlelr class has a .var of delegate. (delegate is a var written in the SecondViewController class.  We set that delegate to equal self. This is all done right before we segue to SecondVC.  The trigger call the userDidEnterInformation method and the getSomeXtraInf method was in the @action in the SecondViewController method named sendData.  I think the line self.navigationController?.popViewControllerAnimated(true) sends the SecondVC back to FirseVC.  I am going to test it.
    //before it segues over to the next page, it sets a delegate
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showSecondVC"{
            let secondVC: SecondViewController = segue.destinationViewController as! SecondViewController
            secondVC.delegate = self //because we have adapted to its protocl. we call it self
            delegateActingOnBehalfOfViewTwoToGetThingsFromViewOne?.getInfoFromFirstView(dataLabel.text! + "haha")
            secondVC.holdingStringOfSecView = "now we have it" + dataLabel.text!
            
        }
    }
}