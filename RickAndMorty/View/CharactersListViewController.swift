//
//  CharactersListViewController.swift
//  RickAndMorty
//
//  Created by Денис Николаев on 16.10.2024.

import UIKit
import AlamofireImage
import SnapKit

final class CharactersListViewController: UIViewController {
    
    private var viewModel: CharactersListViewModelProtocol
    private var coordinator: AppCoordinator
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CharacterCell.self, forCellReuseIdentifier: "CharacterCell")
        return tableView
    }()
    
    init(viewModel: CharactersListViewModelProtocol, coordinator: AppCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        bindViewModel()
        viewModel.fetchCharacters()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func bindViewModel() {
        viewModel.onCharactersUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

extension CharactersListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CharacterCell", for: indexPath) as? CharacterCell else {
            return UITableViewCell()
        }
        
        let character = viewModel.characters[indexPath.row]
        cell.titleLabel.text = character.name
        cell.gender.text = character.gender
        
        if let url = URL(string: character.image) {
            cell.image.af.setImage(withURL: url, placeholderImage: UIImage(systemName: "person.fill"))
        } else {
            cell.image.image = UIImage(systemName: "person.fill")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = viewModel.characters[indexPath.row]
        coordinator.showCharacterDetail(character: character)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - frameHeight {
            viewModel.fetchCharacters()
        }
    }
}
