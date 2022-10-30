//
//  SprintData.swift
//  Make Me Write
//
//  Created by Kellie Lynch on 9/17/22.
//

import Foundation
import Combine

class SprintData: ObservableObject {
    // Some hard-coded settings that I'll probably want to allow the user to change
    private let gracePeriod: Int = 2
    
    @Published var doc: WriterDocument = WriterDocument()

    @Published var wordCountGoal: Int
    var wordsRemaining: Int {
        get {
            let remaining: Int = self.wordCountGoal - self.doc.wordCount
            return remaining
        }
    }
    
    var isRunning: Bool = false
    var isPunishing: Bool = false
    @Published var goalIsReached: Bool = false
    
    private var timer: Timer?
    private var lengthInSeconds: Int
    var lengthInMinutes: Int {
        // This value should only ever be set when setting the time in the settings screen.
        // Thus, it should always update secondsRemaining
        get {
            return Int(lengthInSeconds / 60)
        }
        set(newValue) {
            self.lengthInSeconds = newValue * 60
            self.secondsRemaining = self.lengthInSeconds
        }
    }
    
    @Published var secondsRemaining: Int {
        willSet(newValue) {
            if(newValue <= 0) {
                self.stopTimer()
                self.isRunning = false
                self.isPunishing = false
            }
        }
    }
    
    private var secondsIdle: Int = 0 {
        didSet(newValue) {
            if(self.isRunning) {
                if(newValue >= self.gracePeriod && self.isPunishing == false) {
                    self.isPunishing = true
                } else if (newValue < self.gracePeriod && self.isPunishing == true){
                    self.isPunishing = false
                }
            }
        }
    }
    
    
    convenience init(timeInMinutes: Int, wordCountGoal: Int) {
        self.init(timeInSeconds: timeInMinutes * 60, wordCountGoal: wordCountGoal)
    }
    
    init(timeInSeconds: Int, wordCountGoal: Int) {
        self.lengthInSeconds = timeInSeconds
        self.secondsRemaining = timeInSeconds
        self.wordCountGoal = wordCountGoal
    }
    
    @objc func fireTimer() {
        if(self.isRunning && self.secondsRemaining > 0) {
            self.secondsRemaining -= 1
            self.secondsIdle += 1
        }
    }
    
    func keystrokeRegistered() {
        if(self.secondsIdle > 0) {
            self.secondsIdle = 0
        }
        if(wordsRemaining <= 0 && self.goalIsReached == false) {
            self.goalIsReached = true
        }
    }
    
    func beginSprint() {
        self.startTimer(timeInSeconds: self.secondsRemaining)
        self.isRunning = true
    }
    
    func startTimer(timeInMinutes: Int) {
        self.startTimer(timeInSeconds: timeInMinutes * 60)
    }
    
    func startTimer(timeInSeconds: Int) {
//        self.lengthInMinutes = Int(timeInSeconds / 60)
        self.timer = Timer(timeInterval: 1, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        RunLoop.current.add(self.timer!, forMode: .common)
    }
    
    func stopTimer() {
        self.timer?.invalidate()
    }
}
