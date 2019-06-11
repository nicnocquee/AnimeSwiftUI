//
//  ContentView.swift
//  AnimeSwiftUI
//
//  Created by nico on 10.06.19.
//  Copyright © 2019 nico. All rights reserved.
//

import SwiftUI

struct AnimeList : View {
    @State var animes: [Anime] = []
    @State var isLoading: Bool = false
    @State var error: Error? = nil

    @State var networkFetcher: JSONNetworkFetcher<[Anime]>?
    
    var body: some View {
        NavigationView {
            VStack {
                if self.isLoading {
                    Text("Loading ...")
                } else {
                    self.error.map {
                        ViewBuilder.buildEither(first: ErrorView(
                            errorMessage: $0.localizedDescription,
                            onClick: {
                                self.networkFetcher?.fetch()
                            })
                        )
                    } ?? ViewBuilder.buildEither(second: List(animes.identified(by: \.mal_id)) { anime in
                        AnimeRow(anime: anime)
                    })
                }
            }
            .navigationBarItems(trailing: Button(action : { self.networkFetcher?.fetch() } ) { Text("Reload") })
            .navigationBarTitle(Text("Top Anime"))
        }
        .onAppear {
            if self.networkFetcher == nil {
                self.networkFetcher = JSONNetworkFetcher(
                    url: "https://api.jikan.moe/v3/top/anime/1/upcoming",
                    rootKey: "top",
                    isLoading: self.$isLoading,
                    responseData: self.$animes,
                    error: self.$error
                )
            }
            self.networkFetcher?.fetch()
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        AnimeList(animes: animeSampleData)
    }
}
#endif
