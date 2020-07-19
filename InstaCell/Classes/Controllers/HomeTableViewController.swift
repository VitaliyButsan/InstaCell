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
        
        setNavBarTitle()
        registerTheCell()
        getPosts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.estimatedRowHeight = 600
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setNavBarTitle() {
        navigationItem.title = "Instagram"
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
        return cell
    }
}
