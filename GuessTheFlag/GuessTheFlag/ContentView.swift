import SwiftUI

struct ContentView: View {

    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy","Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()

    @State private var correctAnswer = Int.random(in: 0...2)

    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State var score = 0
    @State var actualCountry = ""

    @State private var animationAmount = 0.0
    @State private var animation = false

    var body: some View {

        ZStack {

            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)

            VStack(spacing: 30){
                VStack {
                  Text("Tap the flag of")
                    .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.black)
                }

                ForEach(0 ..< 3) { number in
                    Button(action: {

                        withAnimation(.easeOut(duration: 0.5)) {

                             self.animation = true
                       }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                                                   self.flagTapped(number)

                                               }

                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)

                            .rotation3DEffect(.degrees(number == self.correctAnswer && self.animation ? 360 : 0.0), axis: (x: 0, y: 1, z: 0))
                            .opacity(number != self.correctAnswer && self.animation ? 1 : 1)

                    }

                }

                Spacer()
                Text("score: \(score)")
                .foregroundColor(.white)
                .font(.largeTitle)
                Text("no!! it was \(actualCountry)")
                    .foregroundColor(.white)
                    .font(.largeTitle)

                Spacer()

            }
        }

        .alert(isPresented: $showingScore){
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score) "), dismissButton: .default(Text("Continue")) {
                self.askQuestion()

                })
        }
    }

    func flagTapped(_ number: Int){
        if number == correctAnswer {
          scoreTitle = "Correct"
          score += 10

        }else{
          scoreTitle = "Wrong! this was \(countries[number])"
          score -= 10
          actualCountry = countries[number]

        }
        showingScore = true
    }

    func askQuestion(){
        animation = false
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)

    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
