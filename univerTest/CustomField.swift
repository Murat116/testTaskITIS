//
//  CustomField.swift
//  univerTest
//
//  Created by anmin on 25.07.2021.
//

import UIKit

class SignInField: UITextField {
    
    var type: FiedlType = .none
    
    var isValid: Bool {
        get{
            let valid = self.type.isValid(self.text ?? "")
            if valid {
                self.backgroundColor = .clear
            }else{
                self.backgroundColor = .red
            }
            return valid
        }
        set{
            if newValue {
                self.backgroundColor = .clear
            }else{
                self.backgroundColor = .red
            }
        }
    }
    
    init(type: FiedlType) {
        super.init(frame: .zero)
        self.type = type
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum FiedlType {
    case none
    case password
    case email
    
    var regEx: String {
        switch self {
        case .password:
            return "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z]).{6,}$"
        case .email:
            return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        case .none:
            return ""
        }
    }
    
    func isValid(_ str: String) -> Bool {
        let pred = NSPredicate(format:"SELF MATCHES %@", self.regEx)
        return pred.evaluate(with: str)
    }
    
    
}
