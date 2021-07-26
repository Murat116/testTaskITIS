//
//  SignInVC.swift
//  univerTest
//
//  Created by anmin on 24.07.2021.
//

import UIKit

class SignInVC: UIViewController {
    override func loadView() {
        let view = SignInView()
        view.router = self
        self.view = view
        
    }
}
