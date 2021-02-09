//
//  AgeStepper.swift
//  Edutainment
//
//  Created by Desu Miko on 06.02.2021.
//

import Foundation
import SwiftUI

struct AgeStepper: View {
    @Binding private var age: Int
    @State private var isUpButtonInactive = false
    @State private var isDownButtonInactive = false
    
    init(_ age: Binding<Int>) {
        self._age = age
    }
    
    var body: some View {
        HStack(spacing: 20) {
            Button(action: {
                if !isDownButtonInactive {
                    age -= 1
                }
                if age < 4 {
                    isDownButtonInactive = true
                } else {
                    isDownButtonInactive = false
                    isUpButtonInactive = false
                }
            }, label: {
                Image(systemName: "arrow.down")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .opacity(isDownButtonInactive ? 0.5 : 1)
                    .padding(5)
            })
            .font(.headline)
            .disabled(isDownButtonInactive)
            
            Text("\(age)")
                .font(.title)
            
            Button(action: {
                if !isUpButtonInactive {
                    age += 1
                }
                
                if age >= 9 {
                    isUpButtonInactive = true
                } else {
                    isUpButtonInactive = false
                    isDownButtonInactive = false
                }
            }, label: {
                Image(systemName: "arrow.up")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .opacity(isUpButtonInactive ? 0.5 : 1)
                    .padding(5)

            })
            .font(.headline)
            .disabled(isUpButtonInactive)
        }

    }
    
}

struct ContentVi2ew_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
