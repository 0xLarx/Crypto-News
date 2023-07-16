//
//  myDatas.swift
//  Crypto News
//
//  Created by Sametcan Taşgıran on 15.06.2023.
//

import Foundation


struct PostResponse: Codable {
    let data: [Post]
}

struct Post: Codable, Identifiable {
    var id: String { title ?? "" }
    let news_url: String?
    let image_url: String?
    let title: String?
    let source_name: String?
    let date: String?
    let sentiment: String?
    let type: String?
    let tickers: [String]?
}
