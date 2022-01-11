//
//  ContentView.swift
//  RSS Reader
//
//  Created by Jason Liu on 1/10/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var xmlParser = XMLParserManager()
    
    var body: some View {
        NavigationView {
            List(xmlParser.articles, id: \.title) { article in
                NavigationLink(destination: ArticleView(url: article.url)) {
                    Text(article.title)
                }
            }
            .navigationBarTitle("Chinese RSS")
//            .refreshable {
//                await networkManager.fetchData()
//            }
        }
        .onAppear {
            xmlParser.loadArticles()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
