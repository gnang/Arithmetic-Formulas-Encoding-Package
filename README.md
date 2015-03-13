=======
# Arithmetic-Formulas-Encoding-Package

We provide here a sagemath implementation of the Integer formula encoding package
**UPDATE 2015-03-10** 

The `Integer Formula encoding Package` is a symbolic hypermatrix package designed to
investigate structural and combinatorial properties of integer circuit encodings.

# Installation 

A properly working install of [sage](http://sagemath.org/) is a prerequisite to using the hypermatrix 
package. Download the Hypermatrix sage file into your working directory. Load the package 
into a sage terminal session using the following command:

```python
sage: %runfile("Arithmetic_Formulas_code.sage")
```

# Usage

To obtain a list of all formula encodings which use only adition fanin 2 gates
and which evaluate to an integer n, we use the following instructions.

```python
sage: FaT(4)
[['+', 1, ['+', 1, ['+', 1, 1]]],
 ['+', 1, ['+', ['+', 1, 1], 1]],
 ['+', ['+', 1, 1], ['+', 1, 1]],
 ['+', ['+', 1, ['+', 1, 1]], 1],
 ['+', ['+', ['+', 1, 1], 1], 1]] 
```
To obtain the same list in prefix notation we use the following instructions

```python
sage: FaPre(4)
['+1+1+11', '+1++111', '++11+11', '++1+111', '+++1111']
```
To obtain the formula encoding using a combination of addition and mulitplication gates,
we use the following instructions

```python
sage: FamPre(4)
['+1+1+11', '+1++111', '++11+11', '++1+111', '+++1111', '*+11+11']
```

To obtain the shortest formula encoding for an input integer we use the following instruction

```python
sage: L = ShortestTame(6)
sage: L
[9, ['*', ['+', 1, 1], ['+', 1, ['+', 1, 1]]]]
```
We evaluate the result for verification as follows 

```python
sage: EvalT(L[1]) 
6
```

# Bug report

Please report any bugs, it is greatly appreciated.
