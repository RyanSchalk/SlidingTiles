//
//  GameModel.swift
//  SlidingTiles
//
//  Created by Ryan Schalk on 12/11/21.
//

import Foundation

/// The gameboard is an NxN grid. This constant specifies N.
let BOARD_DIMENSION = 3

/**
 When instantiated, loads the initial game state. Models the state of the game as the player moves tiles.
 This includes the board, and will include the number of moves used and whether the player has won.
 
 When initialized, the numbers on the board are randomly shuffled. Note that this may produce an unsolvable puzzle.
 */
class GameModel: ObservableObject {
    /// A 2D array where indexing by column, then row gives the object at that space on the gameboard. Each space is either nil (empty) or contains a number.
    @Published var board: [[Int?]]
    
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
        
        zip(shuffledTileNumbers, positions).forEach { number, position in
            self.board[position.0][position.1] = number
        }
    }
}
