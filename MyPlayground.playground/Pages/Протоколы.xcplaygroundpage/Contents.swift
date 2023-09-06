import UIKit


protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}

struct someStruct: SomeProtocol {
    var mustBeSettable: Int
    let doesNotNeedToBeSettable: Int
    func getSum() -> Int {
        self.mustBeSettable + self.doesNotNeedToBeSettable
    }
}

// для указания требования к реализации используется static

protocol AnotherProtocol {
    static var someTypeProperty: Int { get }
}

struct AnotherStruct: SomeProtocol, AnotherProtocol {
    var mustBeSettable: Int
    var doesNotNeedToBeSettable: Int
    static var someTypeProperty: Int = 15

    func getSum() -> Int {
        self.mustBeSettable + self.doesNotNeedToBeSettable + AnotherStruct.someTypeProperty
    }
}

// для требоваания реализации изменяющегося метода используем mutating

protocol RandomNumberGenerator {
    var randomCollection: [Int] { get set }
    func getRandomNumber() -> Int
    mutating func setNewNumberCollection(newValue: [Int])
}

struct RandomGenerator: RandomNumberGenerator {
    var randomCollection: [Int] = [1,2,3,4,5]
    func getRandomNumber() -> Int {
        guard let element = randomCollection.randomElement() else { return 0 }
        return element
    }
    mutating func setNewNumberCollection(newValue: [Int]) {
        self.randomCollection = newValue
    }
}

class RandomGeneratorClass: RandomNumberGenerator {
    var randomCollection: [Int] = [1,2,3,4,5]
    func getRandomNumber() -> Int {
        if let randomElement = randomCollection.randomElement() {
            return randomElement
        }
        return 0
    }
    func setNewNumberCollection(newValue: [Int]) {
        self.randomCollection = newValue
    }
}

protocol Named {
    init(name: String)
}

// required гарантирует реализацию в подклассах этого класса, нет необходимости использовать, если есть final

class Person: Named {
    var name: String
    required init(name: String) {
        self.name = name
    }
}

final class Person2: Named {
    var name: String
    init(name: String) {
        self.name = name
    }
}

func getHush<T: Hashable>(of value: T) -> Int {
    return value.hashValue
}
getHush(of: 7)
getHush(of: "swift")
// ?????

protocol HasValue {
    var value: Int { get set }
}

class ClassWithValue: HasValue {
    var value: Int
    init (value: Int) {
        self.value = value
    }
}
struct StructWithValue: HasValue {
    var value: Int
}

let objects: [Any] = [2, StructWithValue(value: 3), true, ClassWithValue(value: 6), "Usov"]

for object in objects {
    if let elemenntWithValue = object as? HasValue {
        print("Значение \(elemenntWithValue.value)")
    }
}
for object in objects {
    print(object is HasValue)
}
// наследование проттоколов

protocol GeometricFigureWithXAxis {
    var x: Int { get set }
}
protocol GeometricFigureWithYAxis {
    var y: Int { get set }
}
protocol GeometricFigureWithTwoAxis: GeometricFigureWithXAxis, GeometricFigureWithYAxis {
    var distanceFromCenter: Float { get }
}
struct Figure2D: GeometricFigureWithTwoAxis {
    var x: Int = 0
    var y: Int = 0
    var distanceFromCenter: Float {
        let xPow = pow(Double(self.x), 2)
        let yPow = pow(Double(self.y), 2)
        let length = sqrt(xPow + yPow)
        return Float(length)
    }
}

// классовые протоколы

protocol SuperProtocol { }
protocol SubProtocol: class, SuperProtocol { }
class ClassWithProtocol: SubProtocol { }
// struct StructWithProtocol: SubProtocol { }

// композиция протоколов

protocol Named2 {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}
struct SomePerson: Named2, Aged {
    var name: String
    var age: Int
}
func withHappyBirthday (celebrator: Named2 & Aged) {
    print("С днем Рождения, \(celebrator.name)! Тебе уже \(celebrator.age)!")
}
let birthdayPerson = SomePerson(name: "Джон Уик", age: 46)
withHappyBirthday(celebrator: birthdayPerson)
