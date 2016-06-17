//
//  permutations.swift
//  WordBlox1
//
//  Created by Richard Lowe on 13/04/2016.
//  Copyright © 2016 Richard Lowe. All rights reserved.
//

// MARK: - Common

//public extension MutableCollection {
//    
//    /// [Algorithm](https://en.wikipedia.org/wiki/Permutation#Generation_in_lexicographic_order)
//    
//    public mutating func nextLexPerm
//        (_ isOrderedBefore: (Iterator.Element, Iterator.Element) -> Bool) -> Self? {
//        for k in indices.reversed().dropFirst()
//            where isOrderedBefore(self[k], self[<#T##Collection corresponding to `k`##Collection#>.index(after: k)]) {
//                for l in indices.reversed() where isOrderedBefore(self[k], self[l]) {
//                    swap(&self[k], &self[l])
//                    let r = (<#T##Collection corresponding to `k`##Collection#>.index(after: k)..<endIndex)
//                    for (x, y) in zip(r, r.reversed()) {
//                        if x == y || x == <#T##Collection corresponding to `y`##Collection#>.index(after: y) { return self }
//                        swap(&self[x], &self[y])
//                    }
//                }
//        }
//        return nil
//    }
//}

//public extension MutableCollection where Iterator.Element : Comparable {
//    
//    /// [Algorithm](https://en.wikipedia.org/wiki/Permutation#Generation_in_lexicographic_order)
//    
//    public mutating func nextLexPerm() -> Self? {
//        return nextLexPerm(<)
//    }
//}
///// :nodoc:
//public struct LexPermGen<C : MutableCollection> : IteratorProtocol  {
//    private var col: C?
//    private let order: (C.Iterator.Element, C.Iterator.Element) -> Bool
//    /// :nodoc:
//    mutating public func next() -> C? {
//        defer { col = col?.nextLexPerm(order) }
//        return col
//    }
//}
///// :nodoc:
//public struct LexPermSeq<C : MutableCollection> : LazySequenceProtocol {
//    private let col: C
//    private let order: (C.Iterator.Element, C.Iterator.Element) -> Bool
//    /// :nodoc:
//    public func makeIterator() -> LexPermGen<C> {
//        return LexPermGen(col: col, order: order)
//    }
//}

// MARK: - Eager

//public extension Sequence {
//    
//    /// Returns an array of the permutations of self, ordered lexicographically, according
//    /// to the closure `isOrderedBefore`.
//    /// - Note: The permutations returned follow self, so if self is not the first
//    /// lexicographically ordered permutation, not all permutations will be returned.
//    /// ```swift
//    /// [1, 2, 3].lexPermutations(<)
//    ///
//    /// [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]]
//    /// ```
//    /// ```swift
//    /// [1, 2, 3].lexPermutations(>)
//    ///
//    /// [[1, 2, 3]]
//    /// ```
//    @warn_unused_result
//    public func lexPermutations
//        (_ isOrderedBefore: (Iterator.Element, Iterator.Element) -> Bool) -> [[Iterator.Element]] {
//        return Array(LexPermSeq(col: Array(self), order: isOrderedBefore))
//    }
//}

//public extension MutableCollection where Iterator.Element : Comparable {
//    
//    /// Returns an array of the permutations of self, ordered lexicographically.
//    /// - Note: The permutations returned follow self, so if self is not the first
//    /// lexicographically ordered permutation, not all permutations will be returned.
//    /// ```swift
//    /// [1, 2, 3].lexPermutations()
//    ///
//    /// [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]]
//    /// ```
//    /// ```swift
//    /// [3, 2, 1].lexPermutations()
//    ///
//    /// [[3, 2, 1]]
//    /// ```
//    @warn_unused_result
//    public func lexPermutations() -> [[Iterator.Element]] {
//        return Array(LexPermSeq(col: Array(self), order: <))
//    }
//}
//
//public extension Sequence {
//    
//    /// Returns an array of the permutations of self.
//    /// ```swift
//    /// [1, 2, 3].permutations()
//    ///
//    /// [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]]
//    /// ```
//    @warn_unused_result
//    public func permutations() -> [[Iterator.Element]] {
//        var col = Array(self)
//        return Array(LexPermSeq(col: Array(col.indices), order: <).map { inds in inds.map{col[$0]} })
//    }
//    /// Returns an array of the permutations of length `n` of self.
//    /// ```swift
//    /// [1, 2, 3].permutations()
//    ///
//    /// [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]]
//    /// ```
//    public func permutations(_ n: Int) -> [[Iterator.Element]] {
//        return Array(lazyCombos(n).flatMap { a in a.permutations() })
//    }
//}
//
//// MARK: - Lazy
//
//public extension Sequence {
//    
//    /// Returns a lazy sequence of the permutations of self, ordered lexicographically,
//    /// according to the closure `isOrderedBefore`.
//    /// - Note: The permutations returned follow self, so if self is not the first
//    /// lexicographically ordered permutation, not all permutations will be returned.
//    /// ```swift
//    /// lazy([1, 2, 3]).lazyLexPermutations(<)
//    ///
//    /// [1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]
//    /// ```
//    /// ```swift
//    /// lazy([1, 2, 3]).lazyLexPermutations(>)
//    ///
//    /// [1, 2, 3]
//    /// ```
//    @warn_unused_result
//    public func lazyLexPermutations(_ isOrderedBefore: (Iterator.Element, Iterator.Element) -> Bool)
//        -> LexPermSeq<[Iterator.Element]> {
//            return LexPermSeq(col: Array(self), order: isOrderedBefore)
//    }
//}
//
//public extension Sequence where Iterator.Element : Comparable {
//    
//    /// Returns a lazy sequence of the permutations of self, ordered lexicographically.
//    /// - Note: The permutations returned follow self, so if self is not the first
//    /// lexicographically ordered permutation, not all permutations will be returned.
//    /// ```swift
//    /// lazy([1, 2, 3]).lazyLexPermutations()
//    ///
//    /// [1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]
//    /// ```
//    /// ```swift
//    /// lazy([3, 2, 1]).lazyLexPermutations()
//    ///
//    /// [3, 2, 1]
//    /// ```
//    @warn_unused_result
//    public func lazyLexPermutations()  -> LexPermSeq<[Iterator.Element]> {
//        return LexPermSeq(col: Array(self), order: <)
//    }
//}
//
//public extension Sequence {
//    
//    /// Returns a lazy sequence of the permutations of self.
//    /// - Note: The permutations are lexicographically ordered, based on the indices of self
//    /// ```swift
//    /// lazy([1, 2, 3]).lazyPermutations()
//    ///
//    /// [1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]
//    /// ```
//    /// ```swift
//    /// lazy([3, 2, 1]).lazyPermutations()
//    ///
//    /// [3, 2, 1], [3, 1, 2], [2, 3, 1], [2, 1, 3], [1, 3, 2], [1, 2, 3]
//    /// ```
//    @warn_unused_result
//    public func lazyPermutations() -> LazyMapSequence<LexPermSeq<[Int]>, [Self.Iterator.Element]> {
//        let col = Array(self)
//        return col.indices.lazyLexPermutations().map { $0.map { col[$0] } }
//    }
//}
