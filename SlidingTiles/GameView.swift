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
                .gesture(DragGesture(minimumDistance: 20, coordinateSpace: .global).onEnded { value in
                    let horizontalAmount = value.translation.width as CGFloat
                    let verticalAmount = value.translation.height as CGFloat
                    
                    let direction: Direction = {
                        if abs(horizontalAmount) > abs(verticalAmount) {
                            return horizontalAmount < 0 ? .left : .right
                        } else {
                            return verticalAmount < 0 ? .up : .down
                        }
                    }()
                    
                    withAnimation(.linear(duration: 0.2)) {
                        model.slide(direction)
                    }
                })
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
