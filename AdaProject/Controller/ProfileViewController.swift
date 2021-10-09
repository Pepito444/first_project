//
//  ProfileViewController.swift
//  AdaProject
//
//  Created by user198010 on 8/6/21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profile: UITabBarItem!
    @IBOutlet weak var isReportableLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var estimatedBirthDateLabel: UILabel!
    @IBOutlet weak var realBirthDateLabel: UILabel!
    @IBOutlet weak var gramsLabel: UILabel!
    @IBOutlet weak var sexualityLabel: UILabel!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var contactWithUsButton: UIButton!
    
    var requests = ApiRequest()
    var childInfo = Child()
    var response = Response()
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requests.getProfilData(){ data in
            DispatchQueue.main.async { [self] in
                response = data
                
                if response.isReportable?.status == true {
                    isReportableLabel.text = response.isReportable?.description
                }
                
                isReportableLabel.text = response.isReportable?.description
                nameLabel.text = response.child?.name
                estimatedBirthDateLabel.text = response.child?.estimatedBirthDate
                realBirthDateLabel.text = response.child?.realBirthDate
                var optionalNumber = response.child?.grams
                if let number = optionalNumber {
                    gramsLabel.text = "\(number)"
                } else {
                    
                }
                sexualityLabel.text = response.child?.sexuality
                doctorNameLabel.text = response.child?.doctorName
                emailLabel.text = response.email
            }
        }
        
        profile.title = "Profil"
        profile.selectedImage = #imageLiteral(resourceName: "ProfileSelected")
        contactWithUsButton.layer.borderWidth = 1
        contactWithUsButton.layer.cornerRadius = 25
        contactWithUsButton.layer.borderColor = UIColor.red.cgColor
    }
}
