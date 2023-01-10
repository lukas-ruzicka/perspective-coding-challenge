//
//  PokemonListResponseModel.swift
//  perspective-coding-challenge
//
//  Created by Lukas Ruzicka on 10.01.2023.
//

import Foundation

struct PokemonListResponseModel: Decodable {

    let count: Int
    let results: [Item]

    struct Item: Decodable {

        let name: String
        let url: URL
    }
}
