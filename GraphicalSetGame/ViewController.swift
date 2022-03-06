//
//  ViewController.swift
//  GraphicalSetGame
//
//  Created by Vasile Sebastian Catur on 01.03.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var dealMoreCardsButton: UIButton!
    @IBOutlet weak var cardContainer: SetGameContainerView!

    private lazy var game = SetGame()
    private var chosenCards = [Card]()
    private var chosenButtons = [SetGameButton]()
    private var matchCards = [Card]()
    private var hasThree = false

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
        let swipeDownGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeDownToDeal(recongnizer:)))
        swipeDownGestureRecognizer.direction = .down
        cardContainer.addGestureRecognizer(swipeDownGestureRecognizer)
        let rotateGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(rotateToReshuffle(recognizer:)))
        cardContainer.addGestureRecognizer(rotateGestureRecognizer)
    }

    @IBAction func dealMoreCards(_ sender: UIButton) {
        game.dealThreeMoreCards(cardsList: &game.cards)
        updateViewFromModel()
    }

    @objc func buttonAction(recognizer: UIPanGestureRecognizer) {
        if let sender = recognizer.view as? SetGameButton {
            if chosenButtons.contains(sender) {
                chosenButtons.remove(at: chosenButtons.firstIndex(of: sender)!)
                sender.backgroundColor = .white
            } else {
                chosenButtons.append(sender)
                sender.backgroundColor = .lightGray
            }
        }

        if chosenButtons.count == 3 {
            game.chosenButtons(cards: chosenButtons)
            updateChosenButtons()
        }
    }

    @objc func swipeDownToDeal(recongnizer: UISwipeGestureRecognizer) {
        game.dealThreeMoreCards(cardsList: &game.cards)
        updateViewFromModel()
    }

    @objc func rotateToReshuffle(recognizer: UIRotationGestureRecognizer) {
        game.cards.shuffle()
        updateViewFromModel()
    }

    @objc private func updateViewFromModel() {

        cardContainer.cardButtons.removeAll()
        for card in game.cards {
            let cardView = SetGameButton()
            cardView.setButton(card: card)
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.buttonAction(recognizer:)))
            cardView.addGestureRecognizer(tapGestureRecognizer)
            cardContainer.cardButtons.append(cardView)
        }

        if game.deckCards.isEmpty {
            dealMoreCardsButton.isEnabled = false
            dealMoreCardsButton.alpha = 0.2
        } else {
            dealMoreCardsButton.isEnabled = true
            dealMoreCardsButton.alpha = 1.0
        }
    }

    private func updateChosenButtons() {
        if game.foundMatch, !game.deckCards.isEmpty {
            game.dealThreeMoreCards(cardsList: &game.newCards)
        }
        for index in chosenButtons.indices {
            chosenButtons[index].layer.borderWidth = 5.0
            if game.foundMatch == true {
                chosenButtons[index].layer.borderColor = UIColor.green.cgColor
                for cardIndex in game.cards.indices.reversed() {
                    if game.cards[cardIndex] == chosenButtons[index].card {
                        if !game.deckCards.isEmpty {
                            game.cards[cardIndex] = game.newCards[index]
                        } else {
                            game.cards.remove(at: cardIndex)
                        }
                    }
                }
            } else {
                chosenButtons[index].layer.borderColor = UIColor.red.cgColor
            }
        }
        
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateViewFromModel), userInfo: nil, repeats: false)
        chosenButtons.removeAll()
        game.newCards.removeAll()
        game.foundMatch = false
    }
}

