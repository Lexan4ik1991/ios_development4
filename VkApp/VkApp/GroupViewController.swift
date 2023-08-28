//
//  GroupViewController.swift
//  VkApp
//
//  Created by 123 on 28.08.2023.
//

import UIKit


final class GroupsViewController: UITableViewController {
    private let networkService = NetworkService()
    private var models: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Groups"
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barTintColor = .black
        tableView.register(GroupCell.self, forCellReuseIdentifier:Constants.Identifier.groupCellIdentifier
        )
        networkService.getGroups{ [weak self] groups in self?.models=groups
            DispatchQueue.main.async{
                self?.tableView.reloadData()
            }
        }
    }
            

    override func tableView(_ _tableView: UITableView,
                                numberOfRowsInSection section: Int) -> Int {
            models.count
            
    }
            
    override func tableView(_ _tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifier.groupCellIdentifier, for: indexPath) as? GroupCell else {
                    return UITableViewCell()
                }
                
                let model = models[indexPath.row]
                cell.updateCell(model:model)
                return cell
}
}
