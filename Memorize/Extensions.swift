//
//  Extensions.swift
//  Memorize
//
//  Created by Madison Ranf on 11/19/22.
//

import SwiftUI

extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            return first
        } else {
            return nil
        }
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        return self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
