//
//  NetworkManager.swift
//  RSS Reader
//
//  Created by Jason Liu on 1/10/22.
//

import Foundation

class XMLParserManager: NSObject, XMLParserDelegate, ObservableObject {
    
    @Published var articles = [Article]()
    
    // we take everything from the xml for each article just in case first
    var xmlDict = [String: Any]() // stores all data in an article
    var xmlDictArr = [[String: Any]]() // stores xmlDicts for every article
    var currentElement = ""
    
    
    // let elements = ["title", "link", "pubDate"]
    // var relevantInfo = false
    var articleTitle = ""
    var articleDate = ""
    var articleURL = ""
    
    func loadArticles() {
        // "https://feeds.bbci.co.uk/zhongwen/simp/rss.xml"
        // "http://www.people.com.cn/rss/politics.xml"
        let urlString = "http://www.people.com.cn/rss/politics.xml"
        if let url = URL(string: urlString) {
            if let parser = XMLParser(contentsOf: url) {
                parser.delegate = self
                parser.parse()
            } else {
                print("smth wrong with xml parser")
            }
        } else {
            print("couldn't find url")
        }
    }
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "item" {
            xmlDict = [:]
        } else {
            currentElement = elementName
        }
    }
    
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        // maybe considering doing "string.trimmingCharacters(in: .whitespacesAndNewlines)" when parsing other RSS feeds that don't have clean data
        if xmlDict[currentElement] == nil {
            xmlDict.updateValue(string, forKey: currentElement)
        }
    }
    
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            xmlDictArr.append(xmlDict) // just store it into master array of xmlDictArray that contains all the data on each article
            
            // stuff only relevant to us at the moment:
            articleTitle = xmlDict["title"] as! String
            articleDate = xmlDict["pubDate"] as! String
            articleURL = xmlDict["link"] as! String
            //DispatchQueue.main.async {
                self.articles.append(Article(title: self.articleTitle, date: self.articleDate, url: self.articleURL))
            //}
        }
    }
    
}
