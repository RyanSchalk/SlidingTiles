//
//  BoardView.swift
//  SlidingTiles
//
//  Created by Ryan Schalk on 12/11/21.
//

import SwiftUI

/// The gameboard is an NxN grid. This constant specifies N.
private let BOARD_DIMENSION = 3

/// The number of points between grid spaces on the gameboard.
private let BOARD_SPACING: CGFloat = 2

/// Given a tile with a logical position, returns an offset that allows the tile to be positioned absolutely on the gameboard.
private func getOffsetFor(column: Int, row: Int, size: CGFloat) -> CGSize {
    return CGSize(
        width: CGFloat(column) * (size + BOARD_SPACING),
        height: CGFloat(row) * (size + BOARD_SPACING)
    )
}

/**
 The gameboard grid. Contains the numbered tiles that the player moves around.
 */
struct BoardView: View {
    private let board: [[Int?]] = {
        var board: [[Int?]] = Array(
            repeating: Array(repeating: nil, count: BOARD_DIMENSION),
            count: BOARD_DIMENSION
        )
        
        board[0][0] = 1
        board[1][0] = 2
        board[1][1] = 5
        
        return board
    }()
    
    var body: some View {
        let tileNumbersAndPositions: [(Int, Int, Int)] = {
            var result: [(Int, Int, Int)] = []
            
            board.enumerated().forEach { columnNum, column in
                column.enumerated().forEach { rowNum, number in
                    if let number = number {
                        result.append((number, columnNum, rowNum))
                    }
                }
            }
            
            return result
        }()
        
        GeometryReader { geo in
            // These calculations allow the gameboard to take up the full width of the screen, which works well for portrait orientation.
            let totalSpacing: CGFloat = BOARD_SPACING * CGFloat(BOARD_DIMENSION - 1)
            let availableWidth: CGFloat = geo.size.width - totalSpacing
            let tileSize: CGFloat = availableWidth / CGFloat(BOARD_DIMENSION)
            let columns: [GridItem] = Array(
                repeating: .init(.fixed(tileSize), spacing: BOARD_SPACING),
                count: BOARD_DIMENSION
            )
            
            // A ZStack is used so that the tiles appear above the grid.
            // .topLeading makes it easy to position the tiles absolutely, according to their logical (non-UI) position.
            ZStack(alignment: .topLeading) {
                LazyVGrid(columns: columns, spacing: BOARD_SPACING) {
                    ForEach(0..<BOARD_DIMENSION*BOARD_DIMENSION) { _ in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(white: 0.6))
                            .frame(width: tileSize, height: tileSize)
                    }
                }
                
                // Changing the logical position of a number means that the corresponding tile view moves to a different location on the screen.
                ForEach(tileNumbersAndPositions, id: \.0) { number, column, row in
                    TileView(number: number)
                        .frame(width: tileSize, height: tileSize)
                        .offset(getOffsetFor(column: column, row: row, size: tileSize))
                }
            }
        }
    }
}


struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView()
    }
}
