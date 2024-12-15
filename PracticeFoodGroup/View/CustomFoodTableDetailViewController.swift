import UIKit

class CustomFoodTableDetailViewController: UIViewController {
    // MARK: - Properties
    private let tableView = UITableView()
    private let viewModel: CustomFoodTableViewModel
    private let foodItems: [FoodItem]

    // MARK: - Initializer
    init(foodItems: [FoodItem], viewModel: CustomFoodTableViewModel) {
        self.foodItems = foodItems
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .white
        title = "Food Items"
        
        // TableView setup
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FoodDetailTableViewCell.self, forCellReuseIdentifier: FoodDetailTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension CustomFoodTableDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FoodDetailTableViewCell.identifier, for: indexPath) as? FoodDetailTableViewCell else {
            fatalError("Failed to dequeue FoodDetailTableViewCell")
        }

        let foodItem = foodItems[indexPath.row]
        cell.configure(foodItem: foodItem, viewModel: viewModel)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedItem = foodItems[indexPath.row]
        
    }
}
