//
//  RegistrationViewController.swift
//  AdaProject
//
//  Created by user198010 on 7/28/21.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var estimatedBirthDate: UITextField!
    @IBOutlet weak var realBirthDate: UITextField!
    @IBOutlet weak var grams: UITextField!
    @IBOutlet weak var femaleBtn: UIButton!
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var doctorName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var privacyChckbox: UIButton!
    @IBOutlet weak var reportChckbox: UIButton!
    @IBOutlet weak var privacyLink: UITextView!
    @IBOutlet weak var continueBtn: UIButton!
    
    var requests = ApiRequest()
    var response = Response()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameField.delegate = self
        estimatedBirthDate.delegate = self
        realBirthDate.delegate = self
        grams.delegate = self
        doctorName.delegate = self
        email.delegate = self
       
        nameField.layer.borderColor = UIColor.lightGray.cgColor
        estimatedBirthDate.layer.borderColor = UIColor.lightGray.cgColor
        realBirthDate.layer.borderColor = UIColor.lightGray.cgColor
        grams.layer.borderColor = UIColor.lightGray.cgColor
        doctorName.layer.borderColor = UIColor.lightGray.cgColor
        email.layer.borderColor = UIColor.lightGray.cgColor
        
        updateLabel()
        
        continueBtn.isEnabled = false
        
        
        
    }
    
   
    
    
    func updateLabel() {
        let path = "https://www.google.com/"
        let text = privacyLink.text ?? ""
        let attributedString = NSAttributedString.makeHyperlink(for: path, in: text, as: "Gizlilik Politikasını ve Kullanım Koşularını")
        privacyLink.attributedText = attributedString
        
    }
    

    @IBAction func femaleBtnAction(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            maleBtn.isSelected = false
        } else {
            sender.isSelected = true
            maleBtn.isSelected = false
        }
       
    }
    @IBAction func maleBtnAction(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            femaleBtn.isSelected = false
        } else {
            sender.isSelected = true
            femaleBtn.isSelected = false
        }
      
    }
    
    func genderValue() -> String {
        if femaleBtn.isSelected == true {
            return "FEMALE"
        } else {
            return "MALE"
        }
    }
    
    @IBAction func privacyBtn(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            continueBtn.isEnabled = false
        } else {
            sender.isSelected = true
            
        }
        
    }
    @IBAction func reportBtn(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            privacyChckbox.isSelected = false
            continueBtn.isEnabled = false
        } else {
            sender.isSelected = true
            privacyChckbox.isSelected = true
            continueBtn.isEnabled = true
        }
        
    }
    
    @IBAction func continueBtnPressed(_ sender: UIButton) {
        if let nameLabel = nameField.text, nameField.text!.count == 0 {
            print("Please enter name")
        }
        if let estimatedDate = estimatedBirthDate.text, estimatedBirthDate.text!.count == 0 {
            print("Please enter estimated birth date")
        }
        if let realDate = realBirthDate.text, realBirthDate.text!.count == 0 {
            print("Please enter real birth date")
        }
        if let weight = grams.text, grams.text!.count == 0 {
            print("Please enter the weight")
        }
        if isValidEmail(emailID: email.text!) == false {
            print("Enter valid email")
        }
        performSegue(withIdentifier: "popUpVC", sender: self)
        requests.registrationData(privacyContract: true, reportContract: true, name: nameField.text!, estimatedBirthDate: estimatedBirthDate.text!, realBirthdate: realBirthDate.text!, grams: grams.text!, sexuality: genderValue(), doctorName: doctorName.text!, email: email.text!)
        print(genderValue())
        
    }


    
    func isValidEmail(emailID: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
}



extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.openDatePicker()
    }
}

extension RegistrationViewController {

    func openDatePicker() {
       
        let datePicker = UIDatePicker()
        let loc = Locale(identifier: "tr")
        datePicker.locale = loc
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(self.datePickerHandler(datePicker:)), for: .valueChanged)
        estimatedBirthDate.inputView = datePicker // keyboard
        realBirthDate.inputView = datePicker
        datePicker.preferredDatePickerStyle = .wheels
        
        
        let toolbarForExpectedBirth = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelBtnClick))
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneBtnClick))
        let flexibleBtn = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbarForExpectedBirth.setItems([cancelBtn, flexibleBtn, doneBtn], animated: false)
        estimatedBirthDate.inputAccessoryView = toolbarForExpectedBirth // toolbar
        
        let toolbarForBornDate = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        let doneBtnBornDate = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneBtnClickBornDate))
        toolbarForBornDate.setItems([cancelBtn, flexibleBtn, doneBtnBornDate], animated: false)
        realBirthDate.inputAccessoryView = toolbarForBornDate
        
    }
    
    @objc
    func cancelBtnClick() {
        estimatedBirthDate.resignFirstResponder()
        realBirthDate.resignFirstResponder()
        
    }
    
    @objc
    func doneBtnClick() {
        if let datePicker = estimatedBirthDate.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.dateFormat = "yyyy-MM-dd"
            estimatedBirthDate.text = dateFormatter.string(from: datePicker.date)
            print(datePicker.date)
        }
        estimatedBirthDate.resignFirstResponder()
    }
    
    @objc
    func doneBtnClickBornDate() {
        if let datePicker = realBirthDate.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.dateFormat = "yyyy-MM-dd"
            realBirthDate.text = dateFormatter.string(from: datePicker.date)
            print(datePicker.date)
        }
        realBirthDate.resignFirstResponder()
        
    }
    
    @objc func datePickerHandler(datePicker: UIDatePicker) {
        print(datePicker.date)
    }
}

extension NSAttributedString {
    static func makeHyperlink(for path: String, in string: String, as substring: String) -> NSAttributedString {
        let nsString = NSString(string: string)
        let font = UIFont.systemFont(ofSize: 15)
        let attributes = [NSAttributedString.Key.font: font]
        let substringRange = nsString.range(of: substring)
        let attributedString = NSMutableAttributedString(string: string, attributes: attributes)
        attributedString.addAttribute(.link, value: path, range: substringRange)
        return attributedString
        
    }
    
}



