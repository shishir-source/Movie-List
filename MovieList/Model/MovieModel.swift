//
//  MovieModel.swift
//  MovieList
//
//  Created by Poka TM on 11/5/23.
//

import UIKit

//MARK: - MovieResponse
struct MovieResponse: Codable {
    
    var page: Int
    var results: [Movie]
    var totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    init() {
        self.page = 0
        self.results = []
        self.totalPages = 0
        self.totalResults = 0
    }
    
}

// MARK: - Movie Model
struct Movie: Codable {
    
    var adult: Bool
    var backdropPath: String?
    var genreIDS: [Int]
    var id: Int
    var originalLanguage: String
    var originalTitle, overview: String
    var popularity: Double
    var posterPath, releaseDate, title: String
    var video: Bool
    var voteAverage: Double
    var voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    init() {
        self.adult = false
        self.backdropPath = ""
        self.genreIDS = []
        self.id = 0
        self.originalLanguage = ""
        self.originalTitle = ""
        self.overview = ""
        self.popularity = 0.0
        self.posterPath = ""
        self.releaseDate = ""
        self.title = ""
        self.video = false
        self.voteAverage = 0.0
        self.voteCount = 0
    }
    
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.adult = try container.decodeIfPresent(Bool.self, forKey: .adult) ?? false
            self.backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath) ?? ""
            self.genreIDS = try container.decodeIfPresent([Int].self, forKey: .genreIDS) ?? []
            self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
            self.originalLanguage = try container.decodeIfPresent(String.self, forKey: .originalLanguage) ?? ""
            self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
            self.originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle) ?? ""
            self.overview = try container.decodeIfPresent(String.self, forKey: .overview) ?? ""
            self.popularity = try container.decodeIfPresent(Double.self, forKey: .popularity) ?? 0.0
            self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath) ?? ""
            self.releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate) ?? ""
            self.video = try container.decodeIfPresent(Bool.self, forKey: .video) ?? false
            self.voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage) ?? 0.0
            self.voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount) ?? 0
        }
    }
}
