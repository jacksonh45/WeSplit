//
//  ContentView.swift
//  Challenge Day 1
//
//  Created by Jackson Harrison on 2/6/24.
//

import SwiftUI

struct ContentView: View {

    @State private var inputValue = "seconds" //Default display
    @State private var outputValue = "minutes" //Default display
    @State private var userInput: Double = 60

    @FocusState private var isFocused: Bool

   private let values = ["seconds", "minutes", "hours", "days", "years"] //Array of values in input and output

    private var inputConverted: Double {

        let finalInput: Double = userInput

        
        // Determines value times value (Ie: 1 minute is 60 seconds)
        switch inputValue {
        case "seconds":
            return finalInput
        case "minutes":
            return finalInput * 60
        case "hours":
            return finalInput * 3600
        case "days":
            return finalInput * 86400
        case "years":
            return finalInput * 31536000
        default:
            return finalInput
        }
    }

   private var outputConverted: Double {

        let finalOutput: Double = inputConverted

       
       // Determines value divided by value (Ie: 60 seconds is 1 minute)
        switch outputValue {
        case "seconds":
            return finalOutput
        case "minutes":
            return finalOutput / 60
        case "hours":
            return finalOutput / 3600
        case "days":
            return finalOutput / 86400
        case "years":
            return finalOutput / 31536000
        default:
            return finalOutput
        }

    }

    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("Input value", selection: $inputValue) {
                        ForEach(values, id: \.self){
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.menu) //Creates how you can select values for Input
                }header: {
                    Text("Select Input")
                }

                Section{ //Line breaks each item
                    Picker("Output value", selection: $outputValue) {
                        ForEach(values, id: \.self){
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.menu) //Creates how you can select output values
                }header: {
                    Text("Select Output")
                }

                
                // This will allow you to insert what value times what
                Section  {
                    TextField("Insert input value", value: $userInput, format: .number)
                        .keyboardType(.numberPad)
                        .focused($isFocused)
                    
                }header: {
                    Text("Insert input value")
                }

                
                //Displays result from Input value
                Section {
                    Text(outputConverted, format: .number)
                }header: {
                    Text("Result")
                }
            }
            .navigationTitle("Time Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done"){  //Allows mobile users to get rid of the keyboard
                        isFocused = false
                    }
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
