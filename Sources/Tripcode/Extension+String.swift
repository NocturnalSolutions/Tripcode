import Foundation

extension String {
    /// Extracts and processes tripcode information from a string.
    ///
    /// - returns: `Tripcode`
    public func tripcode() throws -> Tripcode {
        guard let hashIndex = self.range(of: "#") else {
            return Tripcode(name: self, hash: nil, secureHash: nil)
        }
        let toEncode = String(self[hashIndex.upperBound...])
        // Convert to ShiftJIS
        guard let sjisData = toEncode.data(using: .shiftJIS) else {
            throw TripcodeError.conversionFailed
        }
        var saltPrep = sjisData
        if sjisData.count < 3 {
            // Append "H.." ShiftJIS-encoded
            saltPrep.append(Data(bytes: [72, 46, 46]))
        }
        let salt = Data(bytes: saltPrep.subdata(in: Range(1..<3)).map { char -> UInt8 in
            // https://en.wikipedia.org/wiki/Shift_JIS#Shift_JIS_byte_map
            switch char {
            // Replace characters not between . and z with .
            case ..<0x2E, 0x7A...:
                return 0x2E
                // Replace characters between : and @ with the character 7 positions
            // later
            case 0x3A...0x40:
                return char + 7
            // Same for chars between [ and ` - 6 positions later
            case 0x5B...0x60:
                return char + 6
            default:
                return char
            }
        })

        let crypted = crypt(sjisData.withUnsafeBytes(UnsafePointer<Int8>.init), salt.withUnsafeBytes(UnsafePointer<Int8>.init))!
        let cryptedString = String(cString: crypted).dropFirst(3)


        return Tripcode(name: String(self[..<hashIndex.lowerBound]), hash: String(cryptedString), secureHash: nil)
    }

    /// Extracts and processes tripcode information and returns a formatted string.
    ///
    /// - returns: `String?` of a name, trip hash, and secure trip hash formatted
    ///   in the standard way ("Name!TripHash!SecureTripHash"). Will be nil if the
    ///   original string was empty (anonymous).
    public func appliedTripcode() throws -> String? {
        let tripcode: Tripcode
        do {
            tripcode = try self.tripcode()
        }
        catch {
            throw error
        }
        if tripcode.secureHash  == nil {
            if tripcode.hash == nil {
                return tripcode.name
            }
            else {
                return "\(tripcode.name ?? "")!\(tripcode.hash ?? "")"
            }
        }
        return "\(tripcode.name ?? "")!\(tripcode.hash ?? "")!\(tripcode.secureHash ?? "")"

    }
}
