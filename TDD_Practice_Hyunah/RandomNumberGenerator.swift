//
//  RandomNumberGenerator.swift
//  TDD_Practice_Hyunah
//
//  Created by Hyunah on 2021/07/14.
//

import Foundation

class RandomNumberGenerator {
    private let range = 0...100
    
    func makeRandomNumber() -> Int {
        return Int.random(in: range)
    }
}
