//
//  Model.swift
//  MovieV2
//
//  Created by Timur on 03.02.2021.
//

import Foundation


struct MoviesData: Decodable {
    let movies: [Movie]
    
     enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct Movie: Decodable {
    
    let title: String?
    let year: String?
    let rate: Double?
    let posterImage: String?
    let overview: String?
    
     enum CodingKeys: String, CodingKey {
        case title, overview
        case year = "release_date"
        case rate = "vote_average"
        case posterImage = "poster_path"
    }
}
