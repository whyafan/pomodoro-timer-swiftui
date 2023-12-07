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
    
    var body: some View {
        VStack (alignment: .center) {
                // Used to add the background
                Spacer()
                    Text("\(vm.time)")
                        .font(.system(size: 70, weight: .medium, design: .rounded))
                        .padding()
                        .frame(width: 1000, alignment: .center)
                        // Deliver an alert when the timer ends and set/use the showingAlert boolean value from the ViewModel
                        .alert("Timer completed!", isPresented: $vm.showingAlert) {
                            // Pops a button with the text with the role to cancel and perform nothing because a button is necessary
                            Button("Understood", role: .cancel) {}
                        }
            
            VStack (alignment: .center) {
                Text("Use the slider below to set the timer")
                Slider(value: $vm.minutes, in: 1...90, step: 1).padding([.leading, .trailing], 50).padding([.top, .bottom], 10).disabled(vm.isActive).animation(.easeInOut, value: vm.minutes)
                
                HStack (spacing: 50) {
                    Button("Start Timer") {
                        vm.start(minutes: vm.minutes)
                    }.disabled(vm.isActive)
                    
                    Button("Reset Timer") {
                        vm.reset()
                    }.tint(Color.red)
                    
                    Text("\(Date())")
                }
            }.padding([.top], 10)
            
                // Used to add the background
                Spacer()
                Spacer()
            
                // Sets the background and covers the edges too
        }.background(Color.black.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)).onReceive(timer) { _ in
            // The update() function that we defined in the ViewModel will get called every second here and update the UI
            vm.update()
        }
    }
}
