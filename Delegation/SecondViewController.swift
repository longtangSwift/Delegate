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

class SecondViewController: UIViewController, GetStuffFromFirstViewDelegate {

    
    var delegate: DataEnteredDelegate? = nil
    var holdingStringOfSecView = String(){
        didSet{print("didSet of holdingStringOfSecView which now = \(holdingStringOfSecView)")}
    }
    
    func getInfoFromFirstView(infoStr: String?) {
        print("we are in ViewTwo and the stuff we got from ViewOne is infoStr: \(infoStr)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = holdingStringOfSecView
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    //--The model of our MVC live below:  we get info from the dataTextField and also from the extraInf string.
    
    @IBOutlet weak var dataTextField: UITextView!

    //this action will QuasiSegue back to firstVC.  So, this is kind of like our prepareforSegue. And it is: it takes the information from SecondVC back to FirstVC by sending strings to the two methods: userDidEnterINformation and getSomeXtraInf which are methods that conform to the DataEnteredDelegate protocol
    @IBAction func sendData(sender: AnyObject) {
        if delegate != nil {
            let information: String = dataTextField.text
            delegate!.userDidEnterInformation(information)
            //self.navigationController?.popViewControllerAnimated(true)
            delegate!.getSomeXtraInf(extraInf)
        }
    }
    @IBAction func goBackToFirstVC(sender: AnyObject) {
        //this command takes it from the navcontroller back to the rootView.
        //now x looks to be a delegate going into the first controller to get informed.
        let FirstVC = navigationController?.visibleViewController as? ViewController
        FirstVC?.delegateActingOnBehalfOfViewTwoToGetThingsFromViewOne = self //because we have conformed to the GetStuffFromFirstViewDelegate protocol we can send that delegate into viewone.
        
        //self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var destination: UIViewController?
        destination = segue.destinationViewController
            // the top layer will be used and things end here (ie it won't meet the next if then statement
        if let navController = destination as? UINavigationController{
                destination = navController.visibleViewController
            }
            //the original is if let firsVC = segue.destinationViewController as? ViewController       [which would not work if ViewControler were embedded in a NC]
        if let firsVC = destination as? ViewController{
                if let identifier = segue.identifier{
                    switch identifier{
                    case "GoFirstVC":
                        firsVC.delegateActingOnBehalfOfViewTwoToGetThingsFromViewOne = self
                    case "DismissAndGoFirstVC":
                        firsVC.delegateActingOnBehalfOfViewTwoToGetThingsFromViewOne = self
                        //also, we are going to send data TO ViewController
                        delegate!.getSomeXtraInf(extraInf)
                        let information = dataTextField.text
                        print("in case DismissAndGoFirVC and dataTexFild = \(information)")
                        delegate!.userDidEnterInformation(dataTextField.text)
                        firsVC.holdString = information
                        
                    default:
                        break
                    }
                }
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
