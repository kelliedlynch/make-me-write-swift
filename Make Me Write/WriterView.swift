//
//  WriterView.swift
//  Make Me Write
//
//  Created by Kellie Lynch on 9/18/22.
//

import SwiftUI
import ConfettiSwiftUI

struct WriterView: View {
    @EnvironmentObject var sprint: SprintData
//    @StateObject var doc: WriterDocument = WriterDocument()
    @State private var prompt: String = "Write something or else."
    @State private var showPrompt: Bool = true
    // the value of fireConfetti is meaningless; ConfettiSwiftUI triggers every time this variable is changed.
    @State private var fireConfetti: Int = 0
    
    
    var body: some View {
        VStack {
            WriterStatusBar()
            ZStack(alignment: .topLeading) {
                if(showPrompt) {
                    TextEditor(text: $prompt)
                        .disabled(true)
                        .foregroundColor(.gray)
                        .padding()
                }
                TextEditor(text: $sprint.doc.text)
                    .onChange(of: sprint.doc.text) { _ in
                        if(!sprint.isRunning) {
                            sprint.isRunning = true
                            sprint.beginSprint()
                        }
                        if(sprint.isRunning) {
                            sprint.keystrokeRegistered()
                        }
                        if(showPrompt) {
                            showPrompt = false
                        }
                        if(sprint.doc.text == "" && showPrompt == false) {
                            showPrompt = true
                        }
                        if(sprint.goalIsReached && fireConfetti == 0) {
                            print("goalreached")
                            fireConfetti+=1
                        }
                    }
                    .padding()
                    .opacity(showPrompt ? 0.25 : 1.0)
//                    .scrollContentBackground(.hidden)
                    .background(
                        Color(sprint.isPunishing ? .red : .clear)
                            .animation(.easeIn(duration: sprint.isPunishing ? 2 : 0.5))
                    )
                    .confettiCannon(counter: $fireConfetti, num: 30, confettiSize: 8.0, rainHeight: 700.0, openingAngle: Angle(degrees: 40), closingAngle: Angle(degrees: 140), repetitions: 2, repetitionInterval: 0.15)

            }
            
        }
    }
}

struct WriterView_Previews: PreviewProvider {
    static var previews: some View {
        WriterView()
            .environmentObject(SprintData(timeInMinutes: 69, wordCountGoal: 4))
    }
}
