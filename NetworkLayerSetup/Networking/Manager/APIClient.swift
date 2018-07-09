//
//  APIClient.swift
//  NetworkLayerSetup
//
//  Created by Sayalee on 7/9/18.
//  Copyright © 2018 Assignment. All rights reserved.
//

import Foundation

// Code for generic API calling and decoding of response

protocol APIClient {
    var session: URLSession { get }
    func callAPI<T: Decodable> (with request: URLRequest, decode: @escaping (Decodable) -> T?,
                              completion: @escaping (Result<T, APIError>) -> Void)
}

extension APIClient {
    typealias jsonTaskCompletionHandler = (Decodable?, APIError?) -> Void
    
    private func decodingTask<T: Decodable> (with request: URLRequest, decodingType: T.Type, completion: @escaping jsonTaskCompletionHandler) -> URLSessionDataTask {
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let genericModel = try JSONDecoder().decode(decodingType, from: data)
                        completion(genericModel, nil)
                    } catch {
                        completion(nil, .jsonConversionFailure)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful)
            }
        }
        return task
    }
    
    func callAPI<T: Decodable> (with request: URLRequest, decode: @escaping (Decodable) -> T?,
                              completion: @escaping (Result<T, APIError>) -> Void) {
        let task = decodingTask(with: request, decodingType: T.self) { (json, error) in
            
            // Switch to main queue
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(Result.failure(error))
                    } else {
                        completion(Result.failure(.invalidData))
                    }
                    return
                }
                
                if let value = decode(json) {
                    completion(Result.success(value))
                } else {
                    completion(Result.failure(.jsonParsingFailure))
                }
            }
        }
        task.resume()
    }
}
