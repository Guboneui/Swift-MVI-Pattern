//
//  Hero.swift
//  Swift-MVI-Pattern
//
//  Created by 구본의 on 2023/07/30.
//

import Foundation

class Hero {
  let name: String
  let speed: Float
  let power: Float
  let stamina: Float
  
  init(
    name: String,
    speed: Float,
    power: Float,
    stamina: Float
  ) {
    self.name = name
    self.speed = speed
    self.power = power
    self.stamina = stamina
  }
}
