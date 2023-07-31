//
//  HeroSelector.swift
//  Swift-MVI-Pattern
//
//  Created by 구본의 on 2023/07/30.
//

import Foundation

class HeroSelector {
  
  // MARK: State
  let heroes: [Hero]
  var heroId: Int = 0
  
  // MARK: Properties
  var previousHero: Hero? { return getPreviousHero() }
  var nextHero: Hero? { return getNextHero() }
  var currentHero: Hero { return heroes[heroId] }
  
  init() {
    heroes = [
      Hero(name: "Son-Goku", speed: 7.0, power: 7.0, stamina: 5.0),
      Hero(name: "YoRHa 2B", speed: 10.0, power: 5.0, stamina: 5.0),
      Hero(name: "Lara Croft", speed: 6.0, power: 6.0, stamina: 7.0)
    ]
  }
  
  private func getNextHero() -> Hero? {
    if !isNextHeroAvailable() { return nil }
    heroId += 1
    return heroes[heroId]
  }
  
  public func getPreviousHero() -> Hero? {
    if !isPreviousHeroAvailable() { return nil }
    heroId -= 1
    return heroes[heroId]
  }
  
  public func isNextHeroAvailable() -> Bool {
    return heroes.count - 1 > heroId
  }
  
  public func isPreviousHeroAvailable() -> Bool {
    return heroId > 0
  }
}
