//
//  WriterStatusBar.swift
//  Make Me Write
//
//  Created by Kellie Lynch on 9/18/22.
//

import SwiftUI

struct WriterStatusBar: View {
    @EnvironmentObject var sprint: SprintData
    
//    @State private var timeRemaining: Int = 0
    
    let formatter = DateComponentsFormatter()
    
    var body: some View {
        HStack {
            Text("Goal:")
            Text("\(sprint.wordsRemaining)")
            Spacer()
            Text("Time:")
            Text(formatter.string(from: Double(sprint.secondsRemaining))!)
        }
        .padding()
    }
}

struct WriterStatusBar_Previews: PreviewProvider {
    static var previews: some View {
        WriterStatusBar()
            .environmentObject(SprintData(timeInMinutes: 69, wordCountGoal: 420))
    }
}
