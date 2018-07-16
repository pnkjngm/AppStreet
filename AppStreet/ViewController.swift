//
//  ViewController.swift
//  AppStreet
//
//  Created by iSteer Inc. on 09/06/18.
//  Copyright © 2018 iSteer Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var numberOfResults = Int()
    var farmIDs = [String]()
    var serverIDs = [String]()
    var ids = [String]()
    var secrets = [String]()
    var viewModel : ViewModel!
    var cellWidthHeight = CGFloat()
    var flag : Bool!
    var screenSize : CGRect {
        return UIScreen.main.bounds
    }
    let activityIndicator = UIActivityIndicatorView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "Cell", bundle: nil), forCellWithReuseIdentifier: "myCell")
        self.searchDetailsFromServer(url: URLs.SEARCH.rawValue)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.searchBar.delegate = self
        
        if flag != true {
            self.cellWidthHeight = screenSize.width / 2 - 20
        }
        self.activityIndicator.startAnimating()
    }
    func searchDetailsFromServer(url : String) {
        NetworkManager.getHTTPs(url: url, success: { (JSONResponse) in
            // Handle the data
            self.numberOfResults = JSONResponse["photos"]["photo"].count
            
            for index in 0..<self.numberOfResults {
                self.farmIDs.append(String(describing : JSONResponse["photos"]["photo"][index]["farm"]))
                self.serverIDs.append(String(describing : JSONResponse["photos"]["photo"][index]["server"]))
                self.ids.append(String(describing : JSONResponse["photos"]["photo"][index]["id"]))
                self.secrets.append(String(describing : JSONResponse["photos"]["photo"][index]["secret"]))
            }
            
//            https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg


            //Reload the table
            self.collectionView.reloadData()
            
        }) { (failureResponse) in print("Failure", failureResponse) }
    }
    
    @IBAction func btnOptionsTapped(_ sender: Any) {
        
        let sortBy = UIAlertController(title: nil, message: "Sort by", preferredStyle: .actionSheet)
        let mostPopular = UIAlertAction(title: "Two in Row", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.cellWidthHeight = self.screenSize.width/2 - 20
            self.flag = true
            self.searchBar.text = nil
            self.collectionView.reloadData()

        })
        let highestRated = UIAlertAction(title: "Three in Row", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.cellWidthHeight = self.screenSize.width/3 - 20
            self.flag = true
            self.searchBar.text = nil
            self.collectionView.reloadData()
            
        })
        let nowPlaying = UIAlertAction(title: "Four in Row", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.cellWidthHeight = self.screenSize.width/4 - 20
            self.flag = true
            self.searchBar.text = nil
            self.collectionView.reloadData()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancel")
        })
        
        sortBy.addAction(mostPopular)
        sortBy.addAction(highestRated)
        sortBy.addAction(cancelAction)
        sortBy.addAction(nowPlaying)
        sortBy.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        self.present(sortBy, animated: true, completion: nil)
    }
    

}



extension ViewController : UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return numberOfResults
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //viewModel Reference variable
        
        viewModel = ViewModel(farmID: farmIDs[indexPath.row], serverID: serverIDs[indexPath.row], id: ids[indexPath.row], secret: secrets[indexPath.row])
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! Cell
        cell.viewModelData(viewModel: viewModel)
        
        return cell
    }
}

extension ViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidthHeight, height: cellWidthHeight)
    }
}


extension ViewController : UISearchBarDelegate {
    
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        guard searchText.count != 0 else {
            return
        }

        let urlStr = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=be365ea669573472ffe0f1a1cf6b3e94&user_id=157707932%40N07&text=\(searchText.lowercased())&format=json&nojsoncallback=1&api_sig=7cd45d0ce5f682dfca76a50ebf7585fb"
        self.searchDetailsFromServer(url: urlStr)

        self.collectionView.reloadData()

    }
}
