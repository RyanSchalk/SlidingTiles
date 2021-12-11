//
//  GameModel.swift
//  SlidingTiles
//
//  Created by Ryan Schalk on 12/11/21.
//

import Foundation

enum Direction {
    case up, down, left, right
    
    var opposite: Direction {
        switch self {
        case .up:
            return .down
        case .down:
            return .up
        case .left:
            return .right
        case .right:
            return .left
        }
    }
}

/// The gameboard is an NxN grid. This constant specifies N.
let BOARD_DIMENSION = 3

/**
 When instantiated, loads the initial game state. Models the state of the game as the player moves tiles.
 When initialized, the numbers on the board are randomly shuffled. Note that this may produce an unsolvable puzzle.
 */
class GameModel: ObservableObject {
    /// A 2D array where indexing by column, then row gives the object at that space on the gameboard. Each space is either nil (empty) or contains a number.
    @Published var board: [[Int?]]
    
    @Published var movesUsed = 0
    @Published var hasWon = false
    
    private var emptyPosition: (Int, Int)
    
    init () {
        var positions: [(Int, Int)] = []
        for column in 0..<BOARD_DIMENSION {
            for row in 0..<BOARD_DIMENSION {
                positions.append((column, row))
            }
        }
        
        let shuffledTileNumbers = Array(1...BOARD_DIMENSION * BOARD_DIMENSION - 1).shuffled()
        
        self.board = Array(
            repeating: Array(repeating: nil, count: BOARD_DIMENSION),
            count: BOARD_DIMENSION
        )
        
        self.emptyPosition = (BOARD_DIMENSION - 1, BOARD_DIMENSION - 1)
        
        zip(shuffledTileNumbers, positions).forEach { number, position in
            self.board[position.0][position.1] = number
        }
    }
    
    /// If possible, moves a tile on the board into the empty space by sliding the tile in the given direction.
    func slide(_ direction: Direction) {
        guard let tilePosition = getNeighbor(of: emptyPosition, inDirection: direction.opposite) else { return }
        guard let tileNumber = self.board[tilePosition.0][tilePosition.1] else { return }
        
        var newBoard = self.board
        
        newBoard[emptyPosition.0][emptyPosition.1] = tileNumber
        newBoard[tilePosition.0][tilePosition.1] = nil
        self.emptyPosition = tilePosition
        
        self.board = newBoard
        
        self.movesUsed += 1
        self.hasWon = checkForWin()
    }
    
    /// Given a position on the board, returns the immediate neighbor, if it exists, in the given direction.
    private func getNeighbor(of position: (Int, Int), inDirection direction: Direction) -> (Int, Int)? {
        var neighborColumn = position.0
        var neighborRow = position.1
        
        switch direction {
        case .up:
            neighborRow -= 1
        case .down:
            neighborRow += 1
        case .left:
            neighborColumn -= 1
        case .right:
            neighborColumn += 1
        }
        
        guard neighborColumn >= 0, neighborColumn < BOARD_DIMENSION,
              neighborRow >= 0, neighborRow < BOARD_DIMENSION else {
                  return nil
              }
        
        return (neighborColumn, neighborRow)
    }
    
    /// Returns true if the numbers on the gameboard are in order and the empty space is in the bottom-right corner.
    private func checkForWin() -> Bool {
        let bottomRightPosition = (BOARD_DIMENSION - 1, BOARD_DIMENSION - 1)
        guard self.board[bottomRightPosition.0][bottomRightPosition.1] == nil else { return false }
        
        var numbers: [Int] = []
        
        for row in 0..<BOARD_DIMENSION {
            for column in 0..<BOARD_DIMENSION {
                guard let number = self.board[column][row] else { continue }
                numbers.append(number)
            }
        }
        
        let sortedNumbers = numbers.sorted()
        return numbers.elementsEqual(sortedNumbers)
    }
}
