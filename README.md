=======
# Hypermatrix Algebra Package

We provide here a sagemath implementation of the Integer formula encoding package
**UPDATE 2015-03-10** 

The `Integer Formula encoding Package` is a symbolic hypermatrix package designed to
investigate structural and combinatorial properties of hypermatrices.

# Installation 

A properly working install of [sage](http://sagemath.org/) is a prerequisite to using the hypermatrix 
package. Download the Hypermatrix sage file into your working directory. Load the hypermatrix package 
into a sage terminal session using the following command:

```python
sage: %runfile("Arithmetic_Formulas_code.sage")
```

# Usage

To create a symbolic hypermatrix instance of size 2x3x4 for example, we use the instructions

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
