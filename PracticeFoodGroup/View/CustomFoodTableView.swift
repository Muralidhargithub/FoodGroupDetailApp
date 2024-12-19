import UIKit

class CustomFoodTableViewController: UIViewController {
    // MARK: - Properties
    private let tableView = UITableView()
    private let viewModel = CustomFoodTableViewModel()
    weak var coordinator: AppCoordinator?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        fetchFoodData()
        navigationItem.title = "FoodCuisine"
    }

    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .white
        title = "Food Groups"
        
        // TableView setup
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomFoodTableViewCell.self, forCellReuseIdentifier: CustomFoodTableViewCell.identifier)
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

    private func setupBindings() {
            viewModel.fetchedFood = { [weak self] _ in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }


        // MARK: - Fetch Data
        private func fetchFoodData() {
            viewModel.fetchData()
        }
    }

    // MARK: - UITableViewDataSource & UITableViewDelegate
    extension CustomFoodTableViewController: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel.groupCount()
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomFoodTableViewCell.identifier, for: indexPath) as? CustomFoodTableViewCell else {
                fatalError("Failed to dequeue CustomFoodTableViewCell")
            }

            if let foodGroup = viewModel.foodGroupAt(at: indexPath.row) {
                cell.configure(foodGroup: foodGroup, viewModel: viewModel)
            }
            return cell
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 120
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                guard let selectedGroup = viewModel.foodGroupAt(at: indexPath.row) else { return }
                coordinator?.showDetailView(foodGroup: selectedGroup)
            AnalyticsManager.shared.logItemSelected(
                itemName: selectedGroup.name ?? "",
                                Description: "\(selectedGroup.description)"
                                
                            )
            }

    }

 
