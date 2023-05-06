//
//  TrendingItem.swift
//  seentv
//
//  Created by Steven Tsan on 4/14/23.
//

import Foundation

// trending methods in API
struct Movie: Identifiable, Decodable {
    let adult: Bool
    let id: Int
    let poster_path: String?
    let title: String
    let overview: String
    let vote_average: Float
    let backdrop_path: String?
    
    var backdropURL: URL? {
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w500")
        return baseURL?.appending(path: backdrop_path ?? "")
    }
    var postThumbnail: URL? {
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w100")
        return baseURL?.appending(path: poster_path ?? "")
    }
    var poster: URL? {
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w500")
        return baseURL?.appending(path: poster_path ?? "")
    }

    static var preview: Movie {
        return Movie(adult: false,
                     id: 71424,
                     poster_path: "https://image.tmdb.org/t/p/w300",
                     title: "saving private ryan",
                     overview: "demo",
                     vote_average: 5.5,
                     backdrop_path: "https://image.tmdb.org/t/p/w300")
    }

}
