//
//  ViewController.swift
//  RSSProject
//
//  Created by Brendon Sambatti on 03/08/22.
//

import UIKit

class NewsScreenViewController: UIViewController {
        
    @IBOutlet weak var tableView: UITableView!
    private var rssItems:[RSSItem]?
    let service:FeedParser = FeedParser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.callFuncs()
    }
    
    func callFuncs(){
        self.configTableView()
        self.fetchData()
        self.service.delegate(delegate: self)
    }
    private func fetchData(){
        let feedParser = FeedParser()
        feedParser.parseFeed(url: "https://g1.globo.com/rss/g1/carros/") { (rssItems) in
            self.rssItems = rssItems
            OperationQueue.main.addOperation {
                self.tableView.reloadSections(IndexSet(integer: 0), with: .left)
            }
        }
    }
    func configTableView(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UiTableViewCell.nib(), forCellReuseIdentifier: UiTableViewCell.identifier)
    }
}
extension NewsScreenViewController:ServiceDelegate{
    func success() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func error() {
        print("Erro ao carregar tableView")
    }
}
extension NewsScreenViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rssItems = rssItems else{
            return 0
        }
        return rssItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UiTableViewCell", for: indexPath) as? UiTableViewCell
        if let item = rssItems?[indexPath.item]{
            cell?.item = item
        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        500
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == indexPath{
            let storyBoard = UIStoryboard(name: "ReadMoreScreen", bundle: nil)
            let vC = storyBoard.instantiateViewController(identifier: "ReadMoreViewController") as! ReadMoreViewController
            self.present(vC, animated: true, completion: nil)
            vC.titleNewsLabel.text = rssItems?[indexPath.row].title
            vC.dateLabel.text = rssItems?[indexPath.row].pubDate
            let description = rssItems?[indexPath.row].description
            let urlImage = rssItems?[indexPath.row].description ?? ""
            let sliced  = urlImage.slice(from: "https:", to: ".jpg")
            let urlString:String = "https:\(sliced ?? "").jpg"
            guard let url = URL(string: urlString) else{
                return
            }
            vC.newsImage.load(url: url)
            let urlSliced = description?.slice(from: "<", to: " /> ")
            let descriptionContent = description?.replacingOccurrences(of: urlSliced ?? "", with: "")
            let descriptionContent2 = descriptionContent?.replacingOccurrences(of: "< />", with: "")
            vC.descriptionLabel.text = descriptionContent2
        }
        
    }
}
