//
//  TrendingCard.swift
//  seentv
//
//  Created by Steven Tsan on 4/14/23.
//

import Foundation
import SwiftUI

struct TrendingCard: View {
    
    let trendingItem: Movie
    
    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: trendingItem.backdropURL) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 450, height: 250)
            } placeholder: {
                    Rectangle().fill(Color(red:114/255,green:137/255,blue:218/255))
                        .frame(width: 450, height: 150)
            }
            
            LazyVStack {
                HStack {
                    Text(trendingItem.title)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                    Spacer()
                    Image(systemName: "heart.fill")
                        .foregroundColor(.purple)
                }
                HStack {
                    Image(systemName: "hand.thumbsup.fill")
                    Text(String(format:"%.1f",trendingItem.vote_average))
                    Spacer()
                }
                .foregroundColor(.yellow)
                .fontWeight(.heavy)
            }
            .padding()
            
            // this is steven's blue
//            .background(Color(red:114/255,green:137/255,blue:218/255)) // color setting here
            
            // This is kendrick's purple ( i like this better)
            .background(Color(red: 186/255, green: 147/255, blue: 216/255))

            .cornerRadius(5)
            
        }
    }
}
