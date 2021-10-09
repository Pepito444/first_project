//
//  NumberPopUpViewController.swift
//  AdaProject
//
//  Created by user191120 on 8/19/21.
//

import UIKit

class PopUpViewController: UIViewController {
    @IBOutlet weak var exclamationİmage: UIImageView!
    @IBOutlet weak var popUpView: UIView!
    
    var requests = ApiRequest()
    var response = Response()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        popUpView.layer.cornerRadius = 20
        
    }
    
    @IBAction func informationIsCorrect(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func quitPopUp(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
