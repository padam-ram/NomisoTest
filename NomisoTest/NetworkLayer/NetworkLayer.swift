//
//  NetworkLayer.swift
//  NomisoTest
//
//  Created by sai sitaram on 28/04/25.
//

import Foundation

protocol APIService{
    func fetchRequest<T:Codable>(url:String,_ model:T.Type,compeltionHandler:@escaping(Result<T,Error>) -> ()) async
}

enum NetworkError:Error {
 
    case invalidUrl
    case networkError
    case deCodingError
    
}

class NetworkLayer:APIService {
 
    func fetchRequest<T>(url: String, _ model: T.Type, compeltionHandler: @escaping (Result<T, Error>) -> ()) async where T : Decodable, T : Encodable {
        
        guard let url = URL(string: url) else {
            compeltionHandler(.failure(NetworkError.invalidUrl))
            return
        }
        
        do{
            let (data,_) = try await URLSession.shared.data(from: url)
            let jsonDecodedModel = try JSONDecoder().decode(T.self, from: data)
            compeltionHandler(.success(jsonDecodedModel))
            
        }catch{
            compeltionHandler(.failure(NetworkError.deCodingError))
        }
    }
    
}
