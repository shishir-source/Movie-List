//
//  MovieViewModel.swift
//  MovieList
//
//  Created by Poka TM on 11/5/23.
//

import UIKit
import SwiftUI

protocol MovieViewModelProtocol{
    var movieList: [Movie] {get set}
    func getMovieList(searchText: String, completion: @escaping(_ status: Bool, _ message: String) -> Void)
}

class MovieViewModel: MovieViewModelProtocol, ObservableObject {
    
    @Published var movieList: [Movie] = []
    
    //MARK: - To get movie list
    func getMovieList(searchText: String, completion: @escaping (Bool, String) -> Void) {
        
        guard let url = URL(string: RequestClient.Endpoints.getMovieList(param: searchText).stringValue) else {
            completion(false, "Invalid Url")
            return
        }
        DispatchQueue.global(qos: .background).async {
            _ = RequestClient.taskForGETRequest(url: url, responseType: MovieResponse.self) { data , error in
                if error == nil {
                    guard let movies = data?.results else {
                        completion(false, "Movie data not found")
                        return
                    }
                    self.movieList = movies
                    completion(true, "Data Found.")
                }
                else{
                    completion(false, "Error found")
                }
            }
        }
        
    }//getMovieList
    
}
