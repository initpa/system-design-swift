//
//  ViewController.swift
//  networking
//
//  Created by Nitesh Patil on 28/05/24.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    private let tableView = UITableView()
    private var viewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchData()
    }
    
    private func configureTableView() {
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
        view.addSubview(tableView)
    }
    
    private func fetchData() {
        Task {
            do {
                try await viewModel.fetchUsers()
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Error fetching data: \(error)")
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as? UserTableViewCell
        let user = viewModel.users[indexPath.row]
        // Configure cell with other user properties if needed
        cell?.configure(user)
        return cell ?? UITableViewCell()
    }
}
