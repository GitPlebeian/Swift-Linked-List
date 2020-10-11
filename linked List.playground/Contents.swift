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
    
    // Append
    func append(_ value: T) {
        let node = Node(value)
        tail?.next = node
        node.prev = tail
        tail = node
        if head == nil {
            head = node
        }
        internalCount += 1
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
    
    // Insert
    func insert(value: T, at index: Int) {
        let node = Node(value)
        if index == 0 {
            head?.prev = node
            node.next = head
            head = node
        } else {
            let prev = atIndex(at: index - 1)
            let next = prev.next
            node.prev = prev
            node.next = next
            prev.next = node
            next?.prev = node
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
    
    // Remove Last
    func removeLast() -> T {
        return removeNode(node: last!)
    }
    
    // Remove At
    func removeAt(at index: Int) -> T {
        return removeNode(node: atIndex(at: index))
    }
    
    // Remove Node
    func removeNode(node: Node) -> T {
        let prev = node.prev
        let next = node.next
        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        if let next = next {
            next.prev = prev
        } else {
            tail = prev
        }
        node.next = nil
        node.prev = nil
        internalCount -= 1
        return node.value
    }
    
    // Reverse
    func reverse() {
        var node = head
        tail = node
        while let currentNode = node {
            node = currentNode.next
            swap(&currentNode.next, &currentNode.prev)
            head = currentNode
        }
    }
    
    // Map
    func map<U>(transform: (T) -> U) -> LinkedList<U> {
        let linkedList = LinkedList<U>()
        var currentNode = head
        while let node = currentNode {
            linkedList.append(transform(node.value))
            currentNode = node.next
        }
        return linkedList
    }
    
    // Filter
    func filter(predicate: (T) -> Bool) -> LinkedList<T> {
        let linkedList = LinkedList<T>()
        var currentNode = head
        while let node = currentNode {
            if predicate(node.value) {
                linkedList.append(node.value)
            }
            currentNode = node.next
        }
        return linkedList
    }
    
    // Print
    func print() {
        Swift.print("Head: \(String(describing: head?.value))")
        Swift.print("Tail: \(String(describing: tail?.value))\n")
        
        var currentNode = head
        while let node = currentNode {
            Swift.print("Value: \(node.value)")
            Swift.print("Next: \(String(describing: node.next?.value))")
            Swift.print("Prev: \(String(describing: node.prev?.value))\n")
            currentNode = node.next
        }
    }
}

let list = LinkedList<Int>()
list.append(1)
list.append(2)
list.append(3)
list.append(4)

list.reverse()

list.print()
