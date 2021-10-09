//
//  ViewController.swift
//  AdaProject
//
//  Created by user198010 on 7/21/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var codeField: UITextField!
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var directorİnformationLink: UITextView!
    
    
    var requests = ApiRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabel()
        numberField.layer.borderColor = UIColor.lightGray.cgColor
        codeField.layer.borderColor = UIColor.lightGray.cgColor
        numberField.setLeftPaddingPoints(10)
        
    }
    

    
    func updateLabel() {
        let path = "https://www.google.com/"
        let text = directorİnformationLink.text ?? ""
        let attributedString = NSAttributedString.makeHyperlinkForDirector(for: path, in: text, as: "Medikal Direktor Hakkında Bilgi")
        directorİnformationLink.attributedText = attributedString
    }



    @IBAction func continueButtonPressed(_ sender: UIButton) {
        if numberField.text!.count < 10 {
            performSegue(withIdentifier: "numberPopUp", sender: self)
        } else {
            let phoneNumber = codeField.text! + numberField.text!
            requests.requestWithPhoneNumber(inputParameter: phoneNumber){ data in UserDefaults.standard.set(data.location, forKey: "UserID")}
            performSegue(withIdentifier: "verificationVC", sender: self)
        }
    }
    
             
    @IBAction func privacyPolicyPressed(_ sender: UIButton) {
        if let url = NSURL(string: "http://www.google.com"){
            UIApplication.shared.open(url as URL)
           }
        }
    
    @IBAction func termsOfUsePressed(_ sender: UIButton) {
        if let url = NSURL(string: "http://www.google.com"){
            UIApplication.shared.open(url as URL)
           }
    }
}

extension NSAttributedString {
    static func makeHyperlinkForDirector(for path: String, in string: String, as substring: String) -> NSAttributedString {
        let nsString = NSString(string: string)
        let font = UIFont.systemFont(ofSize: 15)
        let attributes = [NSAttributedString.Key.font: font]
        let substringRange = nsString.range(of: substring)
        let attributedString = NSMutableAttributedString(string: string, attributes: attributes)
        attributedString.addAttribute(.link, value: path, range: substringRange)
        return attributedString
        
    }
    
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
