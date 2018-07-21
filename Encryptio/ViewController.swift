//
//  ViewController.swift
//  Encryptio
//
//  Created by Anum Qudsia on 21/07/2018.
//  Copyright © 2018 anum.qudsia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let message = "My message"
        
        let pass = "1111"
        guard let encryptionKey = try? EncryptDecryptUtils.generateEncryptionKey(withPassword: pass) else {
            return print("Unable to generate encryptionKey")
        }
        
        print("encryptionKey is \(encryptionKey)")
        
        guard let encrMessage = try? EncryptDecryptUtils.encryptMessage(message: message, encryptionKey: encryptionKey) else {
            return print("Unable to encrypt message")
        }
        print("")
        print("encrMessage is \(encrMessage)")
        
        
        guard let decrMessage = try? EncryptDecryptUtils.decryptMessage(encryptedMessage: encrMessage, encryptionKey: encryptionKey) else {
            return print("Unable to decryp message")
        }
        
        print("")<
        print("decrMessage is \(decrMessage)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

