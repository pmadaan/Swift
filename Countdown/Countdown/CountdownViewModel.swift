//
//  CountdownViewModel.swift
//  Countdown
//
//  Created by Priyanka Madaan on 2024-04-02.
//

import Foundation

extension CountdownView{
    final class ViewModel: ObservableObject{
        @Published var isActive = false
        @Published var showingAlert = false
        @Published var time: String = "10"
        @Published var seconds: Int = 10{
            didSet {
                self.time = "\(seconds)"
            }
        }
        
        private var initialTime = 0
        private var endDate = Date()
        
        func start(seconds: Int){
            self.initialTime = seconds
            self.endDate = Date()
            self.isActive = true
            
            self.endDate = Calendar.current.date(byAdding: .second, value: seconds, to: endDate)!
        }
        
        func reset(){
            self.seconds = initialTime
            self.isActive = false
            self.time = "\(seconds)"
        }
        
        func updateCountdown(){
            guard isActive else {return}
            
            let now = Date()
            let diff = endDate.timeIntervalSince1970 - now.timeIntervalSince1970
            
            if diff <= 0{
                self.isActive = false
                self.showingAlert = true
                self.time = "0"
                return
            }
            
            let date = Date(timeIntervalSince1970: diff)
            let calendar = Calendar.current
            let seconds = calendar.component(.second, from: date)
            
            self.seconds = seconds
            self.time = String(seconds)
        }
    }
}
