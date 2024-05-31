//
//  UserViewModel.swift
//  networking
//
//  Created by Nitesh Patil on 31/05/24.
//

import Foundation

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
