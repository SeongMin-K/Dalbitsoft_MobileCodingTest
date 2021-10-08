//
//  ViewController.swift
//  Dalbitsoft_MobileCodingTest
//
//  Created by SeongMinK on 2021/10/08.
//

import UIKit
import RealmSwift
import Alamofire
import SwiftyJSON

struct Class {
    let name: String
    let professor: String
    let count: Int
}

struct Public {
    let name: String
    let place: String
    let count: Int
}

class ViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var semester: UILabel!
    @IBOutlet weak var week: UILabel!
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var currentLectureTableView: UITableView!
    @IBOutlet weak var openLectureTableView: UITableView!
    @IBOutlet weak var tabBar: UITabBar!
    
    // Realm 가져오기
    let realm = try! Realm()
    var id = 0
    
    var currentLectureNameArray = Array<String>()
    var currentLectureProfessorArray = Array<String>()
    var currentLectureCountArray = Array<Int>()

    var openLectureNameArray = Array<String>()
    var openLecturePlaceArray = Array<String>()
    var openLectureCountArray = Array<Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(#fileID, #function, "called")
        
        // 프로필 사진 둥글게 만들기
        userImage.layer.cornerRadius = userImage.frame.width / 2
        
        // Realm 파일 위치
        print("Location : \(Realm.Configuration.defaultConfiguration.fileURL!)")
        
        // Realm 기존 데이터 모두 삭제
        try! realm.write {
            realm.deleteAll()
        }
        
        getData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            let myTableViewCellNib = UINib(nibName: String(describing: MyTableViewCell.self), bundle: nil)
            
            self.currentLectureTableView.register(myTableViewCellNib, forCellReuseIdentifier: "myTableViewCell")
            self.openLectureTableView.register(myTableViewCellNib, forCellReuseIdentifier: "myTableViewCell")
            
            self.currentLectureTableView.rowHeight = UITableView.automaticDimension
            self.openLectureTableView.rowHeight = UITableView.automaticDimension
            
            self.currentLectureTableView.estimatedRowHeight = 120
            self.openLectureTableView.estimatedRowHeight = 120
            
            self.currentLectureTableView.delegate = self
            self.openLectureTableView.delegate = self
            
            self.currentLectureTableView.dataSource = self
            self.openLectureTableView.dataSource = self
        })
    }
    
    fileprivate func getData() {
        let url = "https://api2.coursemos.kr/coding_test.php"
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type":"application/json; charset=UTF-8",
                             "Accept":"application/json; charset=UTF-8"])
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    
                    for item in json["class"].arrayValue {
                        let name = item["name"].stringValue
                        let professor = item["professor"].stringValue
                        let count = item["count"].intValue
                        self.currentLectureNameArray.append(name)
                        self.currentLectureProfessorArray.append(professor)
                        self.currentLectureCountArray.append(count)
//                        print(self.currentLectureCountArray)
//                        print("Current: \(name), \(professor), \(count)")
                    }
                    
                    for item in json["public"].arrayValue {
                        let place = item["place"].stringValue
                        let name = item["name"].stringValue
                        let count = item["count"].intValue
                        self.openLectureNameArray.append(name)
                        self.openLecturePlaceArray.append(place)
                        self.openLectureCountArray.append(count)
//                        print(self.openLectureCountArray)
//                        print("Open: \(name), \(place), \(count)")
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    // 테이블 뷰 셀의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == currentLectureTableView ? self.currentLectureNameArray.count : self.openLectureNameArray.count
    }
    
    // 각 셀에 대한 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = openLectureTableView.dequeueReusableCell(withIdentifier: "myTableViewCell", for: indexPath) as! MyTableViewCell
        
        if tableView == currentLectureTableView {
            cell.lectureName.text = currentLectureNameArray[indexPath.row]
            cell.professorName.text = currentLectureProfessorArray[indexPath.row] + " 교수"
            cell.notificationCount.text = String(currentLectureCountArray[indexPath.row])
        }
        else if tableView == openLectureTableView {
            cell.lectureName.text = openLectureNameArray[indexPath.row]
            cell.professorName.text = openLecturePlaceArray[indexPath.row]
            cell.notificationCount.text = String(openLectureCountArray[indexPath.row])
        }
        
        let data = RealmData()
        
        data.id = id
        data.name = cell.lectureName.text!
        data.professor = cell.professorName.text!
        data.count = Int(cell.notificationCount.text!)!
        id += 1
        
        print(data)
        
        // Realm에 저장하기
        try! realm.write {
            realm.add(data)
        }
        
        return cell
    }
}
