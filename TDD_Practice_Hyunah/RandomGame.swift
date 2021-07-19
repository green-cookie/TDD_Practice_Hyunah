//
//  RandomGame.swift
//  TDD_Practice_Hyunah
//
//  Created by Hyunah on 2021/07/14.
//

import Foundation

class RandomGame {
    enum VerificationType {
        case higher
        case lower
        case equal
    }
    
    enum PlayMode {
        case single
        case multiple([String])
        
        var numberOfPlayer: Int {
            switch self {
            case .multiple(let players):
                return players.count
            case .single:
                return 1
            }
        }
    }
    
    enum RandomGameError: Error, Equatable {
        case incongruentNumberOfAnswer
    }
    
    private let randomNumberGenerator = RandomNumberGenerator()
    private var goalNumber: Int
    private var playMode: PlayMode
    
    init(playMode: PlayMode) {
        self.playMode = playMode
        self.goalNumber = randomNumberGenerator.makeRandomNumber()
    }
    
    func resetGoal(to newGoal: Int) {
        self.goalNumber = newGoal
    }
    
    func checkNumber(_ number: Int) -> VerificationType {
        let gap = number - goalNumber
        switch gap.signum() {
        case 1:
            return .higher
        case -1:
            return .lower
        default:
            return .equal
        }
    }
    
    func checkNumber(_ numbers: [Int]) throws -> [VerificationType] {
        guard numbers.count == playMode.numberOfPlayer else { throw RandomGameError.incongruentNumberOfAnswer }
        let gaps = numbers.map { ($0 - goalNumber).signum() }
        var results = [VerificationType]()
        
        gaps.forEach {
            switch $0 {
            case 1:
                results.append(.higher)
            case -1:
                results.append(.lower)
                return
            default:
                results.append(.equal)
            }
        }
        
        return results
    }
}
