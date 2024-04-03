//
//  CountdownView.swift
//  Countdown
//
//  Created by Priyanka Madaan on 2024-04-02.
//

import SwiftUI

struct CountdownView: View {
    @StateObject private var vm = ViewModel()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            
            Text("\(vm.time)").font(.system(size: 70, weight: .medium, design: .rounded)).padding().frame(width: 200).background(.thinMaterial).cornerRadius(20).overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 4))
            .alert("Timer Done", isPresented: $vm.showingAlert) {
                    Button("OK", role: .cancel){
                    
                    }
                }
            
            HStack(spacing: 50){
                Button ("Start"){
                    vm.start(seconds: vm.seconds)
                }
                .disabled(vm.isActive)
                
                Button("Reset", action: vm.reset).tint(.red)
            }.frame(width:200)
            
//            Slider(value: $vm.seconds, in: 1...10, step: 1).padding().frame(width:200).disabled(vm.isActive)
            
        }.onReceive(timer) { _ in
            vm.updateCountdown()
        }
    }
}

#Preview {
    CountdownView()
}

