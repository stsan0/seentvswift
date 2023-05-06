//
//  ContentView.swift
//  seentv
//
//  Created by Steven Tsan and Kendrick Ngo on 4/6/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = MovieDiscoverViewModel()
    @State var searchText = ""
    var body: some View {
        NavigationStack{
            ScrollView {
                if searchText.isEmpty{
                    if viewModel.trending.isEmpty {
                        Text("No Results")
                    } else {
                        HStack{
                            Text("Trending")
                                .font(.title)
                                .foregroundColor(.white)
                                .fontWeight(.heavy)
                            Spacer()
                        }
                        .padding(.horizontal)
                        ScrollView(.horizontal, showsIndicators:false) {
                            HStack {
                                ForEach(viewModel.trending) { trendingItem in
                                    NavigationLink{
                                        MovieDetailView(movie: trendingItem)
                                    } label:{
                                    TrendingCard(trendingItem: trendingItem)
                                        
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                } else {
                    LazyVStack(){
                        ForEach(viewModel.searchResults){item in
                            HStack{
                                AsyncImage(url: item.backdropURL){
                                    image in image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 80, height: 120)
                                } placeholder: {
                                    ProgressView()
                                        .frame(width:80, height:120)
                                }
                                .clipped()
                                .cornerRadius(10)
                                
                                VStack(alignment:.leading) {
                                    Text(item.title)
                                        .foregroundColor(.white)
                                        .font(.headline)
                                    
                                    HStack {
                                        Image(systemName: "hand.thumbsup.fill")
                                        Text(String(format:"%.1f", item.vote_average))
                                        Spacer()
                                    }
                                    .foregroundColor(.white)
                                    .fontWeight(.heavy)
                                }
                                Spacer()
                            }
                            .padding(.horizontal)
                            .background(Color(red:114/255,green:137/255,blue:218/255))
                            .cornerRadius(20)
                            .padding(.horizontal)
                            
                        }
                    }
                    
                }
                
            }
            .background(Color(red: 39/255,green: 39/255, blue: 42/255)
                .ignoresSafeArea())
        }
        .searchable(text: $searchText)
        .onChange(of: searchText){newValue in
            if newValue.count > 2 {
                viewModel.search(term: newValue)
            }
        }
        .onAppear {
            viewModel.loadTrending()
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

 






