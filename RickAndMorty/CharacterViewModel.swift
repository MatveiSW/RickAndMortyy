//
//  CharacterViewModel.swift
//  RickAndMorty
//
//  Created by Матвей Авдеев on 13.02.2025.
//

import UIKit

final class CharacterViewModel {
    static let shared = CharacterViewModel()
    
    private init() {}
    
    private(set) var characters: [Character] = []
    var onDataUpdate: (() -> Void)?
    private(set) var isLoading = false
    
    private var imageCache: [String: UIImage] = [:]
    
    func fetchCharacters() {
        isLoading = true
        
        NetworkManager.shared.fetchCharacters { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.isLoading = false
                
                switch result {
                case .success(let response):
                    self.characters = response.results
                    self.onDataUpdate?()
                case .failure(let error):
                    print("Error fetching characters: \(error)")
                }
            }
        }
    }
    
    func fetchImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = imageCache[urlString] {
            completion(cachedImage)
            return
        }
        
        NetworkManager.shared.fetchImage(from: urlString) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self?.imageCache[urlString] = image
                    completion(image)
                case .failure(let error):
                    print("Error loading image: \(error)")
                    completion(UIImage(systemName: "person.circle.fill"))
                }
            }
        }
    }
    
    func getCharactersCount() -> Int {
        characters.count
    }
    
    func getCharacter(at index: Int) -> Character? {
        guard index < characters.count else { return nil }
        return characters[index]
    }
}
