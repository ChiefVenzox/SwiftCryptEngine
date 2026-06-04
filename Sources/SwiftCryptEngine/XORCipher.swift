import Foundation

/// XOR Cipher Implementation (Bitwise Operation)
public struct XORCipher {
    
    /// Encrypts or Decrypts a text using a string key via XOR.
    /// Since XOR is symmetric (A ^ B = C, C ^ B = A), the same function is used for both.
    /// - Parameters:
    ///   - text: The plain text or cipher text.
    ///   - key: The encryption key.
    /// - Returns: A base64 encoded string if encrypting, or decoded plain text if decrypting.
    /// Note: To make it safe to print in terminal, we return an array of UInt8 or Base64 string.
    
    public static func process(text: String, key: String) -> [UInt8] {
        let textBytes = Array(text.utf8)
        let keyBytes = Array(key.utf8)
        
        if keyBytes.isEmpty {
            return textBytes
        }
        
        var result = [UInt8]()
        for i in 0..<textBytes.count {
            let textByte = textBytes[i]
            let keyByte = keyBytes[i % keyBytes.count]
            result.append(textByte ^ keyByte)
        }
        
        return result
    }
    
    public static func encryptToBase64(_ text: String, key: String) -> String {
        let encryptedBytes = process(text: text, key: key)
        let data = Data(encryptedBytes)
        return data.base64EncodedString()
    }
    
    public static func decryptFromBase64(_ base64: String, key: String) -> String? {
        guard let data = Data(base64Encoded: base64) else { return nil }
        let encryptedBytes = Array(data)
        
        let keyBytes = Array(key.utf8)
        if keyBytes.isEmpty { return String(data: data, encoding: .utf8) }
        
        var result = [UInt8]()
        for i in 0..<encryptedBytes.count {
            result.append(encryptedBytes[i] ^ keyBytes[i % keyBytes.count])
        }
        
        return String(bytes: result, encoding: .utf8)
    }
}
