//
//  ErrorView.swift
//  AnimeSwiftUI
//
//  Created by nico on 11.06.19.
//  Copyright © 2019 nico. All rights reserved.
//

import SwiftUI

struct ErrorView: View  {
    var errorMessage: String
    var onClick: () -> Void
    
    var body: some View {
        VStack {
            Text(errorMessage)
            Button(action: onClick) {
                Text("Reload")
            }
        }
    }
}
