//
//  UIViewController.swift
//  HW2.6
//
//  Created by Алексей Маслобоев on 31.01.2020.
//  Copyright © 2020 Алексей Маслобоев. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
