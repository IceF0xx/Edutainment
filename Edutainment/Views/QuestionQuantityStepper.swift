//
//  QuestionQuantityStepper.swift
//  Edutainment
//
//  Created by Desu Miko on 06.02.2021.
//

import Foundation
import SwiftUI

struct QuestionStepper: View {
    let questionQuantitys = [5, 10, 15, 20]

    @Binding private var questionQuantity: Int

    var body: some View {
        HStack {
            ForEach(questionQuantitys, id: \.self) { q in
                Button(action: {
                    questionQuantity = q
                }, label: {
                    Text("\(q)")
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 4)
                                    .foregroundColor(q == questionQuantity ? .white : .yellow))
                        .padding([.trailing], 10)
                })
                
            }
        }
    }
    
    init(q: Binding<Int>) {
        self._questionQuantity = q
    }
}

struct ContentView_Previews2: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
