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

/**
 The gameboard grid. Will also contain numbered tiles.
 */
struct BoardView: View {
    var body: some View {
        GeometryReader { geo in
            // These calculations allow the gameboard to take up the full width of the screen, which works well for portrait orientation.
            let totalSpacing: CGFloat = BOARD_SPACING * CGFloat(BOARD_DIMENSION - 1)
            let availableWidth: CGFloat = geo.size.width - totalSpacing
            let tileSize: CGFloat = availableWidth / CGFloat(BOARD_DIMENSION)
            let columns: [GridItem] = Array(
                repeating: .init(.fixed(tileSize), spacing: BOARD_SPACING),
                count: BOARD_DIMENSION
            )
            
            LazyVGrid(columns: columns, spacing: BOARD_SPACING) {
                ForEach(0..<BOARD_DIMENSION*BOARD_DIMENSION) { _ in
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(white: 0.6))
                        .frame(width: tileSize, height: tileSize)
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
