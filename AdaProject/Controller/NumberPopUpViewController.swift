//
//  numberPopUpViewController.swift
//  AdaProject
//
//  Created by user191120 on 8/31/21.
//

import UIKit

class NumberPopUpViewController: UIViewController {
    
    @IBOutlet weak var numberPopUpView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberPopUpView.layer.cornerRadius = 20
    }
    
    @IBAction func quickPopUp(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
