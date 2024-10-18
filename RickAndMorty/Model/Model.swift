//
//  Model.swift
//  RickAndMorty
//
//  Created by Денис Николаев on 16.10.2024.
//

// MARK: - RickAndMortyCharacter

struct RickAndMortyCharacter: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: String
    let url: String
    let origin: Origin
}

struct Origin: Codable {
    let name: String
    let url: String
}

// MARK: - RickAndMortyAPIResponse

struct RickAndMortyAPIResponse: Codable {
    let info: Info
    let results: [RickAndMortyCharacter]
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
