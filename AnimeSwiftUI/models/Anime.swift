//
//  anime.swift
//  AnimeSwiftUI
//
//  Created by nico on 10.06.19.
//  Copyright © 2019 nico. All rights reserved.
//

import Foundation

enum AnimeType: String, CaseIterable, Codable, Hashable {
    case TV
    case Movie
    case OVA
    case ONA
    case Unknown
}

struct Anime: Hashable, Codable {
    let mal_id: Int
    let rank: Int
    let title: String
    let url: String
    let image_url: String
    let type: AnimeType
}
