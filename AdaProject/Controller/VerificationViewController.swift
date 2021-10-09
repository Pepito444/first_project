//
//  VerificationViewController.swift
//  AdaProject
//
//  Created by user198010 on 7/24/21.
//

import UIKit

class VerificationViewController: UIViewController {
    
    @IBOutlet weak var verificationCode: UITextField!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var sendAgainButton: UIButton!
    
    var requests = ApiRequest()
    var profile = Response()
    var response = Response()
    
    var countdownTimer: Timer!
    var totalTime: Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
        verificationCode.layer.borderColor = UIColor.lightGray.cgColor
        
        verificationCode.setLeftPaddingPoints(10)
    }
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
        timerLabel.text = "\(timeFormatted(totalTime))"
        sendAgainButton.isEnabled = false
        if totalTime != 0 {
            totalTime -= 1
        } else {
            countdownTimer.invalidate()
            sendAgainButton.isEnabled = true
            totalTime = 10
        }
    }
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
    @IBAction func sendAgainPressed(_ sender: UIButton) {
        startTimer()
    }
    
    @IBAction func validationButtonPressed(_ sender: UIButton) {
        
        let validationCode = verificationCode.text!
        requests.requestWithValidationCode(inputParameter: validationCode) { data in
            self.response = data
            DispatchQueue.main.async {[self] in
                if response.validated != nil{
                    requests.userCheck(){ (data) in
                        DispatchQueue.main.async { profile = data
                            if profile.profileCompleted == true {
                                performSegue(withIdentifier: "videoListVC", sender: self)
                            } else {
                                performSegue(withIdentifier: "registrationVC", sender: self)
                            }
                        }
                    }
                }
            }
        }
    }
}
