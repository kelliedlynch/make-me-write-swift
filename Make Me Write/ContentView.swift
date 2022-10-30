//
//  ContentView.swift
//  Make Me Write
//
//  Created by Kellie Lynch on 9/15/22.
//

import SwiftUI


struct ContentView: View {
    @State var showMenu = false
    @StateObject var sprint = SprintData(timeInSeconds: 30, wordCountGoal: 10)
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation {
                            showMenu.toggle()
                        }
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .imageScale(.large)
                    }
                }
                .padding()
                ZStack(alignment: .leading) {
                    WriterView()
                        .offset(x: self.showMenu ? geometry.size.width/1.2 : 0)
                        .disabled(self.showMenu ? true : false)

                    if showMenu {
                        SettingsMenuView()
                            .frame(width: geometry.size.width/1.2, height: geometry.size.height)
                            .transition(.move(edge: .leading))
                    }
                }
            }
        }
        .environmentObject(sprint)
//        FileNavigatorView()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SprintData(timeInMinutes: 69, wordCountGoal: 420))
    }
}
