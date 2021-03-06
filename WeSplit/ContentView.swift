//  ContentView.swift
//  WeSplit
//
//  Created by Diogo Gaspar on 11/02/21.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0

        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    
    var totalCheckPlusTip: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let totalToPay = (orderAmount / 100 * tipSelection) + orderAmount
        
        return totalToPay
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount: ", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
//                    This is the challenge 3 resolution:
//                    TextField("Number of people (default: 2)", text: $numberOfPeople)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100){
                            Text("\($0)")
                        }
                    }
                }
                
                Section(header: Text("How much tip do you want to leave?")
                            .textCase(nil)) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount per people").textCase(nil)) {
                    Text("$ \(totalPerPerson, specifier: "%.2f")")
                }
                
                Section(header: Text("Total").textCase(nil) ) {
                    Text("$ \(totalCheckPlusTip, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


