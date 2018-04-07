//
//  TextFiled.swift
//  Steam Ios Authenticator
//
//  Created by Ислам Киясов on 21.03.2018.
//  Copyright © 2018 Ислам Киясов. All rights reserved.
//

import UIKit

@IBDesignable
class TextFiled: UITextField {

    @IBInspectable var paddingWidth : Int = 4 {
        didSet {
            updateView()
        }
    }
    
    override class var layerClass: AnyClass {
        get{
            return CAGradientLayer.self
        }
    }
    
    func updateView(){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: self.paddingWidth, height: Int(self.frame.size.height)))
        self.leftView = paddingView
        self.leftViewMode = UITextFieldViewMode.always
    }
}
