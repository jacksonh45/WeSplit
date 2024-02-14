//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Jackson Harrison on 2/14/24.
import SwiftUI

struct ContentView: View {
    
    var possibleMoves = ["Paper",       "Scissors", "Rock"]
    var imageNames       = ["newspaper.fill","scissors", "globe"]
    var imageColors      = [Color.purple,    .orange,    .green]
    
    @State private var playerShouldWin = Bool.random()
    @State private var appCurrentChoice = Int.random(in: 0...2)
    
    @State private var moveCounter = 0
    @State private var currentScore = 0
    
    /// sets bool to true to make sure the popup appears on launch
    @State private var isShowingGameSetupAlert = true
    @State private var titleText = ""
    @State private var messageText = ""
    @State private var dismissText = ""
    
    var imageFrame: CGFloat = 100
    
    var body: some View {
        VStack {
            Text("Paper Scissors Rock!")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            ForEach(0..<3) { number in
                Button(action: {
                    self.iconTapped(number)
                }, label: {
                    Image(systemName: imageNames[number])
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: imageFrame, height: imageFrame)
                        .foregroundColor(imageColors[number])
                        .padding()
                })
                
            }
            
            Text("Current score is: \(currentScore)")
                .font(.title3)
                .padding()
        }
        .alert(isPresented: $isShowingGameSetupAlert) {
            Alert(title: Text(titleText),
                  message: Text(messageText),
                  dismissButton: .default(Text(dismissText)) {

            })
        }

        /// sets up the popup at the start of the game
        .onAppear() {
            titleText = "New Game"
            messageText = "I've chosen \(possibleMoves[appCurrentChoice]), and you should \(playerShouldWin ? "win":"lose")"
            dismissText = "Lets Play"
        }
    }
    
    func iconTapped(_ number: Int) {
        moveCounter += 1
        
        var playerShouldChoose = playerShouldWin ? appCurrentChoice + 1 : appCurrentChoice - 1
        
        if playerShouldChoose < 0 {
            playerShouldChoose = 2
        }
        
        if playerShouldChoose > 2 {
            playerShouldChoose = 0
        }
        
        if number == playerShouldChoose {
            titleText = "Correct!"
            messageText = "That was the right one to choose!"
            currentScore += 1
        } else {
            titleText = "Incorrect!"
            messageText = "You chose \(possibleMoves[number]), but you should have chosen \(possibleMoves[playerShouldChoose])"
        }
        
        resetGame()
        
        messageText += "\n\nFor the next game, I've chosen \(possibleMoves[appCurrentChoice]), and you should \(playerShouldWin ? "win":"lose")"
        dismissText = "Continue"
        
        isShowingGameSetupAlert = true
    }
    
    func resetGame() {
        playerShouldWin = Bool.random()
        appCurrentChoice = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
