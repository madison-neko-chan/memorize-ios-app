//
//  Cardify.swift
//  Memorize
//
//  Created by Madison Ranf on 10/14/22.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    /*
     This function would be just whatever content is being passed into
     .cardify, meaning whatever it is that we're modifying. Remember that
     all .modifier() is doing is returninga View that displays *this* (in this
     case, *this* is the ZStack below.)
     */
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: DrawingGlobals.cornerRadius)
            if isFaceUp {
                //
                shape.fill().foregroundColor(.white)
            } else {
                shape.fill()
            }
            content
                .opacity(isFaceUp ? 1 : 0)
        }
    }
}
