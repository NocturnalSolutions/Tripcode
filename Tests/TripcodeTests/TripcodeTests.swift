import XCTest
@testable import Tripcode

final class TripcodeTests: XCTestCase {
    func tests() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(try? "Wiki#S~3hsEQ|".appliedTripcode(), "Wiki!PedIa.Dbk.")
        XCTAssertEqual(try? "#kaFDllhH28".appliedTripcode(), "!PartyxEgDA")
        XCTAssertEqual(try? "asdf#Sfx9cpp3w'".appliedTripcode(), "asdf!PartyihihQ")
        XCTAssertEqual(try? "Noct#{\\oc0xWGNQ".appliedTripcode(), "Noct!urnalhjR/k")
        XCTAssertEqual(try? "No code".appliedTripcode(), "No code")
    }


    static var allTests = [
        ("tests", tests),
    ]
}
