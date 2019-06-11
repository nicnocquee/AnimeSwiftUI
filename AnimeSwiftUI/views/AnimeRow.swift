//
//  AnimeRow.swift
//  AnimeSwiftUI
//
//  Created by nico on 10.06.19.
//  Copyright © 2019 nico. All rights reserved.
//

import SwiftUI
import RemoteImage

struct AnimeRow: View {
    var anime: Anime
    
    var body: some View {
        HStack {
            RemoteImage(imageURL: anime.image_url, defaultImage: UIImage(named: "default-anime-icon")!)
                .frame(width: 100, height: 100)
                .aspectRatio(contentMode: .fill)
                .cornerRadius(10)
                .clipped()
            VStack(alignment: .leading) {
                Text(anime.title).font(.headline).lineLimit(nil)
                Text(anime.type.rawValue).font(.subheadline)
            }
        }
    }
}

struct AnimeRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AnimeRow(anime: animeSampleData[0])
            AnimeRow(anime: animeSampleData[1])
            AnimeRow(anime: animeSampleData[2])
        }
    }
}
