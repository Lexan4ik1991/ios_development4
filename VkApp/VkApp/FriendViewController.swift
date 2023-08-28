//
//  FriendViewController.swift
//  VkApp
//
//  Created by 123 on 28.08.2023.
//
import UIKit
final class FriendViewController: UITableViewController{
    private let networkService = NetworkService()
    private var models:[Friend] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Friends"
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barTintColor = .white
        tableView.register(FriendCell.self, forCellReuseIdentifier:Constants.Identifier.friendCellIdentifier)
        networkService.getFiends{ [weak self] friends in self?.models=friends
            DispatchQueue.main.async{
                self?.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifier.friendCellIdentifier, for: indexPath) as? FriendCell else {
            return UITableViewCell()
        }
        
        let model = models[indexPath.row]
        cell.updateCell(model:model)
        return cell
    }
    
    
}
