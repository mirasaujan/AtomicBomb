#if !os(macOS)
import UIKit

@propertyWrapper
class Atomic<Value> {
    private let queue = DispatchQueue(label: "com.miraskarazhigitov.atomic")
    private var value: Value

    init(wrappedValue: Value) {
        self.value = wrappedValue
    }
    
    var wrappedValue: Value {
        get {
            return queue.sync { value }
        }
        set {
            queue.sync { value = newValue }
        }
    }
    
    var projectedValue: Atomic<Value> {
        return self
    }
    
    func mutate(_ mutation: (inout Value) -> Void) {
        return queue.sync {
            mutation(&value)
        }
    }
}

#endif
