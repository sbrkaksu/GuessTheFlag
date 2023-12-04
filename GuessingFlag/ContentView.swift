//
//  ContentView.swift
//  GuessingFlag
//
//  Created by Berk Aksu on 3.12.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.cyan, .black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 30){
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                        .font(.subheadline.weight(.heavy))
                    
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle.weight(.semibold))
                }
                ForEach(0..<3){ number in
                    Button{
                        flagTapped(number)
                    }label: {
                        Image(countries[number])
                            .renderingMode(.original)
                            .border(.black)
                            .shadow(radius: 15)
                    }
                }
            }
            .alert(scoreTitle, isPresented: $showingScore){
                Button("Countinue", action: askQuestion)
                Button("Start new game!", action: resetGame)
            }   message: {
                Text("Your score is \(score)")
            }
        }
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
        }
        showingScore = true
    }
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    func resetGame(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        score = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
