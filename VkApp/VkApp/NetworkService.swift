//
//  NetworkService.swift
//  VkApp
//
//  Created by 123 on 28.08.2023.
//

import Foundation
final class NetworkService {
    static var accessToken = ""
    static var userID = ""
    
    private let session = URLSession.shared
    
    func getFiends(completion: @escaping([Friend]) ->Void) {
        guard let url = URL(string:
            "https://api.vk.com/method/friends.get?access_token=\(NetworkService.accessToken)&v=5.131&fields=online,photo_50")
            else {
                return
        }
        session.dataTask(with: url) { data, _, error in
            guard let data = data else {
                return
            }
            do {
                let friends = try JSONDecoder().decode(FriendsModel.self, from: data)
                completion(friends.response.items)
                print(friends)
            } catch {
                print(error)
            }
            }.resume()
    }
    
    func getGroups(completion: @escaping([Group]) ->Void ){
        guard let url = URL(string:
            "https://api.vk.com/method/groups.get?access_token=\(NetworkService.accessToken)&v=5.131&extended=1&fields=members_count")
            else {
                return
        }
        session.dataTask(with: url) { data, _, error in
            guard let data = data else {
                return
            }
            do {
                let groups = try JSONDecoder().decode(GroupsModel.self, from: data)
                completion(groups.response.items)
                print(groups)
            } catch {
                print(error)
            }
            }.resume()
    }
    
    func getPhotos(completion: @escaping([Photo]) ->Void) {
        guard let url = URL(string:
            "https://api.vk.com/method/photos.get?access_token=\(NetworkService.accessToken)&album_id=wall&v=5.131")
            else {
                return
        }
        session.dataTask(with: url) { data, _, error in
            guard let data = data else {
                return
            }
            do {
                let photos = try JSONDecoder().decode(PhotosModel.self, from: data)
                completion(photos.response.items!)
                print(photos)
            } catch {
                print(error)
            }
            }.resume()
    }
}
