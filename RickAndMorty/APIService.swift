//
//  Api.swift
//  RickAndMorty
//
//  Created by Денис Николаев on 16.10.2024.
//

import Alamofire

protocol APIServiceProtocol {
    func fetchCharacters(page: Int, completion: @escaping (Result<RickAndMortyAPIResponse, Error>) -> Void)
}

class APIService: APIServiceProtocol {
    func fetchCharacters(page: Int, completion: @escaping (Result<RickAndMortyAPIResponse, Error>) -> Void) {
        let url = "https://rickandmortyapi.com/api/character?page=\(page)"
        
        AF.request(url).validate().responseDecodable(of: RickAndMortyAPIResponse.self) { response in
            switch response.result {
            case .success(let decodedResponse):
                completion(.success(decodedResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
