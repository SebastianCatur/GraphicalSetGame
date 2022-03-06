//
//  SetGame.swift
//  GraphicalSetGame
//
//  Created by Vasile Sebastian Catur on 01.03.2022.
//

import Foundation
import UIKit

enum FindSameShape {
    case found
    case notFound
}

enum FindSet {
    case found
    case notFound
}

class SetGame {

    var deckCards = [Card]()
    var foundMatch = false
    var arrayOfCards = [Card]()
    var cards = [Card]()
    var newCards = [Card]()

    init() {
        let numbers = [1, 2, 3]
        let shapes = ["▲", "●", "■"]
        let colors = [UIColor.red, UIColor.green, UIColor.blue, UIColor.purple, UIColor.orange]

        for colorIndex in colors.indices {
            let color = colors[colorIndex]
            for iconIndex in shapes.indices {
                let shape = shapes[iconIndex]
                for numberIndex in numbers.indices {
                    let number = numbers[numberIndex]
                    let icon = String(repeating: shape, count: number)
                    let card = Card(color: color, number: number , shape: shape , icon: icon)
                    arrayOfCards.append(card)
                }
            }
        }

        shuffleCards()

        for index in 0..<12 {
            cards.append(deckCards[index])
            deckCards.remove(at: index)
        }
    }

    func dealThreeMoreCards(cardsList: inout [Card]) {
        if deckCards.count > 3 {
            for index in 0..<3 {
                cardsList.append(deckCards[index])
                deckCards.remove(at: index)
            }
        } else {
            for index in deckCards.indices {
                cardsList.append(deckCards[index])
            }
            deckCards.removeAll()
        }
    }

    func shuffleCards() {
        deckCards = arrayOfCards.shuffled()
    }

    func chosenButtons(cards: [SetGameButton]) {
        let selectedCards = findMatch(array: cards)
        switch selectedCards {
        case .found:
            foundMatch = true
        case .notFound:
            foundMatch = false
        }
    }

    func findMatch(array: [SetGameButton]) -> FindSet {
        let number = Set([array[0].card.number, array[1].card.number, array[2].card.number])
        let shape = Set([array[0].card.shape, array[1].card.shape, array[2].card.shape])
        let color = Set([array[0].card.color, array[1].card.color, array[2].card.color])

        if number.count == 1 || number.count == 3 {
            if shape.count == 1 || shape.count == 3 {
                if color.count == 1 || color.count == 3 {
                    return .found
                }
            }
        }

        return .notFound
    }
}
