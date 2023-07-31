//
//  User.swift
//  Swift-MVI-Pattern
//
//  Created by 구본의 on 2023/07/31.
//

import Foundation

struct User: Codable {
  let name: String
}

enum LoginError: Error {
  case defaultError
  case error(code: Int)
  
  var msg: String {
    switch  self  {
    case .defaultError:
      return "ERROR"
    case .error(let code):
      return "\(code) Error"
    }
  }
}

enum LoginState {
  case success(_ user: User)
  case failure(_ error: LoginError)
}
