//
//  PokemonRepository.swift
//  perspective-coding-challenge
//
//  Created by Lukas Ruzicka on 10.01.2023.
//

import Foundation

protocol PokemonRepository {

    func getPokemons(offset: Int) async throws -> [Pokemon]
}

final actor PokemonRepositoryImpl {

    // MARK: - Properties
    private let networkingService: NetworkingService

    // MARK: - Init
    init(networkingService: NetworkingService = URLSessionNetworkingServiceImpl()) {
        self.networkingService = networkingService
    }
}

// MARK: - Protocol conformance
extension PokemonRepositoryImpl: PokemonRepository {

    func getPokemons(offset: Int) async throws -> [Pokemon] {
        // TODO: - Implement caching
        let listURL = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=10&offset=\(offset)")!
        let list: PokemonListResponseModel = try await networkingService.request(listURL)
        var pokemons: [Pokemon] = []
        for item in list.results {
            // TODO: - Optimize so user doesn't need to wait for loading details of all (-> AsyncSequence)
            let detail: PokemonDetailResponseModel = try await networkingService.request(item.url)
            let pokemon = Pokemon(id: detail.id,
                                  name: item.name,
                                  imageUrl: detail.sprites.front_default)
            pokemons.append(pokemon)
        }
        return pokemons
    }
}
