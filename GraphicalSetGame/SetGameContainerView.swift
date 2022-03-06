//
//  SetGameContainerView.swift
//  GraphicalSetGame
//
//  Created by Vasile Sebastian Catur on 02.03.2022.
//

import UIKit

class SetGameContainerView: UIView {

    lazy var cardButtons = [SetGameButton]() {
        didSet {
            if cardButtons.count != 0 {
                if cardButtons.count > numberOfColumns * numberOfColumns {
                    numberOfColumns += 1
                } else {
                    setNeedsDisplay()
                }
            }
        }
    }
    private let game = SetGame()
    var numberOfColumns = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    var nrOfRows: Double = 0.0


    override func draw(_ rect: CGRect) {
        self.subviews.forEach{$0.removeFromSuperview()}
        refreshRows()
        if numberOfColumns - Int(nrOfRows) == 2 {
            numberOfColumns = numberOfColumns - 1

            refreshRows()
        }

        let grid = Grid(layout: .dimensions(rowCount: Int(nrOfRows), columnCount: numberOfColumns), frame: self.bounds)
        for index1 in 0..<numberOfColumns {
            for index2 in 0..<numberOfColumns {
                let index = index2 + index1 * numberOfColumns
                if index < cardButtons.count {
                    if let frame = grid[index1, index2] {
                        let view = cardButtons[index]
                        view.frame = frame
                        addSubview(view)
                    }
                }
            }
        }
    }

    func refreshRows() {
        nrOfRows = Double(cardButtons.count) / Double(numberOfColumns)
        let remain = nrOfRows.truncatingRemainder(dividingBy: 1)
        if remain != 0.0 {
            nrOfRows = nrOfRows + 1
        }
    }
}
