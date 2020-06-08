//
//  ViewController.swift
//  secret Santa Claus gift randomizer
//
//  Created by denys pashkov on 17/12/2019.
//  Copyright © 2019 denys pashkov. All rights reserved.
//there was some "special request" for have the gift to a specific person

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var giftTableView: UITableView!
    
    var lastGifter = "nil"
    var numberOfElement : Int = 0
    var giftRecord : [Record] = []
    
    var gifterArray : [String] = []
    var temp : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readGift()
        
        
    }
    
    func readGift() {
        let url = URL(string: "https://api.airtable.com/v0/appVSho7Wr9zX8xv9/Secret%20Santa?view=Grid%20view&fields%5B%5D=Name&api_key=keyvSDG29X6BEJH0B")

        let dataTask = URLSession.shared.dataTask(with: url!) { data,_,_ in
            
            guard let jsonData = data else {
                print("no data aviable")
                return
            }
            
            do{
                
                let decoder = JSONDecoder()
                self.giftRecord = try decoder.decode(Gift.self, from: jsonData).records
                self.numberOfElement = self.giftRecord.count - 1
                DispatchQueue.main.async { // Correct
                    self.temp = self.giftRecord.count
                    self.giftTableView.reloadData()
                }
                
            } catch{
                
                print("can't process this shit")
                
            }
            
        }
        dataTask.resume()
//        print(self.giftRecord)

    }
    
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfElement
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CellManager

        if gifterArray.count == temp {
            if indexPath.row == temp{
                
                cell.giftFrom.text = gifterArray[indexPath.row]
                cell.giftTo.text = gifterArray[0]
                
                return cell
                
            }
            
            cell.giftFrom.text = gifterArray[indexPath.row]
            cell.giftTo.text = gifterArray[indexPath.row + 1]
            
            return cell
            
        }
        
        if lastGifter == "nil" {
            let randomNumber = Int.random(in: 0...numberOfElement)
            lastGifter = giftRecord[randomNumber].fields.Name ?? "No Name Assigned"
            gifterArray.append(lastGifter)
            giftRecord.remove(at: randomNumber)
            numberOfElement -= 1
        }
        cell.giftFrom.text =  lastGifter
        if lastGifter == "Claudia Catapano"{
            lastGifter = "Simona"
            cell.giftTo.text = lastGifter
            gifterArray.append(lastGifter)
            
        } else if lastGifter == "Francesco Arena"{

            lastGifter = "Claudia Catapano"
            cell.giftTo.text = lastGifter
            gifterArray.append(lastGifter)

        } else {
            let randomNumber = Int.random(in: 0...numberOfElement)
            
            lastGifter = giftRecord[randomNumber].fields.Name ?? "No Name Assigned"
            cell.giftTo.text = lastGifter
            gifterArray.append(lastGifter)
            giftRecord.remove(at: randomNumber)
            
        }
//        let randomNumber = Int.random(in: 0...numberOfElement)
//        lastGifter = giftRecord[randomNumber].fields.Name ?? "No Name Assigned"
//
//        cell.giftTo.text = lastGifter
//        giftRecord.remove(at: randomNumber)
        numberOfElement -= 1
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
}
