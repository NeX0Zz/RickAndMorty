//
//  VIewModel.swift
//  RickAndMorty
//
//  Created by Денис Николаев on 16.10.2024.

protocol CharactersListViewModelProtocol {
    var characters: [RickAndMortyCharacter] { get }
    var isLoading: Bool { get set }
    var currentPage: Int { get set }
    var onCharactersUpdated: (() -> Void)? { get set }
    func fetchCharacters()
}

class CharactersListViewModel: CharactersListViewModelProtocol {
    var characters = [RickAndMortyCharacter]()
    var currentPage = 1
    var isLoading = false
    var apiService: APIServiceProtocol
    var onCharactersUpdated: (() -> Void)?
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    func fetchCharacters() {
        guard !isLoading else { return }
        isLoading = true
        apiService.fetchCharacters(page: currentPage) { [weak self] result in
            switch result {
            case .success(let response):
                self?.characters.append(contentsOf: response.results)
                self?.currentPage += 1
                self?.isLoading = false
                self?.onCharactersUpdated?()
            case .failure(let error):
                print("Error fetching characters: \(error)")
                self?.isLoading = false
            }
        }
    }
}
