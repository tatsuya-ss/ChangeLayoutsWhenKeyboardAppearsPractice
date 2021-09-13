//
//  ChangeViewFrameProtocol.swift
//  ChangeLayoutsWhenKeyboardAppearsPractice
//
//  Created by 坂本龍哉 on 2021/09/13.
//

import UIKit

protocol ChangeViewFrame: AnyObject {
    func changeFrame(notification: Notification,
                     verificationPositionY: CGFloat,
                     withDuration: TimeInterval)
    func returnOriginFrame(notification: Notification,
                           withDuration: TimeInterval)
}

extension ChangeViewFrame where Self: UIViewController {
    
    func changeFrame(notification: Notification,
                     verificationPositionY: CGFloat,
                     withDuration: TimeInterval = 0.25) {
        guard let userInfo = notification.userInfo,
              let keyboardHeight =
                (userInfo[UIResponder.keyboardFrameEndUserInfoKey]
                    as? NSValue)?.cgRectValue.height else { return }
        let keyboardPositionY = view.frame.size.height - keyboardHeight
        let transformY = keyboardPositionY - verificationPositionY
        if keyboardPositionY < verificationPositionY {
            UIView.animate(withDuration: withDuration) {
                self.view.frame = CGRect(x: 0,
                                         y: self.view.frame.origin.y + transformY,
                                         width: self.view.bounds.width,
                                         height: self.view.bounds.height)
            }
        } else {
            self.returnOriginFrame(notification: notification)
        }
        
    }
    
    func returnOriginFrame(notification: Notification,
                           withDuration: TimeInterval = 0.25) {
        UIView.animate(withDuration: withDuration) {
            self.view.frame = CGRect(x: 0,
                                     y: 0,
                                     width: self.view.bounds.width,
                                     height: self.view.bounds.height)
        }
    }
    
}
