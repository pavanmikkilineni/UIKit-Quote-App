//
//  NetworkManager.swift
//  UIKit-Quote-App
//
//  Created by Pavan Mikkilineni on 08/12/21.
//

import Foundation



class NetWorkManager{
    
    static let shared=NetWorkManager()
    private let session:URLSession!
    
    init(){
        let config=URLSessionConfiguration.default
        session=URLSession(configuration: config)
    }
    
    func getQuote(completionHandler: @escaping (Result<Quote,NetworkError>)->Void){
        guard let url = URL(string:Constants.BASE_API_URL) else{
            completionHandler(.failure(.invalidURL))
            return
        }
        
        let task=session.dataTask(with: url){(data:Data?,response:URLResponse?,error:Error?) in
            
            if let error=error{
                completionHandler(.failure(.unableToFecth))
                return
            }
            
            guard let httpResponse=response as? HTTPURLResponse else{
                completionHandler(.failure(.unableToFecth))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else{
                completionHandler(.failure(.unableToFecth))
                return
            }
            
            guard let data=data else{
                completionHandler(.failure(.unableToFecth))
                return
            }
            
            do{
                let quotes = try JSONDecoder().decode(Quotes.self, from:data)
                let quote:Quote=quotes.quotes[0]
                
                completionHandler(.success(quote))
                
            }catch{
                completionHandler(.failure(.unableToFecth))
            }
            
            
        }
        task.resume()
    }
}
