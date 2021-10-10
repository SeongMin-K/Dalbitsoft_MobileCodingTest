//
//  RealmData.swift
//  
//
//  Created by SeongMinK on 2021/10/08.
//

import RealmSwift

class RealmData: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var professor: String = ""
    @objc dynamic var count: Int = 0
    
    // name 고유 값 설정
    override class func primaryKey() -> String? {
        return "name"
    }
}
