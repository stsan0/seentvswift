//
//  MovieDetailView.swift
//  seentv
//
//  Created by Steven Tsan on 5/2/23.
//

import Foundation
import SwiftUI

struct MovieDetailView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var model = MovieDetailViewModel()
    
    let movie: Movie
    
    var body: some View {
        ZStack {
            Color(red:44/255,green:47/255,blue: 51/255).ignoresSafeArea()
            
            GeometryReader { geo in
                VStack {
                    AsyncImage(url: movie.backdropURL){
                        image in image
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: geo.size.width, maxHeight: 300)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    } placeholder: {
                        ProgressView()
                    }
                    Spacer()
                }
            }

            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 12){
                    Spacer()
                        .frame(height: 230)
                    HStack{
                        Text(movie.title)
                            .font(.title2)
                            .foregroundColor(.white)
                            .fontWeight(.heavy)
                        Spacer()
                        //rating
                    
                    }
                    HStack {
                        // genre
                        // running
                    }
                    HStack {
                        Text("Summary")
                            .font(.title3)
                            .foregroundColor(.white)
                            .fontWeight(.heavy)
                        Spacer()
                        // see all
                    }
                    Text(movie.overview)
                        .lineLimit(2)
                        .foregroundColor(.white)
                        Spacer()
                    
                    HStack {
                        Text("Cast/Crew")
                            .font(.title3)
//                            .foregroundColor((Color(red: 186/255, green: 147/255, blue: 216/255)))
                            .foregroundColor(.white)
                            .fontWeight(.heavy)
                        Spacer()
                        // see all
                    }
                    
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(model.castProfiles) { cast in
                                CastView(cast: cast)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .overlay(alignment: .topLeading) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .fontWeight(.bold)
            }
            .padding(.leading)
        }
        .toolbar(.hidden, for: .navigationBar)
        .onAppear() {
        }
        .task {
            await model.movieCredits(for: movie.id)
            await model.loadCastProfiles()
        }
    }
}

 struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: .preview)
    }
}


struct CastView: View {
   
    let cast: CastProfile
    
    
    var body: some View {
        VStack {
            AsyncImage(url: cast.photoUrl){ image in image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            } placeholder: {
                ProgressView()
                    .frame(width: 150, height: 200)
            }
            Text(cast.name)
                .lineLimit(1)
                .frame(width: 100)
        }
    }
}
