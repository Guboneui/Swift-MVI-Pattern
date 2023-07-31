//
//  Repository.swift
//  Swift-MVI-Pattern
//
//  Created by 구본의 on 2023/07/31.
//

import Foundation

import RxSwift

struct LoginRepository {
  func requestLogin(id: String, pw: String) -> Observable<LoginState> {
    
    return Observable.create { (observer) -> Disposable in
      if id != "" && pw != "" {
        observer.onNext(.success(User(name: id)))
      } else {
        observer.onNext(.failure(.defaultError))
      }
      observer.onCompleted()
      
      return Disposables.create()
    }
  }
}
