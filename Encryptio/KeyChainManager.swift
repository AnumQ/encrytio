//
//  KeyChainManager.swift
//  Encryptio
//
//  Created by Anum Qudsia on 24/07/2018.
//  Copyright © 2018 anum.qudsia. All rights reserved.
//

import Foundation

class KeyChainManager: NSObject {
    
    private var accessControlTouchId: NSArray = []
    
    let KEYCHAIN_PIN_ID = "MobileOTP_pin"
    let ENCRYPTED_PIN_ID = "MobileOTP_enc_pin"
    
    override init() {
        super.init()
        accessControlTouchId = [KEYCHAIN_PIN_ID, ENCRYPTED_PIN_ID]
        
    }
    
    func deleteAllItemsInKeyChain() {
        let secItemClasses:NSArray = [kSecClassGenericPassword, kSecClassInternetPassword, kSecClassCertificate, kSecClassKey, kSecClassIdentity]
        for secItemClass in secItemClasses {
            let spec = [kSecClass: secItemClass] as CFDictionary
            SecItemDelete(spec)
        }
        print("Deleted all items in Keychain")
    }
    
    //This method is only added for test purposes.
    func getAllItems() {
        var query = [
            kSecReturnAttributes : kCFBooleanTrue,
            kSecMatchLimit : kSecMatchLimitAll
            ] as [CFString : Any]
        
        let secItemClasses = [kSecClassGenericPassword, kSecClassInternetPassword, kSecClassCertificate, kSecClassKey, kSecClassIdentity]
        for secItemClass in secItemClasses {
            query[kSecClass] = secItemClass
            var result: CFTypeRef? = nil
            SecItemCopyMatching(query as CFDictionary, &result)
            if let aResult = result {
                print("\(aResult)")
            }
        }
    }
    
    func searchKeyChain(forItem identifier: String, service: String) -> String? {
        return searchKeyChain(forItem: identifier, service: service, authenticationPrompt: "")
    }
    
    func searchKeyChain(forItem identifier: String, service: String, authenticationPrompt prompt: String) -> String? {
        var query: [CFString : Any]
        //    From sparebank1-ios project
        //    if ([identifier isEqualToString:KEYCHAIN_PIN_ID] || [identifier isEqualToString:KEYCHAIN_ENCRYPTED_PIN_ID]) {
        //        NSLog(@"Trying to get fingerprint");
        //        query = @{
        //                  (__bridge id) kSecClass: (__bridge id) kSecClassGenericPassword,
        //                  (__bridge id) kSecAttrService: service,
        //                  (__bridge id) kSecAttrAccount: identifier,
        //                  (__bridge id) kSecReturnData: @YES,
        //                  (__bridge id) kSecUseOperationPrompt: prompt,
        //                  };
        //    } else {
        //        query = @{
        //                  (__bridge id) kSecClass: (__bridge id) kSecClassGenericPassword,
        //                  (__bridge id) kSecAttrAccount: identifier,
        //                  (__bridge id) kSecReturnData: @YES
        //                  };
        //    }
        
        if accessControlTouchId.contains(identifier) {
            query = [kSecClass: kSecClassGenericPassword, kSecAttrService: service, kSecAttrAccount: identifier, kSecReturnData: true, kSecUseOperationPrompt: prompt]
        }
        else {
            query = [kSecClass: kSecClassGenericPassword, kSecAttrAccount: identifier, kSecReturnData: true]
        }
        
        var dataTypeRef: CFTypeRef? = nil
        var value: String? = nil
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        if status == errSecSuccess {
            let result = dataTypeRef as? Data
            if let aResult = result {
                value = String(data: aResult, encoding: .utf8)
            }
        } else {
            print("SecItemCopyMatching status: \(Int(status))")
        }
        return value
    }
}
