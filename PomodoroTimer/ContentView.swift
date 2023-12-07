//
//  ContentView.swift
//  PomodoroTimer
//
//  Created by Afan Khan on 07/12/23.
//

import SwiftUI

struct ContentView: View {
    // Initialising the Observable Object
    @StateObject private var vm = ViewModel()
    
    // Every 1 second, on Main Thread, in common, and automatically run it | This updates the UI every second
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // For the UI
    private var width: Double = 250
    
    var body: some View {
        VStack {
            // Used to add the background
            Spacer()
            HStack(alignment: .center, content: {
                Text("\(vm.time)")
                    .font(.system(size: 70, weight: .medium, design: .rounded))
                    .padding()
                    .frame(width: width)
                    // Deliver an alert when the timer ends and set/use the showingAlert boolean value from the ViewModel
                    .alert("Timer completed!", isPresented: $vm.showingAlert) {
                        // Pops a button with the text with the role to cancel and perform nothing because a button is necessary
                        Button("Understood", role: .cancel) {}
                    }
                // Used to add the background
                Spacer()
            }).onReceive(timer) { _ in
                // The update() function that we defined in the ViewModel will get called every second here and update the UI
                vm.update()
            }
            // Used to add the background
            Spacer()
            // Sets the background and covers the edges too
        }.background(Color.black.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
    }
}
