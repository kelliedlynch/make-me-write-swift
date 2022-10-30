//
//  FileNavigatorView.swift
//  Make Me Write
//
//  Created by Kellie Lynch on 9/22/22.
//

import SwiftUI

struct FileNavigatorView: View {
    let navigator = FileNavigator()
   
    var body: some View {
        VStack{
            Text("Files")
            ForEach(navigator.paths, id: \.self) { path in
                Text(path)
            }
        }
    }
}

struct FileNavigatorView_Previews: PreviewProvider {
    static var previews: some View {
        FileNavigatorView()
    }
}
