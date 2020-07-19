//
//  InstagrammTabBarController.swift
//  InstaCell
//
//  Created by Vitaliy on 17.06.2020.
//  Copyright © 2020 Vitaliy. All rights reserved.
//

import UIKit

class InstagramTabBarController: UITabBarController {
    
    private let viewModel = InstaPostsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        let homeVC = UINavigationController(rootViewController: HomeTableViewController())
        let searchVC = UINavigationController(rootViewController: SearchViewController())
        let addVC = UINavigationController(rootViewController: AddViewController())
        let favoritesVC = UINavigationController(rootViewController: FavoritesViewController())
        let feedVC = UINavigationController(rootViewController: FeedViewController())
        
        homeVC.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        addVC.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 2)
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 3)
        feedVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 4)
        
        viewControllers = [homeVC, searchVC, addVC, favoritesVC, feedVC]
    }
}
