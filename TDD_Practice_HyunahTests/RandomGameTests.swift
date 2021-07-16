//
//  RandomGameTests.swift
//  TDD_Practice_HyunahTests
//
//  Created by Hyunah on 2021/07/13.
//

import XCTest
@testable import TDD_Practice_Hyunah
///
/// RandomGame Specs
/// 1. 숫자를 넣으면 정답보다 높은지 낮은지 맞는지 알려줘야한다.
/// 2. 싱글플레이와 멀티플레이를 지원한다
///     2-1. 멀티플레이면 두 플레이어가 번갈아가면서 입력을 한다.
///


/// 고민 : - validation check 까지 테스트코드를 작성해야하는 걸까?
///       -
///

class RandomGameTests: XCTestCase {
    var sut = RandomGame(playMode: .single)
    var sutForMultiplayer = RandomGame(playMode: .multiple(["naver", "line", "kakao"]))
    
    override func setUp() {
        super.setUp()
        sut.resetGoal(to: 23)
        sutForMultiplayer.resetGoal(to: 44)
    }
    
    func testRandomGame_checkNumber_whenNumberIsLowerThanGoal() {
        // given
        let guessNumber = 15
        
        // when
        let result = sut.checkNumber(guessNumber)
        
        // then
        XCTAssertEqual(result, .lower)
    }
    
    func testRandomGame_checkNumber_whenNumberIsHigherThanGoal() {
        // given
        let guessNumber = 33
        
        // when
        let result = sut.checkNumber(guessNumber)
        
        // then
        XCTAssertEqual(result, .higher)
    }
    
    func testRandomGame_checkNumber_whenNumberEqualGoal() {
        // given
        let guessNumber = 23
        
        // when
        let result = sut.checkNumber(guessNumber)
        
        // then
        XCTAssertEqual(result, .equal)
    }
    
    func testRandomGame_checkNumber_whenPlayModeIsMultiple() {
        // given
        let guessNumbers = [11, 98, 44]
        // when
        let result = try? sutForMultiplayer.checkNumber(guessNumbers)
        
        // then
        XCTAssertEqual(result, [.lower, .higher, .equal])
    }
    
    func testRandomGame_checkNumber_whenPlayModeIsMultiple_allPlayerFail() {
        // given
        let guessNumbers = [23, 88, 66]
        // when
        let result = try? sutForMultiplayer.checkNumber(guessNumbers)
        
        // then
        XCTAssertEqual(result, [.lower, .higher, .higher])
    }
    
    func testRandomGame_checkNumber_whenPlayModeIsMultiple_allPlayerPass() {
        // given
        let guessNumbers = [44, 44, 44]
        // when
        let result = try? sutForMultiplayer.checkNumber(guessNumbers)
        
        // then
        XCTAssertEqual(result, [.equal, .equal, .equal])
    }
    
    func testRandomGame_playMode_multiple_whenNumberOfGuessIsSmallerThanNumberOfPlayer_shouldReturnError() {
        // given
        let guessNumbers = [11, 22]
        var thrownError: Error?
        
        // when
        XCTAssertThrowsError(try sutForMultiplayer.checkNumber(guessNumbers),
                             "this method should return RandomGameError when guess number is not equal to number of player") {
            thrownError = $0
        }
        // then
        XCTAssertTrue(thrownError is RandomGame.RandomGameError, "unexpected error: \(type(of: thrownError))")
        XCTAssertEqual(thrownError as? RandomGame.RandomGameError, .incongruentNumberOfAnswer)
    }
    
    func testRandomGame_playMode_multiple_whenNumberOfGuessIsLargerThanNumberOfPlayer_shouldReturnError() {
        // given
        let guessNumbers = [11, 22, 33, 55, 66]
        var thrownError: Error?
        
        // when
        XCTAssertThrowsError(try sutForMultiplayer.checkNumber(guessNumbers),
                             "this method should return RandomGameError when guess number is not equal to number of player") {
            thrownError = $0
        }
        // then
        
        // verify that the error is of the right type
        XCTAssertTrue(thrownError is RandomGame.RandomGameError, "unexpected error: \(type(of: thrownError))")
        
        // Verify that our error is equal to what we expect
        XCTAssertEqual(thrownError as? RandomGame.RandomGameError, .incongruentNumberOfAnswer)
    }
}
