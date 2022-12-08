//
//  EmojiMemoryGameView.swift
//  View
//  Memorize
//
//  Created by Madison Ranf on 10/5/22.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @Environment(\.colorScheme) var colorScheme
    /*
     Initialize this in the MemorizeApp (@main) file by passing in the
     pointer to the vm as the viewModel. The vm is observed for changes
     so the view will re-render anytime the model is changed.
     */

    @ObservedObject var game: EmojiMemoryGame

    var body: some View {
        VStack {
            Text("Memorize!").font(.title)
            AspectVGrid(items: game.cards, aspectRatio: 2/3, content: { card in
                cardView(for: card)
            })
            .foregroundColor(.orange)
            .padding(.horizontal)
            .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
        }
    }
    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card) -> some View {
        if card.isMatched && !card.isFaceUp {
            Rectangle().opacity(0)
        } else {
            CardView(card: card)
                .padding(4)
                .onTapGesture {
                    game.choose(card)
                }
        }
    }

    struct CardView: View {
        let card: EmojiMemoryGame.Card

        var body: some View {
            GeometryReader { geometry in
                ZStack {
                    TimerPie(
                        startAngle: Angle(degrees: 0-90),
                        endAngle: Angle(degrees: 110-90))
                    .padding(DrawingGlobals.timerCirclePadding)
                    .opacity(DrawingGlobals.timerCircleOpacity)
                    Text(card.content)
                        // Using implicit animation to spin the emojis
                        // when two cards are matched. Need to ensure that
                        // the animations are positioned directly against
                        // what we want to animate (in this case the
                        // change in card.IsMatched on this Text)
                        .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                        .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                        // Using a static font with scaling to make this
                        // animatable (.font is not animatable when using
                        // an auto-scaled font, but scaleEffect is
                        // animatable)
                        .font(Font.system(size: DrawingGlobals.fontSize))
                        .scaleEffect(scale(thatFits: geometry.size))
                }
                .cardify(isFaceUp: card.isFaceUp)
            }
        }
        
        private func scale(thatFits size: CGSize) -> CGFloat {
            min(size.width, size.height) / (DrawingGlobals.fontSize / DrawingGlobals.fontScale)
        }
    }
    // MARK: - Preview pane
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            let game = EmojiMemoryGame()
            game.choose(game.cards[0])
            game.choose(game.cards[2])
            // game.choose(game.cards[4])
            return EmojiMemoryGameView(game: game)
        }
    }
}
