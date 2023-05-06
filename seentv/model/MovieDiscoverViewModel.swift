//
//  MovieDBViewModel.swift
//  seentv
//
//  Created by Steven Tsan on 4/14/23.
//

import Foundation
import SwiftUI


@MainActor
class MovieDiscoverViewModel : ObservableObject {
    @Published var trending: [Movie] = []
    @Published var searchResults: [Movie] = []
    static let apiKey = "91b0dea6fc09258822bd56c6197f8690"
//    static let apiToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5MWIwZGVhNmZjMDkyNTg4MjJiZDU2YzYxOTdmODY5MCIsInN1YiI6IjY0MmU3M2EwMGQyZjUzMDBiNmNjMWI2MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.W89mNNZyYpEo93XLIu3FYqvBxF05JVEZmE-9P_MVs4s"
    
    enum TrendingState {
        case none
        case loading
        case error(message: String)
        case trendingItems([Movie])
        
    }
    
//     https://api.themoviedb.org/3/movie/550?api_key=91b0dea6fc09258822bd56c6197f8690
//     https://api.themoviedb.org/3/trending/all/day?api_key=91b0dea6fc09258822bd56c6197f8690
    
    func loadTrending() {
        Task {
            let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(MovieDiscoverViewModel.apiKey)")!
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let trendingResults = try JSONDecoder().decode(TrendingResults.self, from: data)
                trending = trendingResults.results
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func search(term: String) {
        Task {
            let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(MovieDiscoverViewModel.apiKey)&language=en-US&page=1&include_adult=false&query=\(term)".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!)!
                
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let trendingResults = try JSONDecoder().decode(TrendingResults.self, from: data)
                searchResults = trendingResults.results
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    

}


@MainActor
class MovieDetailViewModel: ObservableObject {
    
    @Published var credits: MovieCredits?
    @Published var cast: [MovieCredits.Cast] = []
    @Published var castProfiles: [CastProfile] = []
    
    func movieCredits(for movieID: Int) async {
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/credits?api_key=\(MovieDiscoverViewModel.apiKey)&language=en-US")!
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let credits = try JSONDecoder().decode(MovieCredits.self, from: data)
                self.credits = credits
                self.cast = credits.cast.sorted(by: { $0.order < $1.order })
            } catch {
                print(error.localizedDescription)
            }
    }
    func loadCastProfiles() async{
        do{
            for member in cast {
                let url = URL (string:
                                "https://api.themoviedb.org/3/person/\(member.id)?api_key=\(MovieDiscoverViewModel.apiKey)&language=en-US")!
                let (data, _) = try await URLSession.shared.data(from:url)
                let profile = try JSONDecoder().decode(CastProfile.self, from: data)
                castProfiles.append(profile)
            }
        }
        catch{
            print(error.localizedDescription)
        }
    }
}

struct CastProfile: Decodable, Identifiable {
    let birthday: String
    let id: Int
    let name: String
    let profile_path: String?
    
    var photoUrl: URL? {
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w200")
        return baseURL?.appending(path:profile_path ?? "")
    }
}

struct MovieCredits: Decodable {
    let id: Int
    let cast: [Cast]
     
    struct Cast: Decodable, Identifiable {
        let name: String
        let id: Int
        let character: String
        let order: Int
        
    }
}
