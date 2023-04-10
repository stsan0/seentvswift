//
//  ContentView.swift
//  seentv
//
//  Created by Steven Tsan and Kendrick Ngo on 4/6/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = MovieDBViewModel()
    
    var body: some View {
        VStack {
            if viewModel.trending.isEmpty {
                Text("No Results")
            } else {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(viewModel.trending) { TrendingItem in
                            TrendingCard(trendingItem: trendingItem)
                        }
                    }
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.loadTrending()
        }
    }
}

struct TrendingCard: View {
    
    let trendingItem: TrendingItem
    
    var body: some View {
        ZStack {
//            AsyncImage(url: trendingItem.poster_path) { image in
//                image
//                    .resizable()
//                    .scaledToFill()
//            } placeholder: {
//                ProgressView()
//            }
            
            VStack {
                HStack {
                    Text(trendingItem.title)
                    Spacer()
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                }
                HStack {
                    Image(systemName: "hand.thumbsup.fill")
                        .foregroundColor(.yellow)
                    Text("\(trendingItem.vote_average)")
                    Spacer()
                }
            }
        }
    }
}



@MainActor
class MovieDBViewModel : ObservableObject {
    @Published var homeScreen: [TrendingItem] = []
    static let apiKey = "91b0dea6fc09258822bd56c6197f8690"
//    static let apiToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5MWIwZGVhNmZjMDkyNTg4MjJiZDU2YzYxOTdmODY5MCIsInN1YiI6IjY0MmU3M2EwMGQyZjUzMDBiNmNjMWI2MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.W89mNNZyYpEo93XLIu3FYqvBxF05JVEZmE-9P_MVs4s"
    
    enum TrendingState {
        case none
        case loading
        case error(message: String)
        case trendingItems([TrendingItem])
        
    }
    
    // https://api.themoviedb.org/3/movie/550?api_key=91b0dea6fc09258822bd56c6197f8690
    // https://api.themoviedb.org/3/trending/all/day?api_key=91b0dea6fc09258822bd56c6197f8690
    
    func loadTrending() {
        Task {
            let url = URL(string: "https://api.themoviedb.org/3/trending/all/day?api_key=\(MovieDBViewModel.apiKey)")!
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let trendingResults = try JSONDecoder().decode(TrendingResults.self, from: data)
                trending = trendingResults.results
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}


struct TrendingResults: Decodable {
    let page: Int
    let results: [TrendingItem]
    let total_pages: Int
    let total_results: Int
    }

// trending methods in API
struct TrendingItem: Decodable {
    let adult: Bool
    let id: Int
    let poster_path: String
    let title: String
    let vote_average: Float
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

 




//struct ContentView: View {
//    @State private var searchBar = ""
//    //@StateObject private var viewModel = ViewModel()
//    let tabBarImages = ["house", "play.circle.fill, bookmark.fill", "person.fill"]
//
//    var body: some View {
//        NavigationView {
//            VStack(alignment: .leading) {
//                HStack(spacing: 100) {
//                    Text("Category")
//                        .foregroundColor(.white)
//                    Text("See all >")
//                        .foregroundColor(.orange)
//                }
//
//                HStack(spacing: 40) {
//                    VStack {
//                        Text("😘")
//                            .font(.title)
//                            .padding(20)
//                            .background {
//                                Color("backGround")
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
    
    //    struct searchBar: View {
//        @State private var searchText: String = ""
//        
//        var body: some View {
//            HStack {
//                Image(systemName: "magnifyingglass")
//                TextField("Search for movies", text: $searchText
//                )
//            }
//        }
//    }

