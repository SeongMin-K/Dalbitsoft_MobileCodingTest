//
//  MyTableViewCell.swift
//  Dalbitsoft_MobileCodingTest
//
//  Created by SeongMinK on 2021/10/08.
//

import Foundation
import UIKit

class MyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lectureName: UILabel!
    @IBOutlet weak var professorName: UILabel!
    @IBOutlet weak var notificationCount: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        print(#fileID, #function, "called")
    }
}
