import Foundation

/// Caesar Cipher Implementation
public struct CaesarCipher {
    /// Encrypts a text by shifting characters by a specified amount.
    /// - Parameters:
    ///   - text: The original string.
    ///   - shift: The integer shift value.
    /// - Returns: Encrypted string.
    public static func encrypt(_ text: String, shift: Int) -> String {
        return shiftCharacters(in: text, by: shift)
    }
    
    /// Decrypts a text by shifting characters backwards.
    /// - Parameters:
    ///   - text: The encrypted string.
    ///   - shift: The integer shift value used during encryption.
    /// - Returns: Decrypted string.
    public static func decrypt(_ text: String, shift: Int) -> String {
        return shiftCharacters(in: text, by: -shift)
    }
    
    private static func shiftCharacters(in text: String, by shift: Int) -> String {
        let normalizedShift = (shift % 26 + 26) % 26
        
        let scalars = text.unicodeScalars.map { scalar -> Unicode.Scalar in
            let value = scalar.value
            
            // Uppercase A-Z
            if value >= 65 && value <= 90 {
                let shifted = ((value - 65 + UInt32(normalizedShift)) % 26) + 65
                return Unicode.Scalar(shifted)!
            }
            // Lowercase a-z
            else if value >= 97 && value <= 122 {
                let shifted = ((value - 97 + UInt32(normalizedShift)) % 26) + 97
                return Unicode.Scalar(shifted)!
            }
            
            return scalar
        }
        
        return String(String.UnicodeScalarView(scalars))
    }
}

/// Vigenère Cipher Implementation
public struct VigenereCipher {
    /// Encrypts a text using a keyword.
    public static func encrypt(_ text: String, keyword: String) -> String {
        return process(text: text, keyword: keyword, encrypting: true)
    }
    
    /// Decrypts a text using a keyword.
    public static func decrypt(_ text: String, keyword: String) -> String {
        return process(text: text, keyword: keyword, encrypting: false)
    }
    
    private static func process(text: String, keyword: String, encrypting: Bool) -> String {
        let keywordScalars = Array(keyword.uppercased().unicodeScalars).filter { $0.value >= 65 && $0.value <= 90 }
        if keywordScalars.isEmpty { return text }
        
        var keywordIndex = 0
        let scalars = text.unicodeScalars.map { scalar -> Unicode.Scalar in
            let value = scalar.value
            let isUpper = value >= 65 && value <= 90
            let isLower = value >= 97 && value <= 122
            
            if isUpper || isLower {
                let base: UInt32 = isUpper ? 65 : 97
                let shift = keywordScalars[keywordIndex].value - 65
                let effectiveShift = encrypting ? Int(shift) : -Int(shift)
                
                let normalizedShift = (effectiveShift % 26 + 26) % 26
                let shifted = ((value - base + UInt32(normalizedShift)) % 26) + base
                
                keywordIndex = (keywordIndex + 1) % keywordScalars.count
                return Unicode.Scalar(shifted)!
            }
            return scalar
        }
        
        return String(String.UnicodeScalarView(scalars))
    }
}
