//
//  VideoListViewController.swift
//  AdaProject
//
//  Created by user198010 on 8/6/21.
//

import UIKit

class VideoListViewController: UIViewController {
    
  
    @IBOutlet weak var videoList: UITabBarItem!
    @IBOutlet weak var tableView: UITableView! 
    @IBOutlet weak var emptyVideoListView: UIView!
    @IBOutlet weak var takeNewVideoBtn: UIButton!
    
    var request = ApiRequest()
    var videolist = [Videos]()
    var response = Response()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emptyVideoListView.isHidden = true
        request.getVideoList(){ data in
            DispatchQueue.main.async {[self] in
                videolist = data
                if videolist.isEmpty {
                    emptyVideoListView.isHidden = false
                    takeNewVideoBtn.isHidden = true
                }
                tableView.reloadData()
            }
            
        }
        
      
        tableView.dataSource = self
        videoList.title = "Videolar"
        videoList.selectedImage = #imageLiteral(resourceName: "VideoSelected")
        tableView.register(UINib(nibName: "VideoInfoCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
    }
    
}

extension VideoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videolist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! VideoInfoCell
        cell.weekLabel.text = videolist[indexPath.row].title
        cell.dateLabel.text = videolist[indexPath.row].created
        cell.statusLabel.text = videolist[indexPath.row].status
        if cell.statusLabel.text == "APPROPRIATE" {
            cell.statusLabel.text = "Video Geçerli"
            cell.statusImage.image = #imageLiteral(resourceName: "uploaded")
            cell.takeAgain.isHidden = true
        }
        if cell.statusLabel.text == "PROCESSING" {
            cell.statusLabel.text = "Değerlendiriliyor"
            cell.statusImage.image = #imageLiteral(resourceName: "uploading")
            cell.takeAgain.isHidden = true
        }
        if cell.statusLabel.text == "INAPPROPRIATE" {
            cell.statusLabel.text = "Video Geçersiz"
            cell.statusLabel.textColor = UIColor.red
            cell.statusImage.image = #imageLiteral(resourceName: "uploadError")
        }
        return cell
    }
    
    
}
