//
//  Tests.swift
//  S3R
//
//  Created by Anton Grachev on 21.06.2024.
//

import XCTest
@testable import s3r

final class Tests: XCTestCase {
    private var command: S3R!

    override func setUpWithError() throws {
        command = S3R()
    }

    func testSuccessScripts() throws {
        let path = Bundle.module.path(
            forResource: "success_scripts",
            ofType: ""
        )!
        
        command.path = path
        try command.run()
        
        XCTAssert(true)
    }
}
