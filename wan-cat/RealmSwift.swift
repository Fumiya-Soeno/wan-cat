import Foundation
import RealmSwift

class Human: Object {
    @objc dynamic var name = ""
    @objc dynamic var age  = 0
    @objc dynamic var sex  = ""
//    @objc dynamic var createdAt = Date()
}

class Tweet: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var body: String = ""
    @objc dynamic var createdAt = Date()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func newID(realm: Realm) -> Int {
        if let tweet = realm.objects(Tweet.self).sorted(byKeyPath: "id").last {
            return tweet.id + 1
        } else {
            return 1
        }
    }

    // increment された ID を持つ新規 Person インスタンスを返す
    static func create(realm: Realm) -> Tweet {
        let tweet: Tweet = Tweet()
        tweet.id = newID(realm: realm)
        return tweet
    }
    
}
