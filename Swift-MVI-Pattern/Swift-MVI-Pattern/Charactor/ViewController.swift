//
//  ViewController.swift
//  Swift-MVI-Pattern
//
//  Created by 구본의 on 2023/07/30.
//

import UIKit
import Then
import SnapKit
import RxSwift

class ViewController: UIViewController {
  
  private let disposeBag: DisposeBag = DisposeBag()
  private let intent: MainIntent = MainIntent()
  
  private let characterLabel: UILabel = UILabel().then { label in
    label.font = UIFont.systemFont(ofSize: 17)
    label.textAlignment = .center
  }
  
  private let characterImageView: UIImageView = UIImageView().then { imageView in
    imageView.backgroundColor = .lightGray
    imageView.contentMode = .scaleAspectFit
  }
  
  private let prevButton: UIButton = UIButton(type: .system).then { button in
    button.setTitle("<", for: .normal)
    button.tintColor = .white
    button.backgroundColor = .orange
  }
  
  private let nextButton: UIButton = UIButton(type: .system).then { button in
    button.setTitle(">", for: .normal)
    button.tintColor = .white
    button.backgroundColor = .orange
  }
  
  private let speedLabel: UILabel = UILabel().then { label in
    label.textColor = .yellow
    label.font = UIFont.systemFont(ofSize: 17)
  }
  
  private let powerLabel: UILabel = UILabel().then { label in
    label.textColor = .red
    label.font = UIFont.systemFont(ofSize: 17)
  }
  
  private let staminaLabel: UILabel = UILabel().then { label in
    label.textColor = .green
    label.font = UIFont.systemFont(ofSize: 17)
  }
  
  private let selectButton: UIButton = UIButton(type: .system).then { button in
    button.setTitle("캐릭터 선택", for: .normal)
    button.backgroundColor = .orange
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    print("🔊[DEBUG]: ViewController didLoad")
    self.setupViews()
    self.setupLayouts()
    self.setupGestures()
    self.setupBinding()
  }
  
  private func setupViews() {
    self.view.backgroundColor = .white
    
    self.view.addSubview(characterLabel)
    self.view.addSubview(characterImageView)
    self.view.addSubview(prevButton)
    self.view.addSubview(nextButton)
    self.view.addSubview(speedLabel)
    self.view.addSubview(powerLabel)
    self.view.addSubview(staminaLabel)
    self.view.addSubview(selectButton)
  }
  
  private func setupLayouts() {
    characterLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.horizontalEdges.equalToSuperview()
    }
    
    characterImageView.snp.makeConstraints { make in
      make.size.equalTo(150)
      make.center.equalToSuperview()
    }
    
    prevButton.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(20)
      make.centerY.equalToSuperview()
      make.size.equalTo(30)
    }
    
    nextButton.snp.makeConstraints { make in
      make.trailing.equalToSuperview().offset(-20)
      make.centerY.equalToSuperview()
      make.size.equalTo(30)
    }
    
    speedLabel.snp.makeConstraints { make in
      make.top.equalTo(characterImageView.snp.bottom).offset(20)
      make.horizontalEdges.equalToSuperview().inset(20)
    }
    
    powerLabel.snp.makeConstraints { make in
      make.top.equalTo(speedLabel.snp.bottom).offset(20)
      make.horizontalEdges.equalToSuperview().inset(20)
    }
    
    staminaLabel.snp.makeConstraints { make in
      make.top.equalTo(powerLabel.snp.bottom).offset(20)
      make.horizontalEdges.equalToSuperview().inset(20)
    }
    
    selectButton.snp.makeConstraints { make in
      make.bottom.equalTo(view.safeAreaLayoutGuide)
      make.horizontalEdges.equalToSuperview()
      make.height.equalTo(48)
    }
  }
  
  private func setupBinding() {
    self.intent.bind(toView: self)
  }
  
  public func update(withState state: HeroState) {
    switch state {
    case is HeroPresenting:
      guard let heroState = state as? HeroPresenting else { return }
      self.showPresentState(withPresentState: heroState)
    case is HeroSelected:
      guard let heroState = state as? HeroSelected else { return }
      self.showSelectedState(withHeroName: heroState.hero.name)
    default: break
    }
  }
  
  private func showPresentState(withPresentState state: HeroPresenting) {
    let hero = state.hero
    characterLabel.text = hero.name
    characterImageView.image = UIImage(named: hero.name)
    speedLabel.text = "SPEED: \(hero.speed)"
    powerLabel.text = "POWER: \(hero.power)"
    staminaLabel.text = "STAMINA: \(hero.stamina)"
    
    nextButton.isEnabled = state.nextAvailable
    prevButton.isEnabled = state.previousAvailable
  }
  
  private func showSelectedState(withHeroName name: String) {
    print("SHOW: \(name)")
  }
  
  private func setupGestures() {
    prevButton.rx.tap.bind { [weak self] in
      guard let self else { return }
      self.intent.onPreviousCharacterClicked()
    }.disposed(by: disposeBag)
    
    nextButton.rx.tap.bind { [weak self] in
      guard let self else { return }
      self.intent.onNextCharacterClicked()
    }.disposed(by: disposeBag)
    
    selectButton.rx.tap.bind { [weak self] in
      guard let self else { return }
      self.intent.onSelectCharacter()
    }.disposed(by: disposeBag)
  }
}
