//
//  ViewController.swift
//  Delegation
//
//  Created by CT MacBook Pro on 7/2/15.
//  Copyright © 2015 CT MacBook Pro. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DataEnteredDelegate {
    
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var extraInfo: UILabel!
    
    func userDidEnterInformation(info: String) {
        dataLabel.text = info
    }gC.delegate = self //because we have adapted to its protocl. we call it self
            
        }
    }
}
