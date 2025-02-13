//
//  ViewController.swift
//  RickAndMorty
//
//  Created by Матвей Авдеев on 13.02.2025.
//

import UIKit

class MainViewController: UIViewController {
    
    private lazy var mainView = MainView()
    
    private var characters: [Character]?
    
    override func loadView() {
        super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        getCharacters()
    }
    
    private func setup() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Characters"
        
        mainView.characterCollectionView.delegate = self
        mainView.characterCollectionView.dataSource = self
    }
    
    private func getCharacters() {
        CharacterViewModel.shared.fetchCharacters()
        CharacterViewModel.shared.onDataUpdate = { [weak self] in
            self?.characters = CharacterViewModel.shared.characters
            self?.mainView.characterCollectionView.reloadData()
        }
    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mainView.characterIdentifier, for: indexPath) as? CharacterCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(character: characters?[indexPath.row])
        
        return cell
    }
    
    
}

