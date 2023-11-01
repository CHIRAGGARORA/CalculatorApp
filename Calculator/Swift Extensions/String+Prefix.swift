//
//  String+Prefix.swift
//  Calculator
//
//  Created by chirag arora on 08/06/23.
//

import Foundation

extension String {
    
    mutating func addPrefixIfNeeded(_ prefix: String) {
        guard hasPrefix(prefix) == false else { return }
        
        self = prefix + self
                
    }
    
    mutating func removePrefixIfNeeded(_ prefix: String) {
        guard hasPrefix(prefix) == true else { return }
        
        
        self = replacingOccurrences(of: prefix, with: "")
    }
    
}
