//
//  ViewController.swift
//  ChangeLayoutsWhenKeyboardAppearsPractice
//
//  Created by 坂本龍哉 on 2021/09/10.
//

import UIKit

extension ViewController: ChangeViewFrame { }

final class ViewController: UIViewController {
    
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!
    
    private var editingTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextField()
        setupNotificationCenter()
        
    }
    
    private func closeKeyboard() {
        [textField1, textField2, textField3, textField4]
            .forEach { $0?.resignFirstResponder() }
    }
    
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        editingTextField = textField
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        closeKeyboard()
        return true
    }
    
}

// MARK: - setup
extension ViewController {
    
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboradWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
    }
    
    private func setupTextField() {
        [textField1,
         textField2,
         textField3,
         textField4
        ].forEach { $0?.delegate = self }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        closeKeyboard()
    }

}

// MARK: - @objc
extension ViewController {
    
    @objc private func keyboradWillShow(notification: Notification) {
        guard let editingTextField = editingTextField else { return }
        let editingTextFieldPositionY = editingTextField.frame.origin.y + editingTextField.frame.height
        changeFrame(notification: notification,
                    verificationPositionY: editingTextFieldPositionY)
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        returnOriginFrame(notification: notification)
    }
    
}

