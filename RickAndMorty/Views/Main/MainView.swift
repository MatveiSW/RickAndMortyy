//
//  MainView.swift
//  RickAndMorty
//
//  Created by Матвей Авдеев on 13.02.2025.
//

import UIKit

class MainView: UIView {
    
    let characterIdentifier = "characterIdentifier"
    
    private(set) lazy var characterCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 120)
        layout.minimumLineSpacing = 24
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: characterIdentifier)
        return collection
    }() 
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .white
        addSubview(characterCollectionView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate(
            [
                characterCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
                characterCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
                characterCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
                characterCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
            ]
        )
    }
    
}
