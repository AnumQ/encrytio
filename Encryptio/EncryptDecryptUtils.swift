//
//  EncryptDecryptUtils.swift
//  Encryptio
//
//  Created by Anum Qudsia on 21/07/2018.
//  Copyright © 2018 anum.qudsia. All rights reserved.
//

import Foundation
import RNCryptor

class EncryptDecryptUtils: NSObject {
    // MARK: -
    // MARK: Encryption and decryption methods
    /**
     @brief Encrypts the mKey using the specified PIN + device ID as encryption key and alias user ID as initialization vector, and sets the encrypted mKey in OtpGlobals.
     */
    
    class func encryptAndSetMkey(_ pin: String?) {
        let cryptoUtils = OtpCryptoUtils()
        let encryptedMkey = cryptoUtils.encryptString(OtpKeychainUtils.getMkey(), keyString: OtpDeviceUtils.getPinAndDeviceId(pin), ivString: KeychainUtils.getUserId())
        OtpGlobals.encryptedMkey = encryptedMkey
    }
    
    /**
     @brief Encrypts and stores the mKey using PIN + device ID as encryption key and alias user ID as initialization vector.
     Prerequisites:
     - There is no existing, stored, encrypted mKey
     - The new mKey has a value, i.e. mKey is not nil
     */
    class func encryptAndStoreMkey(_ pin: String?, mkey: String?) -> String? {
    }
    
    /**
     @brief Decrypts the stored mKey that is encrypted with the PIN and device ID as encryption key
     and the alias user ID as initialization vector.
     */
    class func decryptStoredMkey(_ pin: String?) -> String? {
    }
    
    /**
     @brief Re-encrypt the stored mKey using new PIN + device ID as encryption key and alias user ID as initialization vector.
     */
    class func reEncryptStoredMkey(_ oldPin: String?, newPin: String?) -> String? {
    }
    
    /**
     @brief Encrypts the specified plaintext using the specified PIN and device ID as ecryption key
     and the alias user ID as initialization vector.
     */
    class func encryptString(_ plainText: String?, pin: String?) -> String? {
    }
    
    /**
     @brief Decrypts the specified ciphertext using the specified PIN and device ID as encryption key
     and the alias user ID as initializaiton vector.
     */
    class func decryptString(_ cipherText: String?, pin: String?) -> String? {
    }
    
    /**
     @brief Encrypts the specified plaintext using the device ID as encryption key
     and the alias user ID as initialization vector.
     */
    class func encrypt(withDeviceId plainText: String?) -> String? {
    }
    
    /**
     @brief Decrypts the specified cipherText using the device ID as encryption key
     and the alias user ID as initialization vector.
     */
    class func decrypt(withDeviceId cipherText: String?) -> String? {
    }
    
    /**
     @brief Encrypts the specified plaintext using the mKey as encryption key
     and the alias user ID as initialization vector.
     */
    class func encrypt(withMkeyString plainText: String?, pin: String?) -> String? {
    }
}

