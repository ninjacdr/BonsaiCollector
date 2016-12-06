//
//  ViewController.swift
//  BonsaiCollector
//
//  Created by weeZie on 11/30/16.
//  Copyright © 2016 weeZie. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var bonsais : [Bonsai] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            bonsais = try context.fetch(Bonsai.fetchRequest())
            tableView.reloadData()
        } catch {
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bonsais.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let bonsai = bonsais[indexPath.row]
        cell.textLabel?.text = bonsai.title
        cell.imageView?.image = UIImage(data: bonsai.image as! Data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bonsai = bonsais[indexPath.row]
        performSegue(withIdentifier: "bonsaiSegue", sender: bonsai)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! BonsaiViewController
        nextVC.bonsai = sender as? Bonsai
    }
}

