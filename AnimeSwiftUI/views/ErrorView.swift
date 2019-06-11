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
        VStack(spacing: 20) {
            Text(errorMessage).multilineTextAlignment(.center).lineLimit(nil)
            Button(action: onClick) {
                Text("Reload")
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        Group() {
            ErrorView(errorMessage: "The connection timed out.", onClick: {})
            ErrorView(errorMessage: "This error message is very long. The connection timed out.", onClick: {})
        }
    }
}
