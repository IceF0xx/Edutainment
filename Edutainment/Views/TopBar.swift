//
//  TopBar.swift
//  Edutainment
//
//  Created by Desu Miko on 06.02.2021.
//

import Foundation
import SwiftUI

struct TopBar: View {
    @Binding private var age: Int
    @Binding private var questionQuantity: Int
    @Binding private var isTopBarHidden: Bool

    var body: some View {
        Group {
            VStack(spacing: 10) {
                HStack {
                    Text("How old are you?")
                        .font(.title)
                    
                    
                    Spacer()
                    
                    AgeStepper($age)
                    
                }
                .padding()
                
                HStack {
                    Text("How many questions?")
                        .font(.title3)
                        .padding([.leading, .trailing], 15)
                        
                    Spacer()
                    
                    QuestionStepper(q: $questionQuantity)
                }
                
                Button(action: {
                    withAnimation {
                        isTopBarHidden = true
                    }
                }) {
                    Text("Let's Go!")
                        .frame(
                            maxWidth: .infinity, minHeight: 50
                        )
                        .font(Font.title3.weight(.bold))
                        .background(Color.yellow)
                        .foregroundColor(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 2)
                }
                .padding([.leading,.trailing], 5)
            }
        }
        .transition(.move(edge: .top))
    }
    
    init(_ age: Binding<Int>, _ q: Binding<Int>, _ isTopBarHidden: Binding<Bool>) {
        self._age = age
        self._questionQuantity = q
        self._isTopBarHidden = isTopBarHidden
    }
}



struct ContentView3_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
