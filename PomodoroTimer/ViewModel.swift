//
//  ViewModel.swift
//  PomodoroTimer
//
//  Created by Afan Khan on 07/12/23.
//

import Foundation
import UserNotifications

extension ContentView {
    final class ViewModel: ObservableObject {
        // Whether the timer is active
        @Published var isActive = false
        
        // Whether it is showing an alert to the user
        @Published var showingAlert = false
        
        // Default time in String to display in the UI
        @Published var time: String = "25:00"
        
        // The dynamic default Timer in Float, which the user will modify through the slider, and this will update the string-based timer
        @Published var minutes: Float = 25.0 {
            didSet {
                self.time = "\(Int(minutes)):00"
            }
        }
        
        // Keeping track of the current time of the Application
        private var initialTime = 1
        private var endDate = Date()
        
        // Starts the timer with the given minutes
        func start(minutes: Float) {
            self.initialTime = Int(minutes);
            
            // Getting current date and time to subtract later
            self.endDate = Date()
            
            self.isActive = true
            
            // Adding the minutes gathered from the user to the current date and timer of the user
            self.endDate = Calendar.current.date(byAdding: .minute , value: Int(minutes), to: endDate)!
        }
        
        func reset() {
            // Reset to 0
            self.minutes = Float(initialTime)
            self.isActive = false
            self.time = "\(Int(minutes)):00"
        }
        
        func update() {
            guard isActive else { return }
            
            let now = Date()
            
            // Using the Epoch times to subtract the milliseconds between both dates from now to the initial endDate
            let diff = endDate.timeIntervalSince1970 - now.timeIntervalSince1970
            
            if diff <= 0 {
                self.isActive = false
                self.time = "0:00"
                self.showingAlert = true
            }
            
            /* Converting the data into a readable format for the user */
            
            // Takes the diff and puts them into the Epoch milliseconds format
            let date = Date(timeIntervalSince1970: diff)
            
            // Keep track of remaining minutes
            self.minutes = Float(minutes)
            
            /* Formatting time */
            
            func formatTime(date: Date) -> String {
                let formatter = DateFormatter()
                formatter.dateFormat = "mm:ss"
                formatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
                
                let formattedDate = formatter.string(from: date)
                
                return formattedDate
            }
            
            self.time = formatTime(date: date)
            
        }
    }
}
