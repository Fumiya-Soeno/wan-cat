import UIKit
import RealmSwift

class ViewController: UIViewController {
    var catCount = 0
    var dogCount = 0
    @IBOutlet weak var label: UILabel!
        @IBOutlet weak var buttonCat: UIButton!
        @IBOutlet weak var buttonDog: UIButton!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            label.text = "どっち?"
            buttonCat.setTitle("🐱", for: .normal)
            buttonDog.setTitle("🐶", for: .normal)
            let buttonSize = UIFont.systemFont(ofSize: 60)
            label.font = buttonSize
            buttonCat.titleLabel?.font = buttonSize
            buttonDog.titleLabel?.font = buttonSize
        }
    
    func tapped(model: Optional<String>, count: inout Int){
        guard let unwrapped = model else { return }
        count += 1
        label.text = "\(unwrapped)+\(count)"
        
        let realm = try! Realm()
        let tanaka = Human()
        tanaka.name = "田中"
        tanaka.age  = 23
        tanaka.sex  = "MALE"
        try! realm.write() {
            realm.add(tanaka)
        }
    }
    @IBAction func tapCat(_ sender: Any) {
        tapped(model: buttonCat.currentTitle, count: &catCount)
        let realm = try! Realm()
        for num in realm.objects(Human.self){
            print(num)
        }
    }
    @IBAction func tapDog(_ sender: Any) {
        tapped(model: buttonDog.currentTitle, count: &dogCount)
    }
}
