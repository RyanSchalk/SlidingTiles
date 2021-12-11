//
//  TileView.swift
//  SlidingTiles
//
//  Created by Ryan Schalk on 12/11/21.
//

import SwiftUI

/**
 An instance of this View is a tile that is slid around the gameboard as a puzzle is solved.
 It should be given a square frame by an ancestor View.
 */
struct TileView: View {
    let number: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(white: 0.3))
            
            Text(String(number))
                .bold()
                .foregroundColor(.white)
        }
    }
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        TileView(number: 10)
    }
}
