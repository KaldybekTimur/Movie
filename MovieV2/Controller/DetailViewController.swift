//
//  DetailViewController.swift
//  MovieV2
//
//  Created by Timur on 03.02.2021.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var isFavorite: UIButton!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    var overview = ""
    var date = ""
    var rating = 0.0
    var titleString = ""
    var poster = ""
    var buttonActive = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadImage()
        movieTitle.text = titleString
        movieRating.text = String(rating)
        movieDate.text = date
        movieOverview.text = overview
        isFavorite.setBackgroundImage(UIImage(named: "star"), for: .normal)
    }
    
    @IBAction func isFavoritePressed(_ sender: UIButton) {
        if buttonActive {
            isFavorite.setBackgroundImage(UIImage(named: "star"), for: .normal)
        } else {
            isFavorite.setBackgroundImage(UIImage(named: "star-filled"), for: .normal)
        }
            buttonActive = !buttonActive
    }
    
    func loadImage(){
        
        let url = URL(string: "https://image.tmdb.org/t/p/w300\(poster)")
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.posterImage.image = UIImage(data: data!)
            }
        }
    }
}
