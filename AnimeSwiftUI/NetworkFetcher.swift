//
//  NetworkFetcher.swift
//  AnimeSwiftUI
//
//  Created by nico on 10.06.19.
//  Copyright © 2019 nico. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

enum DataError: Error {
    case emptyData
}

struct JSONNetworkFetcher<T: Codable> {
    
    var url: String = ""
    var rootKey: String = ""
    
    @Binding var isLoading: Bool
    @Binding var responseData: T
    @Binding var error: Error?
    
    func fetch() {
        let theURL = URL(string: self.url)
        self.isLoading = true
        
        let sessionConfig = URLSessionConfiguration.default
        //sessionConfig.timeoutIntervalForResource = 5 // set timeout 5 secods to test the error
        let session = URLSession(configuration: sessionConfig)
        
        session.dataTask(with: theURL!) { (data, response, error) in
            DispatchQueue.main.async {
                self.isLoading = false
                self.error = error
                
                guard let dat = data else {
                    self.error = DataError.emptyData
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let decoded = try decoder.decode(T.self, from: dat, keyedBy: self.rootKey)
                    self.responseData = decoded
                } catch let decodingError {
                    self.error = decodingError
                }
            }

            
        }.resume()
    }
}
