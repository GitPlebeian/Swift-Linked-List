import UIKit

class LinkedListNode<T> {
    var value: T
    var next: LinkedListNode<T>?
    weak var prev: LinkedListNode<T>?
    
    init(_ value: T) {
        self.value = value
    }
}

class LinkedList<T> {
    typealias Node = LinkedListNode<T>
    
    private var head: Node?
    private var tail: Node?
    private var internalCount: Int = 0
    
    // First
    var first: Node? {
        return head
    }
    
    // Last
    var last: Node? {
        return tail
    }
    
    // Count
    var count: Int {
        return internalCount
    }
    
    // Subscript
    subscript(index: Int) -> T {
        return atIndex(at: index).value
    }
    
    // At Index
    func atIndex(at index: Int) -> Node {
        var node = head
        for _ in 0..<index {
            if node == nil {
                break
            }
            node = node?.next
        }
        return node!
    }
    
    // Append
    func append(_ value: T) {
        let node = Node(value)
        if let tail = tail {
            tail.next = node
            node.prev = tail
            self.tail = node
        } else {
            head = node
            tail = node
        }
        internalCount += 1
    }
    
    // Insert
    func insert(_ value: T, at index: Int) {
        let node = Node(value)
        if index == 0 {
            head?.prev = node
            node.next = head
            head = node
        } else {
            let prev = atIndex(at: index - 1)
            let next = prev.next
            prev.next = node
            next?.prev = node
            node.next = next
            node.prev = prev
        }
        if node.next == nil {
            tail = node
        }
        internalCount += 1
    }
    
    // Remove All
    func removeAll() {
        head = nil
        tail = nil
        internalCount = 0
    }
    
    // Remove Node
    func remove(node: Node) -> T {
        let next = node.next
        let prev = node.prev
        if let next = next {
            next.prev = prev
        } else {
            tail = prev
        }
        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        internalCount -= 1
        node.next = nil
        node.prev = nil
        return node.value
    }
    
    // Remove At
    func remove(at index: Int) -> T {
        return remove(node: atIndex(at: index))
    }
    
    // Remove Last
    func removeLast() -> T {
        return remove(node: tail!)
    }
    
    // Map
    func map<U>(transform: (T) -> U) -> LinkedList<U> {
        let result = LinkedList<U>()
        var node = head
        while let currentNode = node {
            result.append(transform(currentNode.value))
            node = currentNode.next
        }
        return result
    }
    
    // Filter
    func filter(predicate: (T) -> Bool) -> LinkedList<T> {
        let result = LinkedList<T>()
        var node = head
        while let currentNode = node {
            if predicate(currentNode.value) {
                result.append(currentNode.value)
            }
            node = currentNode.next
        }
        return result
    }
    
    // Print
    func print() {
        guard var node = head else {return}
        Swift.print("\n\nHead: \(String(describing: head?.value))")
        Swift.print("Tail: \(String(describing: tail?.value))")
        Swift.print("\nValue: \(node.value)")
        Swift.print("Next: \(String(describing: node.next?.value))")
        Swift.print("Previous: \(String(describing: node.prev?.value))")
        while let next = node.next {
            node = next
            Swift.print("\nValue: \(node.value)")
            Swift.print("Next: \(String(describing: node.next?.value))")
            Swift.print("Previous: \(String(describing: node.prev?.value))")
        }
    }
}

let list = LinkedList<Int>()
list.append(0)
list.append(1)
list.append(2)
list.append(3)
list.append(4)
list.append(5)
list.append(6)
list.append(7)
list.append(8)
list.append(9)
list.append(10)

let newList = list.filter {$0 % 2 == 1}
newList.print()



