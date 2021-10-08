//
//  ViewController.swift
//  Dalbitsoft_MobileCodingTest
//
//  Created by SeongMinK on 2021/10/08.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var semester: UILabel!
    @IBOutlet weak var week: UILabel!
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var currentLectureTableView: UITableView!
    @IBOutlet weak var openLectureTableView: UITableView!
    
    let currentLectureNameArray = [
        "중국 문화의 이해 (002)",
        "대학중국어 (005)",
        "현대사회와 정보화 (047)",
        "동아시아 근현대사 (132)"
    ]
    
    let currentLectureProfessorArray = [
        "박영수 교수",
        "임건태 교수",
        "김기영 교수",
        "이규호 교수"
    ]
    
    let openLectureNameArray = [
        "실험윤리와 안전",
        "신입생워크샵",
        "현대사회와 정보화"
    ]
    
    let openLectureProfessorArray = [
        "중앙교육원",
        "중앙교육원",
        "중앙교육원"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(#fileID, #function, "called")
        
        userImage.layer.cornerRadius = userImage.frame.width / 2
        
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
            cell.professorName.text = currentLectureProfessorArray[indexPath.row]
        } else {
            cell.lectureName.text = openLectureNameArray[indexPath.row]
            cell.professorName.text = openLectureProfessorArray[indexPath.row]
        }
        
        return cell
    }
}
