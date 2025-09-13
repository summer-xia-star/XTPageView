//
//  UIColor.swift
//  HYVideoApp
//
//  Created by tian xia on 2025/9/7.
//

import UIKit

extension UIColor {
    class func randomColor() -> UIColor {
        let randomRed = Float.random(in: 0..<256) / 255
        let randomGreen = Float.random(in: 0..<256) / 255
        let randomBlue = Float.random(in: 0..<256) / 255
        return UIColor(red: CGFloat(randomRed), green: CGFloat(randomGreen), blue: CGFloat(randomBlue), alpha: 1)
    }
}
