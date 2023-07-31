//
//  Intent.swift
//  Swift-MVI-Pattern
//
//  Created by 구본의 on 2023/07/31.
//

import Foundation
import RxSwift
import RxRelay

protocol LoginViewIntentProtocol {
  func bind(viewController: LoginViewController)
  func didTapSignUpButton(id: String, pw: String)
}

class LoginViewIntent: LoginViewIntentProtocol {
  
  private let stateObserver: PublishRelay<LoginState> = PublishRelay<LoginState>()
  private let repository: LoginRepository = LoginRepository()
  private let disposeBag: DisposeBag = DisposeBag()
  
  private var viewController: LoginViewController?
  
  
  func bind(viewController: LoginViewController) {
    self.viewController = viewController
    stateObserver
      .subscribe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] state in
        guard let self else { return }
        self.viewController?.render(state)
      }).disposed(by: disposeBag)
  }
  
  func didTapSignUpButton(id: String, pw: String) {
    repository.requestLogin(id: id, pw: pw)
      .subscribe(onNext: { [weak self] state in
        guard let self else { return }
        self.stateObserver.accept(state)
      }).disposed(by: disposeBag)
  }
}
