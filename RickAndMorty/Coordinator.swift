//
//  Coordinator.swift
//  RickAndMorty
//
//  Created by Денис Николаев on 16.10.2024.
//

import UIKit

protocol Coordinator {
    func start()
}

class AppCoordinator: Coordinator {
    private let navigationController: UINavigationController
    private let apiService: APIServiceProtocol

    init(navigationController: UINavigationController, apiService: APIServiceProtocol) {
        self.navigationController = navigationController
        self.apiService = apiService
    }

    func start() {
        let viewModel = CharactersListViewModel(apiService: apiService)
        let listVC = CharactersListViewController(viewModel: viewModel, coordinator: self)
        navigationController.pushViewController(listVC, animated: true)
    }

    func showCharacterDetail(character: RickAndMortyCharacter) {
        let detailVC = CharacterDetailViewController(character: character)
        navigationController.pushViewController(detailVC, animated: true)
    }
}
