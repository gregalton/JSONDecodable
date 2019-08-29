//
//  ViewController.swift
//  JSONDecodable
//
//  Created by Greg Alton on 8/28/19.
//  Copyright © 2019 Greg Alton. All rights reserved.
//

import UIKit

struct ToDo : Decodable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}

class ViewController: UIViewController {
    
    final let url = URL(string: "https://jsonplaceholder.typicode.com/todos/")

    override func viewDidLoad() {
        super.viewDidLoad()
        downloadData()
    }

    func downloadData() {
        guard let downloadURL = url else {return}
        URLSession.shared.dataTask(with: downloadURL) { (data, response, error) in
            
            if(error != nil) {
                print("There was an error downloading data")
                return
            }
            
            guard let data = data else {return}
            
            do {
                let todos = try JSONDecoder().decode([ToDo].self, from: data)
                print(todos)
            } catch let error {
                print("error parsing data", error)
            }

        }.resume()
    }

}

