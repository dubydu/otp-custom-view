//
//  OTPView.swift
//  OTPCodeUniversal
//
//  Created by DU on 6/13/19.
//  Copyright © 2019 dubydu. All rights reserved.
//

import UIKit

protocol OTPViewDelegate: NSObjectProtocol {
    func shouldBecomeFirstResponder(fieldIndex index: Int) -> Bool
    func enteredOTP(otpString: String)
    func hasEnteredAllOTP(hasEntered: Bool) -> Bool
}

class OTPView: UIView {
    
    // MARK: - Enums
    enum OTPType {
        case square
        case circular
        case firstBaseLine
        case corner
    }
    
    enum KeyboardType: Int {
        case numberPad
        case alphabet
        case namePhonePad
    }
    
    // MARK: - Properties
    var otpFieldType: OTPType = .circular
    var otpFieldsCount: Int = 5
    var otpFieldInputType: KeyboardType = .numberPad
    var otpFieldColor: UIColor = .black
    var otpFieldFont: UIFont = UIFont.systemFont(ofSize: 20)
    var otpFieldEntrySecureType: Bool = false
    var otpFilledEntryDisplay: Bool = false
    var cursorColor: UIColor = UIColor.black
    var otpFieldSize: CGFloat = 40
    var otpFieldSeparatorSpace: CGFloat = 16
    var otpFieldBorderWidth: CGFloat = 1
    var otpFieldDefaultBackgroundColor: UIColor = UIColor.clear
    var otpFieldEnteredBackgroundColor: UIColor = UIColor.clear
    var otpFieldNextFieldBackgroundColor: UIColor = UIColor.lightGray
    var otpFieldDefaultBorderColor: UIColor = UIColor.gray
    var otpFieldEnteredBorderColor: UIColor = UIColor.gray
    var otpFieldErrorBorderColor: UIColor?
    var otpFieldCornerRadius: CGFloat = 4
    
    var shouldAllowIntermediateEditing: Bool = true
    var shouldRequireCursor: Bool = true
    
    weak var delegate: OTPViewDelegate?
    private var secureEntryData = [String]()
    
    // MARK: - Initialization Method
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initView() {
        layer.masksToBounds = true
        layoutIfNeeded()
        initOTPFields()
        (viewWithTag(1) as? OTPTextField)?.becomeFirstResponder()
        autoResizeTextFields()
    }
    
    private func autoResizeTextFields() {
        otpFieldSize = self.frame.height - otpFieldSeparatorSpace
    }
    
    private func initOTPFields() {
        secureEntryData.removeAll()
        for index in stride(from: 0, to: otpFieldsCount, by: 1) {
            let oldOtpField = viewWithTag(index + 1) as? OTPTextField
            oldOtpField?.removeFromSuperview()
            let otpField = getOTPField(forIndex: index)
            addSubview(otpField)
            secureEntryData.append("")
        }
    }
    
    // MARK: - Private Method
    private func getOTPField(forIndex index: Int) -> OTPTextField {
        let hasOddNumberOfFields = (otpFieldsCount % 2 == 1)
        var fieldFrame = CGRect(x: 0, y: 0, width: otpFieldSize, height: otpFieldSize)
        
        // If odd, then center of self will be center of middle field. If false, then center of self will be center of space between 2 middle fields.
        if hasOddNumberOfFields {
            // Calculate from middle each fields x and y values so as to align the entire view in center
            fieldFrame.origin.x = bounds.size.width / 2 - (CGFloat(otpFieldsCount / 2 - index) * (otpFieldSize + otpFieldSeparatorSpace) + otpFieldSize / 2)
        }
        else {
            // Calculate from middle each fields x and y values so as to align the entire view in center
            fieldFrame.origin.x = bounds.size.width / 2 - (CGFloat(otpFieldsCount / 2 - index) * otpFieldSize + CGFloat(otpFieldsCount / 2 - index - 1) * otpFieldSeparatorSpace + otpFieldSeparatorSpace / 2)
        }
        
        fieldFrame.origin.y = (bounds.size.height - otpFieldSize) / 2
        
        let otpField = OTPTextField(frame: fieldFrame)
        otpField.delegate = self
        otpField.tag = index + 1
        otpField.font = otpFieldFont
        
        switch otpFieldInputType {
        case .numberPad:
            otpField.keyboardType = .numberPad
        case .alphabet:
            otpField.keyboardType = .alphabet
        case .namePhonePad:
            otpField.keyboardType = .namePhonePad
        }
        
        otpField.borderColor = otpFieldDefaultBorderColor
        otpField.borderWidth = otpFieldBorderWidth
        
        if shouldRequireCursor {
            otpField.textColor = cursorColor
            otpField.tintColor = cursorColor
        }
        else {
            otpField.tintColor = UIColor.clear
        }
        
        if otpFieldType == .corner {
            otpField.cornerRadius = otpFieldCornerRadius
        }
        
        otpField.backgroundColor = otpFieldDefaultBackgroundColor
        otpField.initalizeUI(forFieldType: otpFieldType)
        return otpField
    }
    
