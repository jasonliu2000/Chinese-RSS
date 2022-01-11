//
//  ArticleView.swift
//  RSS Reader
//
//  Created by Jason Liu on 1/10/22.
//

import SwiftUI

struct ArticleView: View {
    
    let url: String
    
    var body: some View {
        Text(url)
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(url: "google.com")
    }
}
