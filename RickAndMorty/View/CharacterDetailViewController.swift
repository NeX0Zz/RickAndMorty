//
//  CharacterDetailViewController.swift
//  RickAndMorty
//
//  Created by Денис Николаев on 16.10.2024.
//

import UIKit
import AlamofireImage
import SnapKit

final class CharacterDetailViewController: UIViewController {
    
    private let character: RickAndMortyCharacter
    private var speciesLabel = UILabel()
    private var genderLabel = UILabel()
    private var characterImageView = UIImageView()
    private var statusLabel = UILabel()
    private var locationLabel = UILabel()
    private var typeLabel = UILabel()
    
    init(character: RickAndMortyCharacter) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = character.name
        setup()
        configureView()
    }
    
    func setup() {
        [speciesLabel, genderLabel, characterImageView, statusLabel, locationLabel, typeLabel].forEach {
            view.addSubview($0)
        }
        
        characterImageView.layer.cornerRadius = 105
        characterImageView.clipsToBounds = true
       
        characterImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(32)
            make.width.height.equalTo(210)
        }

        genderLabel.snp.makeConstraints { make in
            make.centerX.equalTo(characterImageView)
            make.top.equalTo(characterImageView.snp.bottom).offset(8)
        }
        
        speciesLabel.snp.makeConstraints { make in
            make.centerX.equalTo(genderLabel)
            make.top.equalTo(genderLabel.snp.bottom).offset(8)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.centerX.equalTo(speciesLabel)
            make.top.equalTo(speciesLabel.snp.bottom).offset(8)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.centerX.equalTo(statusLabel)
            make.top.equalTo(statusLabel.snp.bottom).offset(8)
        }
        
        typeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(locationLabel)
            make.top.equalTo(locationLabel.snp.bottom).offset(8)
        }
    }
    
    private func configureView() {
        speciesLabel.text = "Species: \(character.species)"
        genderLabel.text = "Gender: \(character.gender)"
        statusLabel.text = "Status: \(character.status)"
        locationLabel.text = "Location: \(character.origin.name)"
        typeLabel.text = character.type.isEmpty ? "Type: -" : "Type: \(character.type)"
        
        if let url = URL(string: character.image) {
            characterImageView.af.setImage(withURL: url)
        } else {
            characterImageView.image = UIImage(systemName: "person.fill")
        }
    }
}
