//
//  apiService.swift
//  MovieV2
//
//  Created by Timur on 03.02.2021.
//

import Foundation


class Service {
    
    var dataTask : URLSessionDataTask?
    
    func getData(completion: @escaping (Result<MoviesData, Error>) -> Void){
        let urlString = "https://api.themoviedb.org/3/movie/popular?api_key=0836de8976a00c2fcc60855c16e1888b&language=en-US&page=1"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, responce, error) in
            if error != nil {
                print("Error: \(error!)")
                return
            }
            
            guard let responce = responce as? HTTPURLResponse else {
                print("Response")
                return
            }
            print("Response status: \(responce.statusCode)")
            
            guard let data = data else {
                return
            }

            do{
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MoviesData.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
}
