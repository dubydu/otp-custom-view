//
//  ViewController.swift
//  SI1-OTPCustomView
//
//  Created by SI-Du on 06/14/2019.
//  Copyright (c) 2019 SI-Du. All rights reserved.
//

import UIKit
import SI1_OTPCustomView

class ViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var otpView: OTPView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        configurationOTPView()
    }

    func configurationOTPView() {
        otpView.delegate = self
        otpView.otpFieldsCount = 6
        otpView.otpFieldType = .corner
        otpView.otpFieldCornerRadius = 4
        otpView.otpFieldSize = 30
        otpView.otpFieldSeparatorSpace = 5
        otpView.otpFieldDefaultBorderColor = UIColor.gray
        otpView.initView()
    }
}
// MARK: - OTPViewDelegate
extension ViewController: OTPViewDelegate {
    func shouldBecomeFirstResponder(fieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otpString: String) {
        print("Your otp's \(otpString)")
    }
    
    func hasEnteredAllOTP(hasEntered: Bool) -> Bool {
        print(hasEntered)
        return hasEntered
    }
}
