//
//  MainIntent.swift
//  Swift-MVI-Pattern
//
//  Created by 구본의 on 2023/07/30.
//

import Foundation
import RxSwift
import RxCocoa

class MainIntent {
  var stateRelay: PublishRelay<HeroState>
  var view: ViewController?
  let heroSelector = HeroSelector()
  var disposeBag = DisposeBag()
  
  init() {
    stateRelay = PublishRelay()
  }
  
  public func bind(toView view: ViewController) {
    self.view = view
    
    stateRelay.subscribe { event in
      guard let state = event.element else { return }
      self.view?.update(withState: state)
    }.disposed(by: disposeBag)
    
    let hero = heroSelector.currentHero
    let next = heroSelector.isNextHeroAvailable()
    let previous = heroSelector.isPreviousHeroAvailable()
    
    stateRelay.accept(
      HeroPresenting(
        hero: hero,
        nextAvailable: next,
        previousAvailable: previous
      )
    )
  }
  
  public func onPreviousCharacterClicked() {
    guard let hero = heroSelector.previousHero else { return }
    presentHero(hero: hero)
  }
  
  public func onNextCharacterClicked() {
    guard let hero = heroSelector.nextHero else { return }
    presentHero(hero: hero)
  }
  
  public func onSelectCharacter() {
    stateRelay.accept(HeroSelected(hero: heroSelector.currentHero))
  }
  
  public func onDismissCharacter() {
    presentHero(hero: heroSelector.currentHero)
  }
  
  private func presentHero(hero: Hero) {
    let next = heroSelector.isNextHeroAvailable()
    let previous = heroSelector.isPreviousHeroAvailable()
    stateRelay.accept(
      HeroPresenting(
        hero: hero,
        nextAvailable: next,
        previousAvailable: previous
      )
    )
  }
}
