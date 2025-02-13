//
//  CharacterCollectionViewCell.swift
//  RickAndMorty
//
//  Created by Матвей Авдеев on 13.02.2025.
//

import UIKit

final class CharacterCollectionViewCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 40
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 21)
        label.textColor = .black
        return label
    }()
    
    private lazy var raceAndGenderLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private lazy var locationImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = .location
        image.heightAnchor.constraint(equalToConstant: 12).isActive = true
        image.widthAnchor.constraint(equalTo: image.heightAnchor).isActive = true
        return image
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private lazy var locationStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [locationImage, locationLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 6
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var statusLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        return label
    }()
    
    private lazy var watchEpisodesButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        var configuration = UIButton.Configuration.plain()
        configuration.imagePadding = 4
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12)
        
        let playImage = UIImage(systemName: "play.fill")?
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 8))
            .withTintColor(.systemOrange, renderingMode: .alwaysOriginal)
        
        configuration.image = playImage
        configuration.title = "Watch episodes"
        configuration.baseForegroundColor = .systemOrange
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = .systemFont(ofSize: 14)
            return outgoing
        }
        
        button.configuration = configuration
        button.backgroundColor = .systemOrange.withAlphaComponent(0.1)
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var topStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, raceAndGenderLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 3
        stack.axis = .vertical
        stack.alignment = .leading
        return stack
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [watchEpisodesButton, locationStackView])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 8
        stack.axis = .vertical
        stack.alignment = .leading
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 16
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(character: Character?) {
        guard let character else { return }
        nameLabel.text = character.name
        raceAndGenderLabel.text = "\(character.species), \(character.gender)"
        locationLabel.text = character.location.name
        statusLabel.text = character.status.uppercased()
        
        switch character.status.lowercased() {
        case "alive":
            statusLabel.backgroundColor = .systemGreen.withAlphaComponent(0.2)
            statusLabel.textColor = .systemGreen
            imageView.alpha = 1
        case "dead":
            statusLabel.backgroundColor = .systemRed.withAlphaComponent(0.2)
            statusLabel.textColor = .systemRed
            imageView.alpha = 0.5
        default:
            statusLabel.backgroundColor = .systemGray.withAlphaComponent(0.2)
            statusLabel.textColor = .systemGray
            imageView.alpha = 1
        }
        
        CharacterViewModel.shared.fetchImage(from: character.image) { [weak self] image in
            self?.imageView.image = image
        }
    }
    
    private func setupViews() {
        contentView.addSubview(imageView)
        contentView.addSubview(topStackView)
        contentView.addSubview(bottomStackView)
        contentView.addSubview(statusLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            
            topStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            topStackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            topStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            statusLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: statusLabel.leadingAnchor, constant: -8),
            
            bottomStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            bottomStackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            bottomStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}
