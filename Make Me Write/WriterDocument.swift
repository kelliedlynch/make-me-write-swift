//
//  WriterDocument.swift
//  Make Me Write
//
//  Created by Kellie Lynch on 9/18/22.
//

import Foundation

class WriterDocument: ObservableObject {
    @Published var text: String = "" {
        didSet(newValue) {
            self.wordCount = countWords(text: newValue)
        }
    }
    @Published var wordCount: Int = 0
    
    private func countWords(text: String) -> Int {
        return text.split(separator: " ").count
    }
    
}
