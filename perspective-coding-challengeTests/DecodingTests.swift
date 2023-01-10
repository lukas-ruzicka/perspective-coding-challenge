//
//  DecodingTests.swift
//  perspective-coding-challengeTests
//
//  Created by Lukas Ruzicka on 10.01.2023.
//

@testable import perspective_coding_challenge
import XCTest

final class DecodingTests: XCTestCase {

    func testListDecoding() throws {
        let jsonData = try XCTUnwrap(listResponse.data(using: .utf8))
        let responseModel = try JSONDecoder().decode(PokemonListResponseModel.self, from: jsonData)

        XCTAssertEqual(responseModel.count, 1154)
        XCTAssertEqual(responseModel.results.count, 10)
        XCTAssertEqual(responseModel.results[0].name, "bulbasaur")
        XCTAssertEqual(responseModel.results[0].url.absoluteString, "https://pokeapi.co/api/v2/pokemon/1/")
    }
}

private extension DecodingTests {

    var listResponse: String {
        """
        {
          "count": 1154,
          "next": "https://pokeapi.co/api/v2/pokemon?offset=10&limit=10",
          "previous": null,
          "results": [
            {
              "name": "bulbasaur",
              "url": "https://pokeapi.co/api/v2/pokemon/1/"
            },
            {
              "name": "ivysaur",
              "url": "https://pokeapi.co/api/v2/pokemon/2/"
            },
            {
              "name": "venusaur",
              "url": "https://pokeapi.co/api/v2/pokemon/3/"
            },
            {
              "name": "charmander",
              "url": "https://pokeapi.co/api/v2/pokemon/4/"
            },
            {
              "name": "charmeleon",
              "url": "https://pokeapi.co/api/v2/pokemon/5/"
            },
            {
              "name": "charizard",
              "url": "https://pokeapi.co/api/v2/pokemon/6/"
            },
            {
              "name": "squirtle",
              "url": "https://pokeapi.co/api/v2/pokemon/7/"
            },
            {
              "name": "wartortle",
              "url": "https://pokeapi.co/api/v2/pokemon/8/"
            },
            {
              "name": "blastoise",
              "url": "https://pokeapi.co/api/v2/pokemon/9/"
            },
            {
              "name": "caterpie",
              "url": "https://pokeapi.co/api/v2/pokemon/10/"
            }
          ]
        }
        """
    }
}
