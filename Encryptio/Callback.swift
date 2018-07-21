//
//  Callback.swift
//  Encryptio
//
//  Created by Anum Qudsia on 21/07/2018.
//  Copyright © 2018 anum.qudsia. All rights reserved.
//

import Foundation

protocol Callback: NSObjectProtocol {
    
    func onOperationSuccess(_ message: String?)
    
    func onOperationFailed(_ error: Error)
}
