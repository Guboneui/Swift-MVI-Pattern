//
//  HeroState.swift
//  Swift-MVI-Pattern
//
//  Created by 구본의 on 2023/07/30.
//

import Foundation

protocol HeroState {
  
}

class HeroPresenting: HeroState {
  
  let hero: Hero
  let nextAvailable: Bool
  let previousAvailable: Bool
  
  init(
    hero: Hero,
    nextAvailable: Bool,
    previousAvailable: Bool
  ) {
    self.hero = hero
    self.nextAvailable = nextAvailable
    self.previousAvailable = previousAvailable
  }
}

class HeroSelected: HeroState {
  
  let hero: Hero
  
  init(hero: Hero) {
    self.hero = hero
  }
}
