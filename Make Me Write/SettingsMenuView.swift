//
//  SettingsMenuView.swift
//  Make Me Write
//
//  Created by Kellie Lynch on 9/17/22.
//

import SwiftUI
import Combine

struct SettingsMenuView: View {
    @EnvironmentObject var sprint: SprintData

    @State private var sprintTime: Int = 1
    
    var body: some View {
        Form {
            HStack {
                // TODO: tapping anywhere on this line should start editing
                Text("Word Count Goal:")
                // TODO: why doesn't spacer move number right?
                Spacer()
                // TODO: prevent non-number values from displaying
                TextField("Text", value: $sprint.wordCountGoal, format: .number)
                    .keyboardType(.numberPad)
            }
            HStack {
                Picker("Sprint Time", selection: $sprint.lengthInMinutes) {
                    ForEach(0..<60, id: \.self) {
                        Text("\($0)")
                    }
                }
                Text("minutes")
            }
            Text("Tertiary Option")
        }
    }
}

struct SettingsMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsMenuView()
            .environmentObject(SprintData(timeInMinutes: 9, wordCountGoal: 420))
    }
}
