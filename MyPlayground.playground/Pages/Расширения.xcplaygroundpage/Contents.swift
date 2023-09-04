import Foundation

extension Double {
    var asKM: Double { return self / 1000.0 }
    var asM: Double { return self }
    var asCM: Double { return self * 100.0 }
    var asMM: Double { return self * 1000.0 }
}
let length: Double = 25
length.asKM
length.asCM
length.asMM

extension Double {
    var asFT: Double {
        get {
            return self / 0.3048
        }
        set(newValue) {
            self = newValue * 0.3048
        }
    }
}
var distance: Double = 100
distance.asFT
distance.asFT = 150


extension Int {
    func repetitions(task: () -> ()) {
        for _ in 0..<self {
            task()
        }
    }
}
3.repetitions {
    print("Swift")
}

// для изменения свойств enum и struct используем mutating

extension Int {
    mutating func squared() {
        self = self * self
    }
}
var someInt = 3
someInt.squared()

struct Line {
    var pointOne: (Double, Double)
    var pointTwo: (Double, Double)
}
extension Double {
    init(line: Line) {
        self = sqrt(pow((line.pointTwo.0 - line.pointOne.0), 2) + pow((line.pointTwo.1 - line.pointTwo.1), 2))
    }
}
var myLine = Line(pointOne: (10, 10), pointTwo: (14,10))
var lineLength = Double(line: myLine)

protocol TextRepresentable {
    func asText() -> String
}

extension Int: TextRepresentable {
    func asText() -> String {
        return String(self)
    }
}
5.asText()

protocol Descriptional {
    func getDescription() -> String
}

extension Descriptional {
    func getDescription() -> String {
        return "Описание объектного типа"
    }
}

class myClass: Descriptional {}
print(myClass().getDescription())

class MyStruct: Descriptional {
    func getDescription() -> String {
        return "Описание структуры"
    }
}
MyStruct().getDescription()

extension TextRepresentable {
    func about() -> String {
        return "Данный тип поддерживает протокол TextRepresentable"
    }
}

5.about()















