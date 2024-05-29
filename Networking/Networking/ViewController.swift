//
//  ViewController.swift
//  networking
//
//  Created by Nitesh Patil on 28/05/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let getRequest = APIRequest(method: .get, path: "users")

        APIClient().perform(getRequest) { (result) in
            switch result {
            case .success(let response):
                if let response = try? response.decode(to: [User].self) {
                    let users = response.body
                    for user in users {
                        print("Name: \(user.name), Email: \(user.email), City: \(user.address.city)")
                    }
                }
                else {
                    
                    print("Failed to decode response")
                }
            case .failure:
                print("Error perform network request")
            }
        }
    }


}