    private func calculateEnteredOTPSTring(isDeleted: Bool) {
        if isDeleted {
            _ = delegate?.hasEnteredAllOTP(hasEntered: false)
            
            // Set the default enteres state for otp entry
            for index in stride(from: 0, to: otpFieldsCount, by: 1) {
                var otpField = viewWithTag(index + 1) as? OTPTextField
                
                if otpField == nil {
                    otpField = getOTPField(forIndex: index)
                }
                
                let fieldBackgroundColor = (otpField?.text ?? "").isEmpty ? otpFieldDefaultBackgroundColor : otpFieldEnteredBackgroundColor
                
                let fieldBorderColor = (otpField?.text ?? "").isEmpty ? otpFieldDefaultBorderColor : otpFieldEnteredBorderColor
                
                if otpFieldType == .firstBaseLine {
                    otpField?.shapeLayer.fillColor = fieldBackgroundColor.cgColor
                    otpField?.shapeLayer.strokeColor = fieldBorderColor.cgColor
                } else {
                    otpField?.backgroundColor = fieldBackgroundColor
                    otpField?.layer.borderColor = fieldBorderColor.cgColor
                }
            }
        } else {
            var enteredOTPString = ""
            
            for index in stride(from: 0, to: secureEntryData.count, by: 1) {
                if !secureEntryData[index].isEmpty {
                    enteredOTPString.append(secureEntryData[index])
                }
            }
            
            if enteredOTPString.count == otpFieldsCount {
                delegate?.enteredOTP(otpString: enteredOTPString)
                
                // Check if all OTP fields have been filled or not. Based on that call the 2 delegate methods.
                let isValid = delegate?.hasEnteredAllOTP(hasEntered: (enteredOTPString.count == otpFieldsCount)) ?? false
                
                // Set the error state for invalid otp entry
                for index in stride(from: 0, to: otpFieldsCount, by: 1) {
                    var otpField = viewWithTag(index + 1) as? OTPTextField
                    
                    if otpField == nil {
                        otpField = getOTPField(forIndex: index)
                    }
                    
                    if !isValid {
                        // Set error border color if set, if not, set default border color
                        otpField?.layer.borderColor = (otpFieldErrorBorderColor ?? otpFieldEnteredBorderColor).cgColor
                    }
                    else {
                        otpField?.layer.borderColor = otpFieldEnteredBorderColor.cgColor
                    }
                }
            }
        }
    }
    
    private func highLightTextField(textField: UITextField) {
        if otpFieldType == .square || otpFieldType == .corner {
            UIView.animate(withDuration: 0.4) {
                textField.backgroundColor = self.otpFieldNextFieldBackgroundColor
            }
        }
    }
    
    private func isPreviousFieldsEntered(forTextField textField: UITextField) -> Bool {
        var isTextFilled = true
        var nextOTPField: UITextField?
        
        // If intermediate editing is not allowed, then check for last filled field in forward direction.
        
        if !shouldAllowIntermediateEditing {
            for index in stride(from: 1, to: otpFieldsCount + 1, by: 1) {
                let tempNextOTPField = viewWithTag(index) as? UITextField
                
                if let tempNextOTPFieldText = tempNextOTPField?.text, tempNextOTPFieldText.isEmpty {
                    nextOTPField = tempNextOTPField
                    break
                }
            }
            
            if let nextOTPField = nextOTPField {
                isTextFilled = (nextOTPField == textField || (textField.tag) == (nextOTPField.tag - 1))
            }
        }
        
        return isTextFilled
    }
}
// MARK: UITextFieldDelegate
extension OTPView: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let shouldBeginEditing = delegate?.shouldBecomeFirstResponder(fieldIndex: (textField.tag - 1)) ?? true
        if shouldBeginEditing {
            return isPreviousFieldsEntered(forTextField: textField)
        }
        return shouldBeginEditing
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let replacedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        
        // Check since only alphabet keyboard is not available in iOS
        if !replacedText.isEmpty && otpFieldInputType == .alphabet && replacedText.rangeOfCharacter(from: .letters) == nil {
            return false
        }
        
        if replacedText.count >= 1 {
            secureEntryData[textField.tag - 1] = string
            
            if otpFilledEntryDisplay {
                textField.text = " "
            } else {
                if otpFieldEntrySecureType {
                    textField.text = "*"
                } else {
                    textField.text = string
                }
            }
            
            if otpFieldType == .firstBaseLine {
                (textField as! OTPTextField).shapeLayer.fillColor = otpFieldEnteredBackgroundColor.cgColor
                (textField as! OTPTextField).shapeLayer.strokeColor = otpFieldEnteredBorderColor.cgColor
            } else {
                textField.backgroundColor = otpFieldEnteredBackgroundColor
                textField.layer.borderColor = otpFieldEnteredBorderColor.cgColor
            }
            
            if let nextOTPField = viewWithTag(textField.tag + 1) as? UITextField {
                highLightTextField(textField: nextOTPField)
                nextOTPField.becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
            
            // Get the entered string
            calculateEnteredOTPSTring(isDeleted: false)
        } else {
            let currentText = textField.text ?? ""
            
            if textField.tag > 1 && currentText.isEmpty {
                if let prevOTPField = viewWithTag(textField.tag - 1) as? UITextField {
                    deleteText(in: prevOTPField)
                    highLightTextField(textField: prevOTPField)
                }
            } else {
                deleteText(in: textField)
                if textField.tag > 1 {
                    if let prevOTPField = viewWithTag(textField.tag - 1) as? UITextField {
                        highLightTextField(textField: prevOTPField)
                        prevOTPField.becomeFirstResponder()
                    }
                }
            }
        }
        return false
    }
    
    private func deleteText(in textField: UITextField) {
        // If deleting the text, then move to previous text field if present
        secureEntryData[textField.tag - 1] = ""
        textField.text = ""
        
        if otpFieldType == .firstBaseLine {
            (textField as! OTPTextField).shapeLayer.fillColor = otpFieldDefaultBackgroundColor.cgColor
            (textField as! OTPTextField).shapeLayer.strokeColor = otpFieldDefaultBorderColor.cgColor
        } else {
            textField.backgroundColor = otpFieldDefaultBackgroundColor
            textField.layer.borderColor = otpFieldDefaultBorderColor.cgColor
        }
        textField.becomeFirstResponder()
        calculateEnteredOTPSTring(isDeleted: true)
    }
}

