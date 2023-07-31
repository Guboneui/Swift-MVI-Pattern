//
//  LoginViewController.swift
//  Swift-MVI-Pattern
//
//  Created by 구본의 on 2023/07/31.
//

import UIKit

import Then
import SnapKit
import RxSwift
import RxRelay

class LoginViewController: UIViewController {
  
  private let idTextField: UITextField = UITextField().then {
    $0.placeholder = "ID"
    $0.borderStyle = .roundedRect
  }
  
  private let pwTextField: UITextField = UITextField().then {
    $0.placeholder = "PW"
    $0.borderStyle = .roundedRect
  }
  
  private let loginButton: UIButton = UIButton(type: .system).then {
    $0.setTitle("LOGIN", for: .normal)
    $0.backgroundColor = .cyan
    $0.layer.masksToBounds = true
    $0.layer.cornerRadius = 8
  }
  
  private let intent: LoginViewIntentProtocol
  private let disposeBag: DisposeBag = DisposeBag()
  
  init(intent: LoginViewIntentProtocol) {
    self.intent = intent
    super.init(nibName: nil, bundle: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupViews()
    self.setupLayouts()
    self.setupGeustures()
    self.intent.bind(viewController: self)
  }
  
  private func setupViews() {
    self.view.backgroundColor = .white
    
    self.view.addSubview(idTextField)
    self.view.addSubview(pwTextField)
    self.view.addSubview(loginButton)
  }
  
  private func setupLayouts() {
    idTextField.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
      make.horizontalEdges.equalToSuperview().inset(20)
      make.height.equalTo(48)
    }
    
    pwTextField.snp.makeConstraints { make in
      make.top.equalTo(idTextField.snp.bottom).offset(20)
      make.horizontalEdges.equalToSuperview().inset(20)
      make.height.equalTo(48)
    }
    
    loginButton.snp.makeConstraints { make in
      make.top.equalTo(pwTextField.snp.bottom).offset(40)
      make.horizontalEdges.equalToSuperview().inset(20)
      make.height.equalTo(48)
    }
  }
  
  private func setupGeustures() {
    loginButton.rx.tap
      .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
      .bind { [weak self] in
        guard let self else { return }
        guard let id = self.idTextField.text,
              let pw = self.pwTextField.text else { return }
        
        self.intent.didTapSignUpButton(id: id, pw: pw)
      }.disposed(by: disposeBag)
  }
  
  public func render(_ state: LoginState) {
    switch state {
    case .success(let user):
      print(user)
    case .failure(let error):
      print(error)
    }
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
