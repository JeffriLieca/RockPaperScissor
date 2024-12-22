//
//  ContentView.swift
//  RockPaperScissor
//
//  Created by Jeffri Lieca H on 22/12/24.
//

import SwiftUI

struct ContentView: View {
    let arrayChoices = ["Rock", "Paper", "Scisscor"]
    @State private var currentChoice = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var questionRemaining = 10
    @State private var showAlertDone = false
    @State private var showAlertAnswer = false
    @State private var answerMessage = ""
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.red, .blue, .green], startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 0, y: 1))
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                Text(arrayChoices[currentChoice])
                    .font(.system(size: 50).bold())
                    .foregroundStyle(.white)
                Text("You should \(shouldWin ? "Win" : "Lose")")
//                    .font(.headline)
                    .foregroundStyle(.secondary)
                    .font(.system(size: 30).bold())
                Spacer()
                VStack(spacing: 20){
                    Text("Choice One :")
                        .font(.title3.weight(.heavy))
                        .foregroundStyle(.black)
                    HStack{
                        ForEach(0..<3) { choice in
                            Button{
                                countScore(choice: choice)
                            } label: {
                                Text(arrayChoices[choice])
                                    .foregroundStyle(.white)
                                    .font(.title2.bold())
                            }
                        }
                        .frame(width: 100,height: 100)
                        .background( Color(red: 0.7, green: 0.2, blue: 0.4))
                        .clipShape(.rect(cornerRadius: 20))
                    }
//                    .padding(.horizontal, 100)
                }
                .padding(20)
                .background(.white.opacity(0.7))
//                .frame(maxWidth: .infinity)
//                .padding()
                .clipShape(.rect(cornerRadius: 40))
//                .padding()
               
               
                Spacer()
                Spacer()
                VStack {
                    Text("Score : \(score)/10")
                        .font(.title3.bold())
                        .foregroundStyle(.white)
                    Text("Challenge Remaining : \(questionRemaining)")
                        .font(.title3.bold())
                        .foregroundStyle(.white)
                }
//                Spacer()
            }
            
            
            .padding()
        }
        .alert(answerMessage, isPresented: $showAlertAnswer){
//            Button("Yes",role: .destructive) {
//                
//            }
        } message: {
            Text("Your score : \(score)/10")
        }
        .alert("Game is Over", isPresented: $showAlertDone){
            Button("Exit", role: .destructive) {
                
            }
            Button("Reset", role: .cancel) {
                reset()
            }
        }
    }
    
    func checkCorrect(choice: Int) -> (Bool, String) {
        var correctAnswer = ""
        if shouldWin {
            var choiceCheck = currentChoice + 1
            choiceCheck = (choiceCheck > 2 ? 0 : choiceCheck)
            correctAnswer = arrayChoices[choiceCheck]
            if choice == choiceCheck {
                return (true, correctAnswer)
            }
        }
        else {
            var choiceCheck = currentChoice - 1
            choiceCheck = (choiceCheck < 0 ? 2 : choiceCheck)
            correctAnswer = arrayChoices[choiceCheck]
            if choice == choiceCheck {
                return (true, correctAnswer)
            }
        }
        return (false, correctAnswer)
    }
    
    func countScore(choice : Int) {
        let (check, correctAnswer) = checkCorrect(choice: choice)
        if check {
            score += 1
            answerMessage = "Correct"
        }
        else {
            answerMessage = "Wrong, it should be \(correctAnswer)"
        }
        randomChoice()
        questionRemaining -= 1
        
        if questionRemaining <= 0 {
            showAlertDone = true
        }
        else {
            showAlertAnswer = true
        }
        
    }
    
    func reset() {
        score = 0
        questionRemaining = 10
        randomChoice()
    }
    
    func randomChoice() {
        currentChoice = Int.random(in: 0..<3)
        shouldWin = Bool.random()
    }
}

#Preview {
    ContentView()
}
