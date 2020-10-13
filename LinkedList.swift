import Foundation

public class Node<T: Equatable>: Equatable {

    var value: T
    var next: Node<T>?
    weak var previous: Node<T>?

    init(value: T) {
        self.value = value
    }

    public static func == (lhs: Node<T>, rhs: Node<T>) -> Bool {
        lhs.value == rhs.value
    }
}

public class LinkedList<T: Equatable> {

    private var _head: Node<T>?
    private var _tail: Node<T>?

    public var head: Node<T>? {
        return _head
    }

    public var tail: Node<T>? {
        return _tail
    }

    public func removeAll() {
        _head = nil
        _tail = nil
    }

    public var isEmpty: Bool {
        _head == nil
    }

    public func append(value: T) {
        let newNode = Node(value: value)
        if self.isEmpty {
            _head = newNode
        } else if _tail == nil {
            _head?.next = newNode
            newNode.previous = _head
            _tail = newNode
        } else if tail?.next == nil {
            _tail?.next = newNode
            newNode.previous = _tail
            _tail = newNode
        }
    }

    public func nodeAt(index: Int) -> Node<T>? {
        if self.isEmpty {
            return nil
        }
        if index == 0 {
            head
        }
        var count = 0
        var node = _head
        while count != index {
            node = node?.next
            count += 1
        }
        return node
    }

    public func remove(node: Node<T>) {
        if let head = _head, node == head {
            _head = head.next
        } else if let tailNode = _tail, tailNode == node {
            _tail = _tail?.previous
            _tail?.next = nil
        } else {
            var currentNode = _head?.next
            while currentNode?.next != nil {
                if let _currentNode = currentNode, _currentNode == node {
                    let currentNodePreviousNode = currentNode?.previous
                    let currentNodeNextNode = currentNode?.next
                    currentNode?.previous?.next = currentNodeNextNode
                    currentNode?.next?.previous = currentNodePreviousNode
                    return
                }
                currentNode = currentNode?.next
            }
            debugPrint("Node not found")
        }
    }

    public func insertAt(index: Int, node: Node<T>) {
        if index == 0 {
            node.next = _head
            _head?.previous = node
            _head = node
        } else {
            var count = 1
            var currentNode = _head?.next
            while count != index && currentNode?.next != nil {
                currentNode = currentNode?.next
                count += 1
            }
            if currentNode?.next == nil {
                _tail?.next = node
                node.previous = _tail
                _tail = node
            } else {
                node.next = currentNode
                node.previous = currentNode?.previous
                currentNode?.previous?.next = node
                currentNode?.previous = node
            }
        }
    }

    public func reverse() {
        var node = _head
        _tail = _head
        while let currentNode = node {
            node = currentNode.next
            swap(&currentNode.next, &currentNode.previous)
            _head = currentNode
        }
    }
}

extension LinkedList: CustomStringConvertible {

    public var description: String {
        var text = "["
        var node = _head
        while node != nil {
            text += "\(node!.value)"
            node = node!.next
            if node != nil {
                text += ", "
            }
        }
        return text + "]"
    }
}

let footballPlayers = LinkedList<String>()
footballPlayers.append(value: "Messi")
footballPlayers.append(value: "Ronaldo")
footballPlayers.append(value: "Neymar")
footballPlayers.append(value: "Mbappe")
footballPlayers.append(value: "Zidane")
footballPlayers.append(value: "Ronaldinho")
footballPlayers.append(value: "Rooney")
debugPrint(footballPlayers)
footballPlayers.insertAt(index: 2, node: Node(value: "I M Vijayan"))
debugPrint(footballPlayers)
footballPlayers.insertAt(index: 2, node: Node(value: "Bhutia"))
debugPrint(footballPlayers)
footballPlayers.insertAt(index: 1, node: Node(value: "Chethri"))
debugPrint(footballPlayers)
footballPlayers.insertAt(index: 4, node: Node(value: "Sahal"))
debugPrint(footballPlayers)
footballPlayers.insertAt(index: 2, node: Node(value: "Thapa"))
debugPrint(footballPlayers)
footballPlayers.insertAt(index: 9, node: Node(value: "Vineeth"))
debugPrint(footballPlayers)
footballPlayers.append(value: "Amithab Bachan")
debugPrint(footballPlayers)
footballPlayers.remove(node: Node(value: "Amithab Bachan"))
footballPlayers.append(value: "Rafi")
debugPrint(footballPlayers)
footballPlayers.reverse()
debugPrint(footballPlayers)