//
//  JSONDecoder-Remote.swift
//  socialMediaSample
//
//  Created by Kinney Kare on 10/30/19.
//  Copyright © 2019 Kinney Kare. All rights reserved.
//

import Foundation

extension JSONDecoder {
    func decode<T: Decodable>(_ type: T.Type, fromURL url: String, completion: @escaping (T) -> Void ) {
        guard let url = URL(string: url) else {
            fatalError("Invalid URL passed.")
        }
        
        DispatchQueue.global().async {
                  do {
                      let data = try Data(contentsOf: url)
                    
                    let downloadedData = try self.decode(type, from: data)
                      
                      //now that we got the data we will push it the the main thread
                      DispatchQueue.main.async {
                        completion(downloadedData)
                        
                      }
                  } catch {
                      print(error.localizedDescription)
                  }
              }
        
    }
}
