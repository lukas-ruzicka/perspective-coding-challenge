//
//  PokemonDetailResponseModel.swift
//  perspective-coding-challenge
//
//  Created by Lukas Ruzicka on 10.01.2023.
//

import Foundation

struct PokemonDetailResponseModel: Decodable {

    let id: Int
    let sprites: Sprites

    struct Sprites: Decodable {

        let front_default: URL
    }
}
