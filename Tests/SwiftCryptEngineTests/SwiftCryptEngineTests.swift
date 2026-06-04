import Testing
@testable import SwiftCryptEngine

@Suite("SwiftCryptEngine Algorithm Correctness Tests")
struct SwiftCryptEngineTests {

    @Test("Caesar Cipher - Basic Encryption and Decryption")
    func testCaesarCipher() {
        let originalText = "Hello World! Swift is awesome."
        let shift = 7
        
        let encrypted = CaesarCipher.encrypt(originalText, shift: shift)
        let decrypted = CaesarCipher.decrypt(encrypted, shift: shift)
        
        #expect(originalText == decrypted)
        #expect(originalText != encrypted)
    }

    @Test("Caesar Cipher - Boundary values (negative shift and large shift)")
    func testCaesarCipherBoundaries() {
        let originalText = "Swift"
        
        let encryptedLarge = CaesarCipher.encrypt(originalText, shift: 52) // 26 * 2 (should be no shift)
        let decryptedLarge = CaesarCipher.decrypt(encryptedLarge, shift: 52)
        #expect(originalText == encryptedLarge)
        #expect(originalText == decryptedLarge)
        
        let encryptedNegative = CaesarCipher.encrypt(originalText, shift: -3)
        let decryptedNegative = CaesarCipher.decrypt(encryptedNegative, shift: -3)
        #expect(originalText == decryptedNegative)
    }

    @Test("Vigenere Cipher - Encryption and Decryption")
    func testVigenereCipher() {
        let originalText = "Programming in Swift is fun!"
        let keyword = "KEYWORD"
        
        let encrypted = VigenereCipher.encrypt(originalText, keyword: keyword)
        let decrypted = VigenereCipher.decrypt(encrypted, keyword: keyword)
        
        #expect(originalText == decrypted)
        #expect(originalText != encrypted)
    }

    @Test("XOR Cipher - Encryption and Decryption (Base64)")
    func testXORCipher() {
        let originalText = "Super Secret Password 12345"
        let key = "MySecretKey"
        
        let encrypted = XORCipher.encryptToBase64(originalText, key: key)
        let decrypted = XORCipher.decryptFromBase64(encrypted, key: key)
        
        #expect(originalText == decrypted)
        #expect(originalText != encrypted)
    }

    @Test("Huffman Coding - Compression and Decompression")
    func testHuffmanCoding() {
        let originalText = "the quick brown fox jumps over the lazy dog"
        let huffman = HuffmanCoding()
        
        huffman.buildTree(from: originalText)
        let compressed = huffman.compress(originalText)
        let decompressed = huffman.decompress(compressed)
        
        #expect(originalText == decompressed)
        #expect(compressed.allSatisfy { $0 == "0" || $0 == "1" })
    }

    @Test("LZW - Compression and Decompression")
    func testLZW() {
        let originalText = "TOBEORNOTTOBEORTOBEORNOT"
        
        let compressed = LZW.compress(originalText)
        let decompressed = LZW.decompress(compressed)
        
        #expect(originalText == decompressed)
        #expect(compressed.count < originalText.count) // verify compression actually reduced size
    }
}
