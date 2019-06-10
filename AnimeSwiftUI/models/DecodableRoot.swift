//
//  DecodableRoot.swift
//  AnimeSwiftUI
//
//  Created by nico on 10.06.19.
//  Copyright © 2019 nico. All rights reserved.
//

// from https://gist.github.com/htinlinn/f8bf0abe4e438e33ba3127c8d79adf5f

import Foundation

extension JSONDecoder {
    
    func decode<T: Decodable>(_ type: T.Type, from data: Data, keyedBy key: String?) throws -> T {
        if let key = key {
            // Pass the top level key to the decoder.
            userInfo[.jsonDecoderRootKeyName] = key
            
            let root = try decode(DecodableRoot<T>.self, from: data)
            return root.value
        } else {
            return try decode(type, from: data)
        }
    }
    
}

extension CodingUserInfoKey {
    
    static let jsonDecoderRootKeyName = CodingUserInfoKey(rawValue: "rootKeyName")!
    
}

struct DecodableRoot<T>: Decodable where T: Decodable {
    
    private struct CodingKeys: CodingKey {
        
        var stringValue: String
        var intValue: Int?
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        init?(intValue: Int) {
            self.intValue = intValue
            stringValue = "\(intValue)"
        }
        
        static func key(named name: String) -> CodingKeys? {
            return CodingKeys(stringValue: name)
        }
        
    }
    
    let value: T
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        guard
            let keyName = decoder.userInfo[.jsonDecoderRootKeyName] as? String,
            let key = CodingKeys.key(named: keyName) else {
                throw DecodingError.valueNotFound(
                    T.self,
                    DecodingError.Context(codingPath: [], debugDescription: "Value not found at root level.")
                )
        }
        
        value = try container.decode(T.self, forKey: key)
    }
    
}
