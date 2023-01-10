//
//  CarouselViewModel.swift
//  perspective-coding-challenge
//
//  Created by Lukas Ruzicka on 10.01.2023.
//

import Foundation

final class CarouselViewModel {

    // MARK: - Properties
    private let repository: PokemonRepository

    private var pokemons: [Pokemon] = []
    private var allLoaded = false

    // MARK: - Init
    init(repository: PokemonRepository = PokemonRepositoryImpl()) {
        self.repository = repository
    }
}

// MARK: - Internal
extension CarouselViewModel {

    func loadData() async {
        do {
            pokemons = try await repository.getPokemons(offset: 0)
        } catch {
            // TODO: - Handle error
        }
    }

    func getPokemon(_ index: Int) -> Pokemon? {
        guard index >= 0 && index < pokemons.count else { return nil }
        if !allLoaded && index > pokemons.count - 3 {
            Task {
                let newPokemons = try await repository.getPokemons(offset: pokemons.count)
                pokemons.append(contentsOf: newPokemons)
                if newPokemons.count < 10 {
                    allLoaded = true
                }
            }
        }
        return pokemons[index]
    }
}
