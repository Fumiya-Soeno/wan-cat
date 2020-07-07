import UIKit
import RealmSwift

class ViewController: UIViewController, UITextFieldDelegate {
    var catCount = 0
    var dogCount = 0
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var buttonCat: UIButton!
    @IBOutlet weak var buttonDog: UIButton!
    @IBOutlet weak var textView: UITextView!
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
            textView.text = "あああああ"
            label.text = "どっち?"
            buttonCat.setTitle("🐱", for: .normal)
            buttonDog.setTitle("🐶", for: .normal)
            let buttonSize = UIFont.systemFont(ofSize: 60)
            label.font = buttonSize
            buttonCat.titleLabel?.font = buttonSize
            buttonDog.titleLabel?.font = buttonSize
        }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textView.text = textField.text
        textField.resignFirstResponder()
        return true
    }
    
    func tapped(model: Optional<String>, count: inout Int){
        guard let unwrapped = model else { return }
        count += 1
        label.text = "\(unwrapped)+\(count)"
    }
    @IBAction func tapCat(_ sender: Any) {
        tapped(model: buttonCat.currentTitle, count: &catCount)
        let realm = try! Realm()
        let human = Human()
        human.name = "田中"
        human.age  = 23
        human.sex  = "MALE"
        try! realm.write() {
            realm.add(human)
        }
        for num in realm.objects(Human.self){
            print(num)
        }
    }
    @IBAction func tapDog(_ sender: Any) {
        tapped(model: buttonDog.currentTitle, count: &dogCount)
        
        let realm = try! Realm()
        let results = realm.objects(Human.self).filter("name == '田中'")
        try! realm.write {
            realm.delete(results)
        }
        for num in realm.objects(Human.self){
            print(num)
        }
    }
}
