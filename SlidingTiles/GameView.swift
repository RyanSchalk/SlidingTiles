//
//  GameView.swift
//  SlidingTiles
//
//  Created by Ryan Schalk on 12/11/21.
//

import SwiftUI

/**
 The main View for our game. It contains the board, and it will contain the number of moves used and whether the player has won.
 */
struct GameView: View {
    @StateObject private var model = GameModel()
    
    var body: some View {
        VStack {
            BoardView(board: model.board)
                .frame(maxWidth: .infinity)
                .aspectRatio(1, contentMode: .fit)
                .padding()
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
