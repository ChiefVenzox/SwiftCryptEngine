import Foundation

/// Lempel-Ziv-Welch (LZW) Compression Algorithm
public struct LZW {
    
    /// Compresses a string into an array of integer codes.
    public static func compress(_ uncompressed: String) -> [Int] {
        var dictionary = [String: Int]()
        for i in 0..<256 {
            dictionary[String(Character(UnicodeScalar(i)!))] = i
        }
        
        var w = ""
        var result = [Int]()
        var dictSize = 256
        
        for char in uncompressed {
            let wc = w + String(char)
            if dictionary[wc] != nil {
                w = wc
            } else {
                result.append(dictionary[w]!)
                dictionary[wc] = dictSize
                dictSize += 1
                w = String(char)
            }
        }
        
        if !w.isEmpty {
            result.append(dictionary[w]!)
        }
        
        return result
    }
    
    /// Decompresses an array of integer codes back to a string.
    public static func decompress(_ compressed: [Int]) -> String? {
        guard !compressed.isEmpty else { return "" }
        
        var dictionary = [Int: String]()
        for i in 0..<256 {
            dictionary[i] = String(Character(UnicodeScalar(i)!))
        }
        
        var dictSize = 256
        var mutableCompressed = compressed
        var w = dictionary[mutableCompressed.removeFirst()]!
        var result = w
        
        for k in mutableCompressed {
            let entry: String
            if let dictK = dictionary[k] {
                entry = dictK
            } else if k == dictSize {
                entry = w + String(w.first!)
            } else {
                return nil // Bad compressed data
            }
            
            result += entry
            dictionary[dictSize] = w + String(entry.first!)
            dictSize += 1
            w = entry
        }
        
        return result
    }
}
