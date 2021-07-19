//
//  RandomNumberGeneratorTests.swift
//  TDD_Practice_HyunahTests
//
//  Created by Hyunah on 2021/07/14.
//

import XCTest
@testable import TDD_Practice_Hyunah

/// RandomNumberGenerator Specs
/// 1. 난수생성
///    - 범위는 0-100 사이의 정수값을 생성한다.
///
class RandomNumberGeneratorTests: XCTestCase {
    let sut = RandomNumberGenerator()

    func testRandomNumberGenerator_whenNumberGenerated_numberIsWithInZoroToHundred() {
        // given
        let randomNumber = sut.makeRandomNumber()
        // when
        let result = (0...100).contains(randomNumber)
        // then
        XCTAssertTrue(result, "randomNumber should be in the range 0-100")
    }
}
