//
//  Intent.swift
//  Swift-MVI-Pattern
//
//  Created by 구본의 on 2023/07/31.
//

import Foundation
import RxSwift
import RxRelay

class LoginViewIntent {
  let stateObserver: PublishRelay<LoginState> = PublishRelay<LoginState>()
  let repository: LoginRepository = LoginRepository()
  let disposeBag: DisposeBag = DisposeBag()
  
  var viewController: LoginViewController?
  
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
