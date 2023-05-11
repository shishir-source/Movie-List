//
//  RequestClient.swift.swift
//  MovieList
//
//  Created by Poka TM on 11/5/23.
//

import Foundation
import UIKit

class RequestClient {
    
    enum Endpoints {
        static let base = "https://api.themoviedb.org/3"
        static let imagePath = "https://image.tmdb.org/t/p/w500"
        static let apiKey = "38e61227f85671163c275f9bd95a8803"
        
        case getMovieList(param: String)
        var stringValue: String {
            switch self {
            case .getMovieList(let param):
                return Endpoints.base+"/search/movie?api_key=\(Endpoints.apiKey)&query=\(param)"
            }
        }
    }
    
    //MARK: -  API Get Request
    
    class func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }//task
        task.resume()
        
        return task
    }//taskForGETRequest
    
}
