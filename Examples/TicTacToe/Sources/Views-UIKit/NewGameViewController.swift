import Combine
import ComposableArchitecture
import NewGameCore
import UIKit

class NewGameViewController: UIViewController {
  struct ViewState: Equatable {
    let isGameActive: Bool
    let isLetsPlayButtonEnabled: Bool
    let oPlayerName: String?
    let xPlayerName: String?
  }

  enum ViewAction {
    case gameDismissed
    case letsPlayButtonTapped
    case logoutButtonTapped
    case oPlayerNameChanged(String?)
    case xPlayerNameChanged(String?)
  }

  let store: Store<NewGameState, NewGameAction>
  let viewStore: ViewStore<ViewState, ViewAction>

  init(store: Store<NewGameState, NewGameAction>) {
    self.store = store
    self.viewStore = ViewStore(store.scope(state: { $0.view }, action: NewGameAction.view))
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.navigationItem.title = "New Game"

    self.navigationItem.rightBarButtonItem = UIBarButtonItem(
      title: "Logout",
      style: .done,
      target: self,
      action: #selector(logoutButtonTapped)
    )

    let playerXLabel = UILabel()
    playerXLabel.text = "Player X"
    playerXLabel.setContentHuggingPriority(.required, for: .horizontal)

    let playerXTextField = UITextField()
    playerXTextField.borderStyle = .roundedRect
    playerXTextField.placeholder = "Blob Sr."
    playerXTextField.setContentCompressionResistancePriority(.required, for: .horizontal)
    playerXTextField.addTarget(
      self, action: #selector(playerXTextChanged(sender:)), for: .editingChanged)

    let playerXRow = UIStackView(arrangedSubviews: [
      playerXLabel,
      playerXTextField,
    ])
    playerXRow.spacing = 24

    let playerOLabel = UILabel()
    playerOLabel.text = "Player O"
    playerOLabel.setContentHuggingPriority(.required, for: .horizontal)

    let playerOTextField = UITextField()
    playerOTextField.borderStyle = .roundedRect
    playerOTextField.placeholder = "Blob Jr."
    playerOTextField.setContentCompressionResistancePriority(.required, for: .horizontal)
    playerOTextField.addTarget(
      self, action: #selector(playerOTextChanged(sender:)), for: .editingChanged)

    let playerORow = UIStackView(arrangedSubviews: [
      playerOLabel,
      playerOTextField,
    ])
    playerORow.spacing = 24

    let letsPlayButton = UIButton(type: .system)
    letsPlayButton.setTitle("Let’s Play!", for: .normal)
    letsPlayButton.addTarget(self, action: #selector(letsPlayTapped), for: .touchUpInside)

    let rootStackView = UIStackView(arrangedSubviews: [
      playerXRow,
      playerORow,
      letsPlayButton,
    ])
    rootStackView.isLayoutMarginsRelativeArrangement = true
    rootStackView.layoutMargins = .init(top: 0, left: 32, bottom: 0, right: 32)
    rootStackView.translatesAutoresizingMaskIntoConstraints = false
    rootStackView.axis = .vertical
    rootStackView.spacing = 24

    self.view.addSubview(rootStackView)

    NSLayoutConstraint.activate([
      rootStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      rootStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      rootStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
    ])

    self.viewStore.producer.isLetsPlayButtonEnabled
      .assign(to: \.isEnabled, on: letsPlayButton)

    self.viewStore.producer.oPlayerName
      .assign(to: \.text, on: playerOTextField)

    self.viewStore.producer.xPlayerName
      .assign(to: \.text, on: playerXTextField)

    self.store
      .scope(state: { $0.game }, action: NewGameAction.game)
      .ifLet(
        then: { [weak self] gameStore in
          self?.navigationController?.pushViewController(
            GameViewController(store: gameStore),
            animated: true
          )
        },
        else: { [weak self] in
          guard let self = self else { return }
          self.navigationController?.popToViewController(self, animated: true)
        }
      )
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(true)

    if !self.isMovingToParent {
      self.viewStore.send(.gameDismissed)
    }
  }

  @objc private func logoutButtonTapped() {
    self.viewStore.send(.logoutButtonTapped)
  }

  @objc private func playerXTextChanged(sender: UITextField) {
    self.viewStore.send(.xPlayerNameChanged(sender.text))
  }

  @objc private func playerOTextChanged(sender: UITextField) {
    self.viewStore.send(.oPlayerNameChanged(sender.text))
  }

  @objc private func letsPlayTapped() {
    self.viewStore.send(.letsPlayButtonTapped)
  }
}

extension NewGameState {
  var view: NewGameViewController.ViewState {
    .init(
      isGameActive: self.game != nil,
      isLetsPlayButtonEnabled: !self.oPlayerName.isEmpty && !self.xPlayerName.isEmpty,
      oPlayerName: self.oPlayerName,
      xPlayerName: self.xPlayerName
    )
  }
}

extension NewGameAction {
  static func view(_ action: NewGameViewController.ViewAction) -> Self {
    switch action {
    case .gameDismissed:
      return .gameDismissed
    case .letsPlayButtonTapped:
      return .letsPlayButtonTapped
    case .logoutButtonTapped:
      return .logoutButtonTapped
    case let .oPlayerNameChanged(name):
      return .oPlayerNameChanged(name ?? "")
    case let .xPlayerNameChanged(name):
      return .xPlayerNameChanged(name ?? "")
    }
  }
}
