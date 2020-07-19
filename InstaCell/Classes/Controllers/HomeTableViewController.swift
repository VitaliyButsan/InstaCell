//
//  HomeViewController.swift
//  InstaCell
//
//  Created by Vitaliy on 17.06.2020.
//  Copyright © 2020 Vitaliy. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    let postsViewModel = InstaPostsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        registerTheCell()
        getPosts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.estimatedRowHeight = 600
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setupNavBar() {
        setupTitleLabel()
        setupNavigationItems()
    }
    
    private func setupTitleLabel() {
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        titleLabel.text = "Instagram"
        titleLabel.font = UIFont(name: "BonbonRegular", size: 26)
        navigationItem.titleView = titleLabel
    }
    
    private func setupNavigationItems() {
        guard let camera = UIImage(named: "camera") else { return }
        guard let plane = UIImage(named: "plane") else { return }
        let leftBarButton = UIBarButtonItem(image: camera, style: .plain, target: self, action: #selector(barButtonTap))
        let rightBarButton = UIBarButtonItem(image: plane, style: .plain, target: self, action: #selector(barButtonTap))
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarButton
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    @objc func barButtonTap() {
        print("Bar button tap tap tap...")
    }
    
    private func registerTheCell() {
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.cellID)
    }
    
    private func getPosts() {
        if postsViewModel.getPosts() {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } else {
            /// ERROR: Call Alert
        }
    }
}

// MARK: - Table veiw delegaet

extension HomeTableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 590
    }
}

// MARK: - Table view data source

extension HomeTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsViewModel.posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.cellID, for: indexPath) as! PostTableViewCell
        let instaPost = postsViewModel.posts[indexPath.row]
        cell.setupCell(withPost: instaPost)
        cell.postFollowersTextView.layoutIfNeeded()
        cell.selectionStyle = .none
        return cell
    }
}
