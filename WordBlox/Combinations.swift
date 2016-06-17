////
////  Combinations.swift
////  WordBlox1
////
////  Created by Richard Lowe on 13/04/2016.
////  Copyright © 2016 Richard Lowe. All rights reserved.
////
//
///// :nodoc:
//public struct ComboGen<SubElement> : IteratorProtocol {
//    
//    private let coll: [SubElement]
//    private var curr: [SubElement]
//    private var inds: [Int]
//    /// :nodoc:
//    mutating public func next() -> [SubElement]? {
//        for (max, curInd) in zip(coll.indices.reversed(), inds.indices.reversed())
//            where max != inds[curInd] {
//                inds[curInd] += 1
//                curr[curInd] = coll[inds[curInd]]
//                for j in inds.indices.suffix(from: curInd+1) {
//                    inds[j] = (inds[j-1] + 1)
//                    curr[j] = coll[inds[j]]
//                }
//                return curr
//        }
//        return nil
//    }
//}
///// :nodoc:
//public struct ComboSeq<Element> : LazySequenceProtocol {
//    
//    private let start: [Element]
//    private let col  : [Element]
//    private let inds : [Int]
//    /// :nodoc:
//    public func makeIterator() -> ComboGen<Element> {
//        return ComboGen<Element>(coll: col, curr: start, inds: inds)
//    }
//    
//    internal init(n: Int, col: [Element]) {
//        self.col = col
//        start = Array(col.prefix(upTo: n))
//        var inds = Array(col.indices.prefix(upTo: n))
//        if !inds.isEmpty {
//            inds[(n - 1)] -= 1
//        }
//        self.inds = inds
//    }
//}
///// :nodoc:
//public struct ComboRepGen<Element> : IteratorProtocol {
//    
//    private let coll: [Element]
//    private var curr: [Element]
//    private var inds: [Int]
//    private let max : Int
//    /// :nodoc:
//    mutating public func next() -> [Element]? {
//        for curInd in inds.indices.reversed() where max != inds[curInd] {
//            inds[curInd] += 1
//            curr[curInd] = coll[inds[curInd]]
//            for j in (curInd+1)..<inds.count {
//                inds[j] = inds[j-1]
//                curr[j] = coll[inds[j]]
//            }
//            return curr
//        }
//        return nil
//    }
//}
///// :nodoc:
//public struct ComboRepSeq<Element> : LazySequenceProtocol {
//    
//    private let start: [Element]
//    private let inds : [Int]
//    private let col  : [Element]
//    private let max  : Int
//    /// :nodoc:
//    public func makeIterator() -> ComboRepGen<Element> {
//        return ComboRepGen(coll: col, curr: start, inds: inds, max: max)
//    }
//    
//    internal init(n: Int, col: [Element]) {
//        self.col = col
//        start = col.first.map { x in Array(repeating: x, count: n) } ?? []
//        var inds = Array(repeating: col.startIndex, count: n)
//        if !inds.isEmpty { inds[n-1] -= 1 }
//        self.inds = inds
//        max = (col.endIndex - 1)
//    }
//}
//
//
//extension Sequence {
//    /**
//     Returns the combinations without repetition of length `n` of `self`
//     */
//    @warn_unused_result
//    public func combos(_ n: Int) -> [[Iterator.Element]] {
//        return Array(ComboSeq(n: n, col: Array(self)))
//    }
//    /**
//     Returns the combinations with repetition of length `n` of `self`
//     */
//    @warn_unused_result
//    public func combosWithRep(_ n: Int) -> [[Iterator.Element]] {
//        return Array(ComboRepSeq(n: n, col: Array(self)))
//    }
//    /**
//     Returns the combinations without repetition of length `n` of `self`, generated lazily
//     and on-demand
//     */
//    @warn_unused_result
//    public func lazyCombos(_ n: Int) -> ComboSeq<Iterator.Element> {
//        return ComboSeq(n: n, col: Array(self))
//    }
//    /**
//     Returns the combinations with repetition of length `n` of `self`, generated lazily and
//     on-demand
//     */
//    @warn_unused_result
//    public func lazyCombosWithRep(_ n: Int) -> ComboRepSeq<Iterator.Element> {
//        return ComboRepSeq(n: n, col: Array(self))
//    }
//}
//
////i += 1
//
////extension CollectionType {
////    func powerSet() -> LazySequence<FlattenSequence<LazyMapSequence<Self, ComboSeq<Self.Generator.Element>>>>{
////        let i = 0
////        //return lazy.flatMap{ _ in self.lazyCombos(++i) }
////        return lazy.flatMap{ _ in self.lazyCombos(i+1) }
////    }
////}
