//
//  ProfileVC.swift
//  univerTest
//
//  Created by anmin on 25.07.2021.
//

import UIKit

class ProfileVC: UIViewController {
    let avatarView = UIImageView(image: UIImage(named: "Unknown"))
    let nameField = ProfileField(type: .name)
    let surnameField = ProfileField(type: .surname)
    let mailField = ProfileField(type: .mail)
    
    let savebtn = UIButton()
    let logOutBtn = UIButton()
    
    override func viewDidLoad() {
        self.setUp()
    }
    
    func setUp() {
        self.view.addSubview(self.avatarView)
        self.avatarView.translatesAutoresizingMaskIntoConstraints = false
        self.avatarView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40).isActive = true
        self.avatarView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.avatarView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.avatarView.widthAnchor.constraint(equalTo: self.avatarView.heightAnchor).isActive = true
        self.avatarView.contentMode = .scaleToFill
        
        self.view.addSubview(self.nameField)
        self.nameField.translatesAutoresizingMaskIntoConstraints = false
        self.nameField.topAnchor.constraint(equalTo: self.avatarView.bottomAnchor, constant: 25).isActive = true
        self.nameField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 25).isActive = true
        self.nameField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25).isActive = true
        self.nameField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.view.addSubview(self.surnameField)
        self.surnameField.translatesAutoresizingMaskIntoConstraints = false
        self.surnameField.topAnchor.constraint(equalTo: self.nameField.bottomAnchor, constant: 25).isActive = true
        self.surnameField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 25).isActive = true
        self.surnameField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25).isActive = true
        self.surnameField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.view.addSubview(self.mailField)
        self.mailField.translatesAutoresizingMaskIntoConstraints = false
        self.mailField.topAnchor.constraint(equalTo: self.surnameField.bottomAnchor, constant: 25).isActive = true
        self.mailField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 25).isActive = true
        self.mailField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25).isActive = true
        self.mailField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.view.addSubview(self.savebtn)
        self.savebtn.translatesAutoresizingMaskIntoConstraints = false
        self.savebtn.topAnchor.constraint(equalTo: self.mailField.bottomAnchor, constant: 40).isActive = true
        self.savebtn.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 25).isActive = true
        self.savebtn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25).isActive = true
        self.savebtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.savebtn.setTitle("Save", for: .normal)
        self.savebtn.setTitleColor(.white, for: .normal)
        self.savebtn.addTarget(self, action: #selector(self.save), for: .touchUpInside)
        
        self.view.addSubview(self.logOutBtn)
        self.logOutBtn.translatesAutoresizingMaskIntoConstraints = false
        self.logOutBtn.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 35).isActive = true
        self.logOutBtn.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -25).isActive = true
        self.logOutBtn.setTitle("Log out", for: .normal)
        self.logOutBtn.setTitleColor(.white, for: .normal)
        self.logOutBtn.addTarget(self, action: #selector(self.logOut), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tap(sender:)))
        self.view.addGestureRecognizer(tap)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.avatarView.layer.cornerRadius = self.avatarView.frame.height  / 2
        self.avatarView.layer.masksToBounds = false
        self.avatarView.clipsToBounds = true
    }
    
    @objc func save() {
        self.nameField.save()
        self.surnameField.save()
        self.mailField.save()
    }
    
    @objc func logOut(){
        UserDefaults.standard.setValue(false, forKey: "UserIsLog")
        let signIn = SignInVC()
        UIApplication.shared.windows.first?.rootViewController = signIn //костыль))
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    @objc func tap(sender: Any) {
        self.nameField.resignFirstResponder()
        self.surnameField.resignFirstResponder()
        self.mailField.resignFirstResponder()
    }
}

class ProfileField: UITextField {
    var type: ProfileType = .none
    
    init(type: ProfileType){
        super.init(frame: .zero)
        self.type = type
        self.placeholder = type.rawValue
        guard let value = UserDefaults.standard.value(forKey: self.type.rawValue) as? String else { return }
        self.text = value
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func save(){
        UserDefaults.standard.setValue(self.text ?? "", forKey: type.rawValue)
    }
}

enum ProfileType: String {
    case none
    case name
    case surname
    case mail

}
