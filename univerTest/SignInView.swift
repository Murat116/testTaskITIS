//
//  SignInView.swift
//  univerTest
//
//  Created by anmin on 24.07.2021.
//

import UIKit


//Это был закос на VIPER, но потом мне стало лень
class SignInView: UIView {
    
    private enum Metrics {
        static let height: CGFloat = 100
        static let sideOffSet: CGFloat = 25
        static let borderWidth: CGFloat = 3
        static let btnTop: CGFloat = 40
        static let borderColor = UIColor.white
        static let backgroundColor = UIColor.black
    }
    
    private let emailFiled: SignInField = {
        let view = SignInField(type: .email)
        view.keyboardType = .emailAddress
        view.layer.borderColor = Metrics.borderColor.cgColor
        view.layer.borderWidth = Metrics.borderWidth
        view.placeholder = "Email"
        return view
    }()
    
    private let passwordField: SignInField = {
        let view = SignInField(type: .password)
        view.layer.borderColor = Metrics.borderColor.cgColor
        view.layer.borderWidth = Metrics.borderWidth
        view.placeholder = "Password"
        return view
    }()
    
    private let logInButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("LogIn", for: .normal)
        btn.layer.borderColor = Metrics.borderColor.cgColor
        btn.layer.borderWidth = Metrics.borderWidth
        return btn
    }()
    
    private let ttsssbtn: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 50, width: 400, height: 70))
        btn.setTitleColor(Metrics.borderColor, for: .normal)
        btn.setTitle("kick me", for: .normal)
        btn.addAction(UIAction(handler: { _ in
            btn.setTitle("\(SignInView.mail) / \(SignInView.password)", for: .normal)
        }), for: .touchUpInside)
        return btn
    }()
    
    static var mail = "myEmail@mail.ru"
    static var password = "1wertY"

    private var scrollView = UIScrollView()
    private var bottomLayout: NSLayoutConstraint?
    private var isActive: Bool = false
    
    public var router: UIViewController? = nil
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setUpView()
        self.setUpTarget()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SignInView {
    
    func setUpTarget() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tap(sender:)))
        self.addGestureRecognizer(tap)
    }
    
    func setUpView(){
        self.backgroundColor = Metrics.backgroundColor
//
        self.addSubview(self.scrollView)
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.scrollView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.scrollView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.bottomLayout = self.scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        self.bottomLayout?.isActive = true
        
        self.scrollView.addSubview(self.passwordField)
        self.passwordField.translatesAutoresizingMaskIntoConstraints = false
        self.passwordField.centerYAnchor.constraint(equalTo: self.scrollView.centerYAnchor).isActive = true
        self.passwordField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Metrics.sideOffSet).isActive = true
        self.passwordField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Metrics.sideOffSet).isActive = true
        self.passwordField.heightAnchor.constraint(equalToConstant: Metrics.height).isActive = true
        
        self.scrollView.addSubview(self.emailFiled)
        self.emailFiled.translatesAutoresizingMaskIntoConstraints = false
        self.emailFiled.bottomAnchor.constraint(equalTo: self.passwordField.topAnchor, constant: -Metrics.sideOffSet).isActive = true
        self.emailFiled.rightAnchor.constraint(equalTo: self.passwordField.rightAnchor).isActive = true
        self.emailFiled.leftAnchor.constraint(equalTo: self.passwordField.leftAnchor).isActive = true
        self.emailFiled.heightAnchor.constraint(equalToConstant: Metrics.height).isActive = true
        
        self.scrollView.addSubview(self.logInButton)
        self.logInButton.translatesAutoresizingMaskIntoConstraints = false
        self.logInButton.topAnchor.constraint(equalTo: self.passwordField.bottomAnchor, constant: Metrics.btnTop).isActive = true
        self.logInButton.leftAnchor.constraint(equalTo: self.passwordField.leftAnchor).isActive = true
        self.logInButton.rightAnchor.constraint(equalTo: self.passwordField.rightAnchor).isActive = true
        self.logInButton.heightAnchor.constraint(equalToConstant: Metrics.height).isActive = true
        
        self.logInButton.addTarget(self, action: #selector(self.logIn(sender:)), for: .touchUpInside)
        
        self.scrollView.addSubview(self.ttsssbtn)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard !self.isActive else { return }
        guard let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        self.bottomLayout?.constant -= keyboardHeight
        self.isActive = true
    }
    
    @objc func tap(sender: Any) {
        guard sender is UITapGestureRecognizer else { return }
        self.bottomLayout?.constant = 0
        self.passwordField.resignFirstResponder()
        self.emailFiled.resignFirstResponder()
        self.isActive = false
    }
    
    @objc func logIn(sender: Any) {
        guard sender is UIButton else { return }
        self.passwordField.resignFirstResponder()
        self.emailFiled.resignFirstResponder()
        guard self.emailFiled.isValid, self.passwordField.isValid else { return }
        guard SignInView.mail == self.emailFiled.text else { return self.emailFiled.isValid = false}
        guard SignInView.password == self.passwordField.text else { return self.passwordField.isValid = false }
        let vc = ProfileVC()
        UserDefaults.standard.setValue(true, forKey: "UserIsLog")
        UserDefaults.standard.setValue(self.emailFiled.text!, forKey: ProfileType.mail.rawValue)
        
        UIApplication.shared.windows.first?.rootViewController = vc //костыль))
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}


