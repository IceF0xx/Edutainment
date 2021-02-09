//
//  ContentView.swift
//  Edutainment
//
//  Created by Desu Miko on 05.02.2021.
//

import SwiftUI

extension View {
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}


struct ContentView: View {
    @State private var age = 4
    @State private var questionQuantity = 10
    @State private var isTopBarHidden = false
    
    var body: some View {
        Group {
            ZStack {
                Color("Skyblue")
                    .ignoresSafeArea(.all)
                    
                VStack(spacing: 30) {
                    TopBar($age, $questionQuantity, $isTopBarHidden)
                        .frame(alignment: .top)
                        .isHidden(isTopBarHidden, remove: isTopBarHidden)
                        
                    Questions($questionQuantity, difficulty: $age,
                              enabled: $isTopBarHidden)
                        .opacity(isTopBarHidden ? 1 : 0.4)
                }

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
