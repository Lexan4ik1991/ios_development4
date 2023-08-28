//
//  FriendCell.swift
//  VkApp
//
//  Created by 123 on 28.08.2023.
//

import UIKit

final class FriendCell: UITableViewCell {
    private var friendImageView = UIImageView(image: UIImage(systemName: "person"))
    
    private var text: UILabel = {
        let lable = UILabel()
        lable.text = "Name"
        lable.textColor = .black
        return lable
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier reuseIndentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIndentifier)
        backgroundColor = .clear
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(friendImageView)
        contentView.addSubview(text)
        friendImageView.addSubview(onlineFriends)
        setupConstraints()
    }
    
    private var onlineFriends: UIView = {
        let online = UIView()
        online.backgroundColor = .blue
        online.layer.cornerRadius = 8
        return online
    }()
    
    func updateCell(model:Friend){
        text.text = (model.firstName ?? "")+" " + (model.lastName ?? "")
        if let online = model.online{
            let isOnline = online == 1
            if isOnline {
                onlineFriends.backgroundColor = .green
            }
            else{
                onlineFriends.backgroundColor = .gray
            }
        }
        
        DispatchQueue.global().async {
            if let url = URL(string: model.photo ?? ""), let data = try?
            Data(contentsOf: url)
            {DispatchQueue.main.async {
                self.friendImageView.image = UIImage(data:data)
                }}
        }
    }
    
    private func setupConstraints() {
        friendImageView.translatesAutoresizingMaskIntoConstraints = false
        text.translatesAutoresizingMaskIntoConstraints = false
        onlineFriends.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        friendImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        friendImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
        friendImageView.bottomAnchor.constraint(equalTo:contentView.bottomAnchor,constant :-10),
        friendImageView.widthAnchor.constraint(equalTo: friendImageView.heightAnchor),
                    
        friendImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
        
        onlineFriends.widthAnchor.constraint(equalToConstant: 20),
        onlineFriends.heightAnchor.constraint(equalTo: onlineFriends.widthAnchor),
        onlineFriends.bottomAnchor.constraint(equalTo: onlineFriends.bottomAnchor),
        onlineFriends.trailingAnchor.constraint(equalTo: friendImageView.trailingAnchor, constant:10),
        
        text.topAnchor.constraint (equalTo: contentView.topAnchor, constant: 10),
        text.leadingAnchor .constraint (equalTo: friendImageView.trailingAnchor, constant: 10),
        text.trailingAnchor.constraint (equalTo: contentView.trailingAnchor, constant: -10)
        ])
        
        
        
    }
    
    
}
