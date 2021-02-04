//
//  ViewController.swift
//  MovieV2
//
//  Created by Timur on 03.02.2021.
//

import UIKit

class ViewController: UIViewController {
    
    
    var apiService = Service()
    var movies = [Movie]()
    
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Movie 📽"
       loadMovies()
        
        let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
            if #available(iOS 10.0, *) {
                tableView.refreshControl = refreshControl
            } else {
                tableView.backgroundView = refreshControl
            }
        }
    
    
    @objc func refresh(_ refreshControl: UIRefreshControl) {
        loadMovies()
        refreshControl.endRefreshing()
    }
    
    func loadMovies(){
        fetchPopularMoviesData { [weak self] in
            self?.tableView.dataSource = self
            self?.tableView.delegate = self
            self?.tableView.reloadData()
        }
    }
    
    func fetchPopularMoviesData(completion: @escaping () -> ()) {
        apiService.getData { [weak self] (result) in
            
            switch result {
            case .success(let listOf):
                self?.movies = listOf.movies
                completion()
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if movies.count != 0 {
            return movies.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        let movie = movies[indexPath.row]
        cell.setCellWithValuesOf(movie)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let lastIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastIndex) - 1
        
        if indexPath.section == lastIndex && indexPath.row == lastRowIndex{
            
            //: нужно **Доделать refresh**
            // self.loadMovies()
            
        } else {
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segue"{
            let vc = segue.destination as! DetailViewController
            if let customIndexPath = self.tableView.indexPathForSelectedRow {
                let movie = movies[customIndexPath.row]
                
                guard let title = movie.title else { return }
                vc.titleString = title
                
                guard let overview = movie.overview else {return}
                vc.overview = overview
                
                guard let year = movie.year else {return}
                vc.date = year
                
                guard let rating = movie.rate else {return}
                vc.rating = rating

                guard let poster = movie.posterImage else {return}
                vc.poster = poster
                
                print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
                print("\(poster)")
                
            }
        }
    }
    
}
