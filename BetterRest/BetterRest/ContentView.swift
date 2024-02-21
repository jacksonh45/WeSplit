//BetterRest

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 0

    private var bedTime: Date? {
        get throws {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)

            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 3600 // convert to seconds
            let minute = (components.minute ?? 0) * 60 // convert to seconds

            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            return sleepTime
        }
    }
    private var alertTitle: String {
        let bedTime = try? bedTime
        return bedTime != nil ? "Your ideal bedtime is.." : "Error!!"
    }

    private var alertMessage: String {
        if let bedTime = try? bedTime {
            return bedTime.formatted(date: .omitted, time: .shortened)
        } else {
            return "Sorry, there was a problem calculating your bedtime."
        }
    }

    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 30

        return Calendar.current.date(from: components) ?? Date.now
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                } header: {
                    Text("When do you want to wake up?")
                        .font(.headline)
                }

                Section {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                } header: {
                    Text("Desired amount of Sleep")
                        .font(.headline)

                }

                Section {
                    Picker(coffeeAmount == 1 ? "1 Cup" : "\(coffeeAmount) cups", selection: $coffeeAmount) {
                        ForEach(0..<21, id: \.self) { number in
                            Text("\(number) \(number > 1 ? "Cups" : "Cup")")
                        }
                    }
                } header: {
                    Text("Daily Coffee intake")
                }

                HStack {
                    Spacer()
                    VStack(alignment: .center) {
                        Text(alertTitle)
                            .font(.headline)
                        Text("\(alertMessage)")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                    }
                    .padding()
                    Spacer()
                }
            }
            .navigationTitle("BetterRest")
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
