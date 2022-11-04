//
//  GitHub.swift
//  GithubSearch
//
//  Created by yongwoo on 2022/11/04.
//

// MARK: - Github
struct Github: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [Item]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}

// MARK: - Item
struct Item: Codable {
    let url: String
    let title: String
}
