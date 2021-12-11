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
 */
class GameModel: ObservableObject {
    /// A 2D array where indexing by column, then row gives the object at that space on the gameboard. Each space is either nil (empty) or contains a number.
    @Published var board: [[Int?]]
    
    init () {
        self.board = {
            var board: [[Int?]] = Array(
                repeating: Array(repeating: nil, count: BOARD_DIMENSION),
                count: BOARD_DIMENSION
            )
            
            board[0][0] = 1
            board[1][0] = 2
            board[1][1] = 5
            
            return board
        }()
    }
}
