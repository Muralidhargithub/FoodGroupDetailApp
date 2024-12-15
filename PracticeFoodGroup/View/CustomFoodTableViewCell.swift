import UIKit

class CustomFoodTableViewCell: UITableViewCell {
    
    
    private var viewModel = CustomFoodTableViewModel()
    static let identifier = "CustomFoodTableViewModel"
    
    // MARK: - UI Components
    private let label: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 16)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private var articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    private func setUp() {
        contentView.addSubview(articleImageView)
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            articleImageView.widthAnchor.constraint(equalToConstant: 100),
            articleImageView.heightAnchor.constraint(equalToConstant: 100),
            
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    
    
    
    //    // MARK: - Configuration
    //    func configure(from foodGroup: FoodGroup, viewModel: CustomFoodTableViewModel) {
    //        // Set the label text
    //        let text = """
    //        Name: \(foodGroup.name ?? "N/A")
    //        Description: \(foodGroup.description ?? "No Description")
    //        """
    //        label.text = text
    //
    //        // Fetch and set the image
    //        if let imageUrl = foodGroup.image_url {
    //            Task {
    //                if let image = await viewModel.fetchImageData(from: imageUrl) {
    //                    DispatchQueue.main.async {
    //                        self.articleImageView.image = image
    //                    }
    //                } else {
    //                    DispatchQueue.main.async {
    //                        self.articleImageView.image = UIImage(systemName: "photo")
    //                    }
    //                }
    //            }
    //        } else {
    //            self.articleImageView.image = UIImage(systemName: "photo")
    //        }
    //    }
    
    func configure(foodGroup: FoodGroup, viewModel: CustomFoodTableViewModel) {
        let text = """
        Name: \(foodGroup.name ?? "")
        Description: \(foodGroup.description ?? "")
"""
        label.text = text
        
        if let imageURL = foodGroup.image_url {
            Task{
                if let image = await viewModel.fetImage(url: imageURL){
                    DispatchQueue.main.async {
                        self.articleImageView.image = image
                    }
                }
                else{
                    DispatchQueue.main.async{
                        self.articleImageView.image = UIImage(systemName: "photo")
                    }
                }
            }
        }else{
            self.articleImageView.image = UIImage(systemName: "photo")
        }
        
    }
}
