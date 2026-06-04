import Foundation

@main
struct SwiftCryptEngine {
    static func main() {
        setbuf(stdout, nil)
        print("=======================================")
        print("  🔒 Welcome to SwiftCryptEngine 🗜️  ")
        print("=======================================")
        
        while true {
            print("\nPlease select an algorithm to demonstrate:")
            print("1. Caesar Cipher (Cryptography)")
            print("2. Vigenère Cipher (Cryptography)")
            print("3. XOR Cipher (Cryptography)")
            print("4. Huffman Coding (Compression)")
            print("5. LZW Compression (Compression)")
            print("0. Exit")
            print("> ", terminator: "")
            
            guard let choice = readLine(), let option = Int(choice) else {
                print("Invalid input. Please try again.")
                continue
            }
            
            if option == 0 {
                print("Exiting SwiftCryptEngine. Goodbye!")
                break
            }
            
            print("\nEnter the text you want to process:")
            print("> ", terminator: "")
            guard let text = readLine(), !text.isEmpty else {
                print("Text cannot be empty.")
                continue
            }
            
            switch option {
            case 1:
                demoCaesar(text: text)
            case 2:
                demoVigenere(text: text)
            case 3:
                demoXOR(text: text)
            case 4:
                demoHuffman(text: text)
            case 5:
                demoLZW(text: text)
            default:
                print("Invalid option selected.")
            }
        }
    }
    
    static func demoCaesar(text: String) {
        print("\n--- Caesar Cipher ---")
        let shift = 3
        print("Original Text: \(text)")
        print("Shift Value: \(shift)")
        let encrypted = CaesarCipher.encrypt(text, shift: shift)
        print("Encrypted: \(encrypted)")
        let decrypted = CaesarCipher.decrypt(encrypted, shift: shift)
        print("Decrypted: \(decrypted)")
        print("---------------------")
    }
    
    static func demoVigenere(text: String) {
        print("\n--- Vigenère Cipher ---")
        let keyword = "SWIFT"
        print("Original Text: \(text)")
        print("Keyword: \(keyword)")
        let encrypted = VigenereCipher.encrypt(text, keyword: keyword)
        print("Encrypted: \(encrypted)")
        let decrypted = VigenereCipher.decrypt(encrypted, keyword: keyword)
        print("Decrypted: \(decrypted)")
        print("-----------------------")
    }
    
    static func demoXOR(text: String) {
        print("\n--- XOR Cipher ---")
        let key = "SECRET"
        print("Original Text: \(text)")
        print("Key: \(key)")
        let encrypted = XORCipher.encryptToBase64(text, key: key)
        print("Encrypted (Base64): \(encrypted)")
        if let decrypted = XORCipher.decryptFromBase64(encrypted, key: key) {
            print("Decrypted: \(decrypted)")
        } else {
            print("Decryption failed.")
        }
        print("------------------")
    }
    
    static func demoHuffman(text: String) {
        print("\n--- Huffman Coding ---")
        let huffman = HuffmanCoding()
        print("Original Text: \(text)")
        
        // Before compressing, we must build the tree
        huffman.buildTree(from: text)
        let compressed = huffman.compress(text)
        print("Compressed (Binary String): \(compressed)")
        
        let decompressed = huffman.decompress(compressed)
        print("Decompressed: \(decompressed)")
        print("----------------------")
    }
    
    static func demoLZW(text: String) {
        print("\n--- LZW Compression ---")
        print("Original Text: \(text)")
        let compressed = LZW.compress(text)
        print("Compressed (Int Array): \(compressed)")
        if let decompressed = LZW.decompress(compressed) {
            print("Decompressed: \(decompressed)")
        } else {
            print("Decompression failed.")
        }
        print("-----------------------")
    }
}
