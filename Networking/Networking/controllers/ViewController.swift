//
//  ViewController.swift
//  networking
//
//  Created by Nitesh Patil on 28/05/24.
//

import UIKit
import Foundation

class UserService {
    func getUsers() async throws -> [User] {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([User].self, from: data)
    }
}


class UserViewModel {
    private let userService = UserService()
    private(set) var users: [User] = []
    
    func fetchUsers() async throws {
        do {
            self.users = try await userService.getUsers()
        } catch {
            throw error
        }
    }
}

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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let user = viewModel.users[indexPath.row]
        cell.textLabel?.text = user.name
        // Configure cell with other user properties if needed
        return cell
    }
}
