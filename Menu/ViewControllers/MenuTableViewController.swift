//
//  MenuTableViewController.swift
//  Menu
//
//  Created by Kittinun Chobtham on 6/6/2563 BE.
//  Copyright © 2563 Kittinun Chobtham. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var descriptionLbl: UILabel!
    @IBOutlet var table: UITableView!
    
    var animalArray = [Food]()
    var currentAnimalArray = [Food]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAnimal()
        alterLayout()
    }
    

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    private func setUpAnimal() {
        animalArray.append(Food(name: "ข้าวอบกุญเชียง", category: .cat, image: "1"))
        animalArray.append(Food(name: "ก๋วยเตี๋ยวต้มยำ", category: .cat, image: "2"))
        animalArray.append(Food(name: "พวงนมหมูย่าง", category: .cat, image: "3"))
        
        animalArray.append(Food(name: "ซี่โครงหมูหวาน", category: .dog, image: "4"))
        animalArray.append(Food(name: "ต้มยำขาหมู", category: .dog, image: "5"))
        animalArray.append(Food(name: "ยำหูหมู", category: .dog, image: "6"))
        
        animalArray.append(Food(name: "ก๋วยเตี๋ยวเรืออยุธยา", category: .cat, image: "7"))
        animalArray.append(Food(name: "ผัดเปรี้ยวหวาน", category: .cat, image: "8"))
        animalArray.append(Food(name: "ขาหมูพะโล้", category: .cat, image: "9"))
        
        animalArray.append(Food(name: "ผัดกระเพราะไข่เยี่ยวม้า", category: .dog, image: "10"))
        animalArray.append(Food(name: "ผัดกระเพราะไข่เยี่ยวม้า", category: .dog, image: "11"))
        animalArray.append(Food(name: "แกงผักบังใส่แหนม", category: .dog, image: "12"))
        animalArray.append(Food(name: "แกงคั่วหมูเทโพ", category: .cat, image: "13"))
        animalArray.append(Food(name: "ยำใส้กรอก", category: .cat, image: "14"))
        animalArray.append(Food(name: "คะน้าหมูกรอบ", category: .cat, image: "15"))
        
        animalArray.append(Food(name: "ผัดเต้าหู้หมูสับ", category: .dog, image: "16"))
        animalArray.append(Food(name: "แกงจืดตำลึงหมูสับ", category: .dog, image: "17"))
        animalArray.append(Food(name: "หมูปิ้ง", category: .dog, image: "18"))
        animalArray.append(Food(name: "แกงเขียวหวาน", category: .cat, image: "19"))
        animalArray.append(Food(name: "ตำถั่วหมูกรอบ", category: .cat, image: "20"))
        animalArray.append(Food(name: "ข้าวผัดหมูลิ้นจี่", category: .cat, image: "21"))
        
        animalArray.append(Food(name: "กระเพาะหมูตุ๋นพริกไทยดำ", category: .dog, image: "22"))
        animalArray.append(Food(name: "หมูสับนึ่งไข่เค็ม", category: .dog, image: "23"))
        currentAnimalArray = animalArray
    }
    
    func alterLayout() {
        table.tableHeaderView = UIView()
        table.estimatedSectionHeaderHeight = 50
     
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableCell else {
            return UITableViewCell()
        }
        cell.nameLbl.text = currentAnimalArray[indexPath.row].name
        cell.categoryLbl.text = currentAnimalArray[indexPath.row].category.rawValue
        cell.imgView.image = UIImage(named:currentAnimalArray[indexPath.row].image)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currentAnimalArray = animalArray.filter({ animal -> Bool in
            switch searchBar.selectedScopeButtonIndex {
            case 0:
                if searchText.isEmpty { return true }
                return animal.name.lowercased().contains(searchText.lowercased())
            case 1:
                if searchText.isEmpty { return animal.category == .dog }
                return animal.name.lowercased().contains(searchText.lowercased()) &&
                animal.category == .dog
            case 2:
                if searchText.isEmpty { return animal.category == .cat }
                return animal.name.lowercased().contains(searchText.lowercased()) &&
                animal.category == .cat
            default:
                return false
            }
        })
        table.reloadData()
    }

    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
            switch selectedScope {
            case 0:
                currentAnimalArray = animalArray
            case 1:
                currentAnimalArray = animalArray.filter({ animal -> Bool in
                    animal.category == AnimalType.dog
                })
            case 2:
                currentAnimalArray = animalArray.filter({ animal -> Bool in
                    animal.category == AnimalType.cat
                })
            default:
                break
            }
            table.reloadData()
        }
    }

class Food {
    let name: String
    let image: String
    let category: AnimalType
    
    init(name: String, category: AnimalType, image: String) {
        self.name = name
        self.category = category
        self.image = image
    }
}

enum AnimalType: String {
    case cat = "Cat"
    case dog = "Dog"
}



