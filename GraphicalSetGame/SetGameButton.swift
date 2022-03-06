//
//  SetGameButton.swift
//  GraphicalSetGame
//
//  Created by Vasile Sebastian Catur on 02.03.2022.
//

import UIKit

class SetGameButton: UIButton {

    var card = Card()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        // Drawing code
    }

    func setButton(card: Card) {
        self.card = card
        self.setTitle(card.icon, for: .normal)
        self.setTitleColor(card.color, for: .normal)
        self.backgroundColor = .white
        self.clipsToBounds = true
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.blue.cgColor
        self.layer.cornerRadius = 1.0
    }

}
