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
///     2-1. 멀티플레이어 모드일 경우 입력된 순서대로(플레이어 순서와 동일) 결과를 알려준다.
///     2-2. 멀티플레이어 수와 입력값의 수가 다르면 에러를 던진다.
///


/// 고민 : - validation check 까지 테스트코드를 작성해야하는 걸까?
///       - UI관련 & alert 문구까지 테스트를 해야하는가?
///

class RandomGameTests: XCTestCase {
    var sut = RandomGame(playMode: .single)
    var sutForMultiplayer = RandomGame(playMode: .multiple(["naver", "line", "kakao"]))
    
    func testRandomGame_checkNumber_whenNumberIsLowerThanGoal() {
        // given
        let guessNumber = 15
        sut.resetGoal(to: 23)
        // when
        let result = sut.checkNumber(guessNumber)
        
        // then
        XCTAssertEqual(result, .lower)
    }
    
    func testRandomGame_checkNumber_whenNumberIsHigherThanGoal() {
        // given
        let guessNumber = 33
        sut.resetGoal(to: 23)
        // when
        let result = sut.checkNumber(guessNumber)
        
        // then
        XCTAssertEqual(result, .higher)
    }
    
    func testRandomGame_checkNumber_whenNumberEqualGoal() {
        // given
        let guessNumber = 23
        sut.resetGoal(to: 23)
        // when
        let result = sut.checkNumber(guessNumber)
        
        // then
        XCTAssertEqual(result, .equal)
    }
    
    func testRandomGame_checkNumber_whenPlayModeIsMultiple() {
        // given
        let guessNumbers = [11, 98, 44]
        sutForMultiplayer.resetGoal(to: 44)
        // when
        let result = try? sutForMultiplayer.checkNumber(guessNumbers)
        
        // then
        XCTAssertEqual(result, [.lower, .higher, .equal])
    }
    
    func testRandomGame_checkNumber_whenPlayModeIsMultiple_allPlayerFail() {
        // given
        let guessNumbers = [23, 88, 66]
        sutForMultiplayer.resetGoal(to: 44)
        // when
        let result = try? sutForMultiplayer.checkNumber(guessNumbers)
        
        // then
        XCTAssertEqual(result, [.lower, .higher, .higher])
    }
    
    func testRandomGame_checkNumber_whenPlayModeIsMultiple_allPlayerPass() {
        // given
        let guessNumbers = [44, 44, 44]
        sutForMultiplayer.resetGoal(to: 44)
        // when
        let result = try? sutForMultiplayer.checkNumber(guessNumbers)
        
        // then
        XCTAssertEqual(result, [.equal, .equal, .equal])
    }
    
    func testRandomGame_playMode_multiple_whenNumberOfGuessIsSmallerThanNumberOfPlayer_shouldReturnError() {
        // given
        let guessNumbers = [11, 22]
        sutForMultiplayer.resetGoal(to: 44)
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
        sutForMultiplayer.resetGoal(to: 44)
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
