//
//  FoodDetailTableViewCell.swift
//  PracticeFoodGroup
//
//  Created by Muralidhar reddy Kakanuru on 12/14/24.
//


import UIKit

class FoodDetailTableViewCell: UITableViewCell {
    
    static let identifier = "FoodDetailTableViewCell"
    let viewModel = CustomFoodTableViewModel()
    // MARK: - UI Components
    private let label: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 16)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    private func setUp() {
        contentView.addSubview(foodImageView)
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            foodImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            foodImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            foodImageView.widthAnchor.constraint(equalToConstant: 100),
            foodImageView.heightAnchor.constraint(equalToConstant: 100),
            
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
        // MARK: - Configure
    func configure(foodItem: FoodItem, viewModel: CustomFoodTableViewModel) {
            label.text = """
            Name: \(foodItem.name ?? "N/A")
            Description: \(foodItem.description ?? "No Description")
            Price: $\(foodItem.price ?? 0)
            Weight: \(foodItem.weight ?? 0)g
            """
    
            let imageUrl = foodItem.image_url
                Task {
                    if let image = await viewModel.fetImage(url: imageUrl) {
                        DispatchQueue.main.async {
                            self.foodImageView.image = image
                        }
                    }
                }
                foodImageView.image = UIImage(systemName: "photo")
        }
}
