//
//  CryptoUtils.swift
//  Encryptio
//
//  Created by Anum Qudsia on 24/07/2018.
//  Copyright © 2018 anum.qudsia. All rights reserved.
//

import CommonCrypto

class CryptoUtils {
    
    static let HASH_SHA_1 = "sha1"
    static let HASH_SHA_256 = "sha256"
    let HASH_SHA_1 = "sha1"
    let HASH_SHA_256 = "sha256"
    let HASH_ALGORITHM = "sha256"
    let CRYPTO_ALGORITHM: CCAlgorithm = CCAlgorithm(kCCAlgorithmAES128)
    let KEY_SIZE: Int = kCCKeySizeAES256
    let BLOCK_SIZE: Int = kCCBlockSizeAES128
    let OPTIONS: CCOptions = CCOptions(kCCOptionPKCS7Padding)
    // MARK: -
    // MARK: Private constants
    static var keyBytes1: Data?
    static var keyBytes2: Data?
    static var keyBytes3: Data?
    static var iv1: Data?
    static var iv2: Data?
    static var iv3: Data?
    
    func encryptString(_ plainText: String, keyString key: String, ivString iv: String) -> String? {
        let keyData = key.data(using: String.Encoding.utf8) as Data?
        let ivData = iv.data(using: String.Encoding.utf8) as Data?
        return self.encryptString(plainText, keyData: keyData!, ivData: ivData!)
    }
    
    func encryptString(_ plainText: String, keyData: Data, ivData iv: Data) -> String {
        let plaindata: Data? = plainText.data(using: String.Encoding.utf8)
        let cipherdata: Data? = self.encrypt(plaindata!, keyData: keyData, ivData: iv)
        let cipherText = cipherdata?.base64EncodedString(options: [])
        return cipherText!
    }
    
    func encrypt(_ plainData: Data, keyData key: Data, ivData iv: Data) -> Data {
        return doCrypto(CCOperation(kCCEncrypt), data: plainData, key: key, iv: iv)
    }

    /**
     @brief The core cryptology method that performs the actual encryption/decryption.
     */
    
    func doCrypto(_ operation: CCOperation, data: Data, key: Data, iv: Data) -> Data {
        let hashedKey: Data? = CryptoUtils.createHash(key, withLength: KEY_SIZE, hashAlgorithm: HASH_SHA_256)
        let hashedIv32: Data? = CryptoUtils.createHash(iv, withLength: 32, hashAlgorithm: HASH_SHA_256)
        let bytes = [UInt8](hashedIv32!)
        let hashedIv = NSData(bytes: bytes, length: BLOCK_SIZE)
        // For block ciphers the output size will always be less than or equal to the input size plus the size of one block.
        // That's why we need to add the size of one block here.
        let dataOutSize = data.count + BLOCK_SIZE as? size_t
        let dataOut = malloc(dataOutSize!)
        var number = 0
        var dataOutMoved = UnsafeMutablePointer<Int>(&number)
        let cryptorStatus: CCCryptorStatus = CCCrypt(operation, CRYPTO_ALGORITHM, OPTIONS, [UInt8](hashedKey!), KEY_SIZE, hashedIv.bytes, [UInt8](data), data.count, dataOut, dataOutSize!, dataOutMoved)
        if cryptorStatus == kCCSuccess {
            // The returned NSData takes ownership of the dataOut buffer and will free it on deallocation.
            return NSData(bytesNoCopy: dataOut!, length: dataOutMoved.pointee) as Data
//            return Data(bytesNoCopy: dataOut!, length: dataOutMoved.pointee)
        }
        free(dataOut)
        // Free the dataOut buffer
    }

    class func createHash(_ data: Data, withLength length: Int, hashAlgorithm algorithm: String) -> Data {
        let newData = CryptoUtils.createData(data, withLength: length)
        if algorithm != nil {
            if (algorithm == HASH_SHA_1) {
                CC_SHA1(newData!.bytes, (length as? CC_LONG)!, $0)
            }
            else if (algorithm == HASH_SHA_256) {
                CC_SHA256(newData.bytes, (length as? CC_LONG), $0)
            }
            
            return Data(bytes: hash as? UnsafeRawPointer, length: MemoryLayout<hash>.size)
        }
        return Data(bytes: newData.bytes, length: length)
    }
    
    class func createData(_ data: Data?, withLength length: Int) -> Data? {
        var mutableData = Data()
        var copiedBytes: Int = 0
        while copiedBytes < length {
            let bytesToCopy = min((data?.count ?? 0), length - copiedBytes)
            mutableData.append(data?.bytes, length: bytesToCopy)
            copiedBytes += bytesToCopy
        }
        return Data(data: mutableData)
    }
    
    class func generateRandomInitializationVector(_ length: size_t) -> Data? {
        var data = Data(length: length)
        let output = SecRandomCopyBytes(kSecRandomDefault, length, data?.mutableBytes)
        assert(output == 0, "error generating random bytes: \(errno)")
        return data
    }


}

extension Data {
    func copyBytes<T>(as _: T.Type) -> [T] {
        return withUnsafeBytes { (bytes: UnsafePointer<T>) in
            Array(UnsafeBufferPointer(start: bytes, count: count / MemoryLayout<T>.stride))
        }
    }
}
