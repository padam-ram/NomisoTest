//
//  MoviesModel.swift
//  NomisoTest
//
//  Created by sai sitaram on 28/04/25.
//

import Foundation

struct MoviesModel:Codable,Hashable{
    let title : String?
    let year : String?
    let runtime : String?
    let poster : String?

    enum CodingKeys: String, CodingKey {

        case title = "Title"
        case year = "Year"
        case runtime = "Runtime"
        case poster = "Poster"
        
    }
    
    init(title: String?, runtime: String?,year:String?,poster:String) {
        
        self.title = title
        self.year = year
        self.runtime = runtime
        self.poster = poster
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        year = try values.decodeIfPresent(String.self, forKey: .year)
        runtime = try values.decodeIfPresent(String.self, forKey: .runtime)
        poster = try values.decodeIfPresent(String.self, forKey: .poster)
    }

}
