//
//  Coordinator.swift
//  PracticeFoodGroup
//
//  Created by Muralidhar reddy Kakanuru on 12/17/24.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let foodTableViewController = CustomFoodTableViewController()
        foodTableViewController.coordinator = self
        navigationController.pushViewController(foodTableViewController, animated: true)
    }

    func showDetailView(foodGroup: FoodGroup) {
        let detailVC = CustomFoodTableDetailViewController(foodItems: foodGroup.food_items, viewModel: CustomFoodTableViewModel())
        navigationController.pushViewController(detailVC, animated: true)
    }

}
