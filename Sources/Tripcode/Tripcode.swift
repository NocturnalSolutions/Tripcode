import Foundation

/// Processed tripcode information extracted and hasheed from a string.
public struct Tripcode {
    /// The name fragment parsed from the original string.
    let name: String?
    // The hashed tripcode.
    let hash: String?
    // The secure tripcode hashed with the custom salt (not yet implemented)
    let secureHash: String?
}
