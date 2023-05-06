//
//  TrendingResults.swift
//  seentv
//
//  Created by Steven Tsan on 4/14/23.
//

import Foundation

struct TrendingResults: Decodable {
    let page: Int
    let results: [Movie]
    let total_pages: Int
    let total_results: Int
    }
