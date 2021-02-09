//
//  Questions.swift
//  Edutainment
//
//  Created by Desu Miko on 07.02.2021.
//

import Foundation
import SwiftUI

struct ShakeEffect: GeometryEffect {
    func effectValue(size: CGSize) -> ProjectionTransform {
        return ProjectionTransform(CGAffineTransform(translationX: -10 * sin(position * 2 * .pi), y: 0))
    }
    
    init(shakes: Int) {
        position = CGFloat(shakes)
    }
    
    var position: CGFloat
    var animatableData: CGFloat {
        get { position }
        set { position = newValue }
    }
}

extension View {
    func shake(_ s: Int) -> some View {
        self.modifier(ShakeEffect(shakes: s))
    }
}

struct Questions: View {
    var maximumMultiplyer: Int {
        return passedAge > 7 ? 40 : passedAge > 4 ? 20 : 10
    }
    
    var answer: Int {
        lhs * rhs
    }
    
    @State private var usersAnswer = ""
    @State private var lhs = Int.random(in: 1..<10)
    @State private var rhs = Int.random(in: 0..<10)
    
    @State private var buttonBackground: Color = .yellow
    @State private var buttonText = "Check!"
    @State private var mainText = "How much is"
    @State private var mainTextFont: Font = .title
    @State private var isMultiplicationTextEnabled = true
    

    @Binding var passedAge: Int
    @Binding var isGameStarted: Bool
    @Binding var questionsQuantity: Int
    @State private var questionNumber = 1
    @State private var shakes = 0

    var body: some View {
        VStack {
            Text("\(questionNumber)/\(questionsQuantity)")
                .padding()
                .overlay(Circle()
                            .stroke(Color.white))
                .alignmentGuide(.bottom) { d in d[.top] }

            Text(mainText)
                .font(mainTextFont)
            
            Text("\(lhs) x \(rhs)")
                .font(.largeTitle)
                .opacity(isMultiplicationTextEnabled ? 1 : 0)
            
            Group {
                TextField("", text: $usersAnswer, onCommit: {
                    validateUsersAnswer()
                })
                .keyboardType(.numberPad)
                .padding(10)
                .font(.title)
                .multilineTextAlignment(.center)
                .frame(width: 300)
                .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 2))
                    
                Button(action: {
                    withAnimation {
                        if usersAnswer.isEmpty {
                            return
                        }
                        
                        if !validateUsersAnswer() {
                            shakes += 1
                            buttonBackground = .red
                            buttonText = "Wrong!"
                        } else {
                            buttonBackground = .green
                            buttonText = "Correct!"
                            startNewRound()
                        }
                    }
                }, label: {
                    Text(buttonText)
                        .frame(
                            maxWidth: 200, minHeight: 40
                        )
                        .font(Font.title3.weight(.bold))
                        .background(buttonBackground)
                        .foregroundColor(Color.white)
                        .cornerRadius(12)
                        .shake(shakes)
                })

            }
            .disabled(!isGameStarted)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(RoundedRectangle(cornerRadius: 16)
                    .stroke()
                    .foregroundColor(.white))
        .padding([.leading, .trailing, .bottom])
        .onChange(of: maximumMultiplyer, perform: { _ in
            startNewRound(withDelay: 0, incrementQuestionsNumber: false)
        })
        .onChange(of: isGameStarted, perform: { _ in
            if isGameStarted {
                startNewGame()
            }
        })
    }
    
    func startNewGame() {
        questionNumber = 0
        mainText = "How much is"
        mainTextFont = .title
        startNewRound(withDelay:0)
        isMultiplicationTextEnabled = true
    }
    
    func showResults() {
        isGameStarted = false
        mainText = "Good job!"
        mainTextFont = .largeTitle
        isMultiplicationTextEnabled = false
    }
    
    func startNewRound(withDelay delay: Double = 1.5, incrementQuestionsNumber: Bool = true) {
        if questionNumber >= questionsQuantity {
            showResults()
        } else {
            DispatchQueue(label: "").asyncAfter(deadline: .now() + delay) {
                lhs = Int.random(in: 1...maximumMultiplyer)
                rhs = Int.random(in: 0...maximumMultiplyer)
                buttonText = "Check!"
                buttonBackground = .yellow
                usersAnswer = ""
            }
            
            if incrementQuestionsNumber {
                questionNumber += 1
            }
        }
    }
    
    @discardableResult
    func validateUsersAnswer() -> Bool {
        if let intUnserAnswer = Int(usersAnswer) {
            return intUnserAnswer == lhs * rhs
        }
        return false
    }
    
    init(_ q: Binding<Int>, difficulty: Binding<Int>,
         enabled: Binding<Bool>) {
        _passedAge = difficulty
        _questionsQuantity = q
        _isGameStarted = enabled
    }
}

struct ContentView_Previews4: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
