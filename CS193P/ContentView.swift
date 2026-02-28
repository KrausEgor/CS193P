//
//  ContentView.swift
//  CS193P
//
//  Created by KRUEGER on 11.02.2026.
//

import SwiftUI
import SwiftData
import CoreData
import AVFoundation

struct ContentView: View {
    let emojis = ["😈", "💀", "🎃", "👽", "👹", "😈", "💀", "👻", "👽", "👹", "😈", "💀", "🎃", "👽", "👹"]
    @State var cardCount: Int = 4
    
    
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            Spacer()
            cardCountAjuster
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount/*emojis.indices*/, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    var cardCountAjuster: some View {
        HStack {
            cardRevocer
            Spacer()
            cartAdder
        }
        .imageScale(.small)
        .padding()
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
        
    var cardRevocer: some View {
      return cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill").font(.largeTitle)
    }
    
    var cartAdder: some View {
       cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill").font(.largeTitle)
        }
    
    
    }

struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = true
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 23)
            Group {
                base.fill(.regularMaterial)
                base.strokeBorder(lineWidth: 2)
               Text(content)
                    .font(.largeTitle)
                    
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        //    isFaceUp = !isFaceUp
        }
    }
}
#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}


