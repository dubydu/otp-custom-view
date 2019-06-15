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

## Screen Shot
<br>
<img height="700" src="https://github.com/SI-Du/SI1-OTPCustomView/blob/master/Simulator%20Screen%20Shot.png" />
<br>

## Custom OTP view

- otpFieldType  // Defines the otp type, defaults is circular

- otpFieldsCount  // Defines the otp count, defaults is 5

- otpFieldInputType  // Defines the otp keyboard type, defaults is numberPad

- otpFieldFont  // Defines the otp font type, defaults is system font - size 20

- otpFieldEntrySecureType  // If set “true”, the * symbol will be show, defaults is false

- otpFilledEntryDisplay  // If set “true” the content of textField will be not visible. Instead, show the • symbol, it’s look like Apple pass lock, defaults is false

- cursorColor  // Defines the blinking cursor color, defaults is Black color

- otpFieldSize  // Defines the otp size, defaults is 40 (CGFloat)

- otpFieldSeparatorSpace  // Defines the separator spacing between otp fields, defaults is 10

- otpFieldBorderWidth  // Defines width for border otp fields, defaults is 1

- otpFieldDefaultBackgroundColor  // Defines the otp background color, defaults is clear

- otpFieldEnteredBackgroundColor  // Defines the current otp background color, that’s visible, defaults is clear

- otpFieldNextFieldBackgroundColor  // Defines the next otp background color, defaults is light gray (It’s just available on square and corner otp type)

- otpFieldDefaultBorderColor  // Defines the defaults otp border color, defaults is gray

- otpFieldEnteredBorderColor  // Defines the otp border color, it was entered, defaults is gray

- otpFieldErrorBorderColor  // Defines the error otp border color, defaults is red

- otpFieldCornerRadius  // Defines radius of otp, (available on corner type) defaults is 4

- shouldAllowIntermediateEditing  // If set “false”, editing will take place from last filled text field, defaults is true

- shouldRequireCursor  // If set “false”, the blinking cursor for otp will not be visible , defaults is true

## Author

SI1, du.bv@neo-lab.vn

## License

SI1-OTPCustomView is available under the MIT license. See the LICENSE file for more info.
