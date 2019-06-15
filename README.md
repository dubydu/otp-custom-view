# SI1-OTPCustomView

[![CI Status](https://img.shields.io/travis/SI-Du/SI1-OTPCustomView.svg?style=flat)](https://travis-ci.org/SI-Du/SI1-OTPCustomView)
[![Version](https://img.shields.io/cocoapods/v/SI1-OTPCustomView.svg?style=flat)](https://cocoapods.org/pods/SI1-OTPCustomView)
[![License](https://img.shields.io/cocoapods/l/SI1-OTPCustomView.svg?style=flat)](https://cocoapods.org/pods/SI1-OTPCustomView)
[![Platform](https://img.shields.io/cocoapods/p/SI1-OTPCustomView.svg?style=flat)](https://cocoapods.org/pods/SI1-OTPCustomView)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

SI1-OTPCustomView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SI1-OTPCustomView'
```

## Custom OTP view

// Defines the otp type, defaults is circular
- otpFieldType
// Defines the otp count, defaults is 5
- otpFieldsCount
// Defines the otp keyboard type, defaults is numberPad
- otpFieldInputType
// Defines the otp font type, defaults is system font - size 20
- otpFieldFont
// If set “true”, the “***” symbol will be show, defaults is false
otpFieldEntrySecureType
// If set “true” the content of textField will be not visible. Instead, show the • symbol, it’s look like Apple pass lock, defaults is false
- otpFilledEntryDisplay
// Defines the blinking cursor color, defaults is Black color
- cursorColor
// Defines the otp size, defaults is 40 (CGFloat)
- otpFieldSize
// Defines the separator spacing between otp fields, defaults is 10
- otpFieldSeparatorSpace
// Defines width for border otp fields, defaults is 1
- otpFieldBorderWidth
// Defines the otp background color, defaults is clear
- otpFieldDefaultBackgroundColor
// Defines the current otp background color, that’s visible, defaults is clear
- otpFieldEnteredBackgroundColor
// Defines the next otp background color, defaults is light gray (It’s just available on square and corner otp type)
- otpFieldNextFieldBackgroundColor
// Defines the defaults otp border color, defaults is gray
- otpFieldDefaultBorderColor
// Defines the otp border color, it was entered, defaults is gray
- otpFieldEnteredBorderColor
// Defines the error otp border color, defaults is red
- otpFieldErrorBorderColor
// Defines radius of otp, (available on corner type) defaults is 4
- otpFieldCornerRadius
// If set “false”, editing will take place from last filled text field, defaults is true
- shouldAllowIntermediateEditing
// If set “false”, the blinking cursor for otp will not be visible , defaults is true
- shouldRequireCursor

## Author

SI-Du, du.bv@neo-lab.vn

## License

SI1-OTPCustomView is available under the MIT license. See the LICENSE file for more info.
