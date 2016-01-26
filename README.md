=======
# Arithmetic-Formulas-Encoding-Package

We provide here a sagemath implementation of the integer formula encoding package

The `Integer Formula Encoding Package` is designed to investigate structural 
and combinatorial properties of integer circuit encodings.

# Installation 

A properly working install of [sage](http://sagemath.org/) is the only prerequisite to using the 
hypermatrix package. The hypermatrix algebra package has been tested on SageMath Version 6.8.
To get started with SageMath, the authors of the integer formula encoding package highly recommend 
reading [Calcul mathématique avec Sage] (http://sagebook.gforge.inria.fr/)

To use the integer formula encoding package, simply download the [Arithmetic_Formulas_code.sage](https://github.com/gnang/Arithmetic-Formulas-Encoding-Package/blob/master/Arithmetic_Formulas_code.sage) into your working directory and load the file into your SageMath [interactive shell](http://doc.sagemath.org/html/en/tutorial/interactive_shell.html) session using the command:

```python
sage: %runfile("Arithmetic_Formulas_code.sage")
```

# Usage

To obtain a list of all monotone formula encodings which use only addition fanin 2 gates
and which evaluate to an integer n, we use the following instructions.
The monotone formulas below are encoded as trees as follows.

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
To obtain the monotone formula encodings made up by a combination of addition and mulitplication gates,
we use the following instructions

```python
sage: FamPre(4)
['+1+1+11', '+1++111', '++11+11', '++1+111', '+++1111', '*+11+11']
```
or
```python
sage: FamT(4)
[['+', 1, ['+', 1, ['+', 1, 1]]],
 ['+', 1, ['+', ['+', 1, 1], 1]],
 ['+', ['+', 1, 1], ['+', 1, 1]],
 ['+', ['+', 1, ['+', 1, 1]], 1],
 ['+', ['+', ['+', 1, 1], 1], 1],
 ['*', ['+', 1, 1], ['+', 1, 1]]]
```

Similarly to obtain the list of all monotone formula encodings which use a combination of addition,
multiplication and exponentiation gate we use the follwoing instructions

```python
sage: FameT(4)
[['+', 1, ['+', 1, ['+', 1, 1]]],
 ['+', 1, ['+', ['+', 1, 1], 1]],
 ['+', ['+', 1, 1], ['+', 1, 1]],
 ['+', ['+', 1, ['+', 1, 1]], 1],
 ['+', ['+', ['+', 1, 1], 1], 1],
 ['*', ['+', 1, 1], ['+', 1, 1]],
 ['^', ['+', 1, 1], ['+', 1, 1]]]
```


The package also allows for the uniform sampling of monotone formulas which evaluate to a certain integer as follows:

```python
sage: RaFameT(7)
['+', ['*', ['+', 1, 1], ['+', 1, ['+', 1, 1]]], 1]
```

To obtain the shortest monotone formula encoding for an input integer we use the following instruction

```python
sage: L = ShortestTame(6)
sage: L
[9, ['*', ['+', 1, 1], ['+', 1, ['+', 1, 1]]]]
```
We evaluation of monotone formulas is done via the Tree evaluation function  follows 

```python
sage: EvalT(L[1]) 
6
```

For listing all monotone formula encodings which evaluate to an integer which use a
combination of fanin two addition, multiplication and exponentiation gates having the
top most  gate being an addition gate we use

```python
sage: FameTa(4) 
[['+', 1, ['+', 1, ['+', 1, 1]]],
 ['+', 1, ['+', ['+', 1, 1], 1]],
 ['+', ['+', 1, 1], ['+', 1, 1]],
 ['+', ['+', 1, ['+', 1, 1]], 1],
 ['+', ['+', ['+', 1, 1], 1], 1]]
```

Similarly for listing all monotone formula encodings which evaluate to an integer which use a
combination of fanin two addition, multiplication and exponentiation gates having the
top most  gate being an mulitication gate we use

```python
sage: FameTe(9) 
[['^', ['+', 1, 1], ['+', 1, ['+', 1, 1]]],
 ['^', ['+', 1, 1], ['+', ['+', 1, 1], 1]]]
```


# Goodstein's recursion

We describe here an asymptotically optimal algorithm for determining symbolic expressions
which describe FCF integer monotone formula-encoding for relatively large set of consecutive integers.
Integer monotone formula encodings obtain from the Goodstein's recursion are obtained from the package
as follows. 
```python
sage: GoodsteinT(1)
[1, ['+', 1, 1], ['+', 1, ['+', 1, 1]], ['^', ['+', 1, 1], ['+', 1, 1]], ['+', 1, ['^', ['+', 1, 1], ['+', 1, 1]]], ['+', ['+', 1, 1], ['^', ['+', 1, 1], ['+', 1, 1]]], ['+', ['+', 1, ['+', 1, 1]], ['^', ['+', 1, 1], ['+', 1, 1]]]]
```

# Zeta recursion

The zeta recursion produces a list of monotone formula encodings for the recursive prime encoding of integers.

```python
sage: [Pr, Nc]=ZetaT(1) 
sage: Pr
[['+', 1, 1], ['+', 1, ['+', 1, 1]]]
sage: Nc
[1, ['+', 1, 1], ['+', 1, ['+', 1, 1]], ['^', ['+', 1, 1], ['+', 1, 1]]]
```

# Horner recursion

The Horner recursion produces a list of monotone formula encodings for the recursive
horner encoding of integers.

```python
sage: HornerT(1)
[1,
 ['+', 1, 1],
 ['+', 1, ['+', 1, 1]],
 ['^', ['+', 1, 1], ['+', 1, 1]],
 ['*', ['+', 1, 1], ['+', 1, ['+', 1, 1]]],
 ['*', ['^', ['+', 1, 1], ['+', 1, 1]], ['+', 1, ['+', 1, 1]]],
 ['^', ['+', 1, 1], ['^', ['+', 1, 1], ['+', 1, 1]]],
 ['^', ['+', 1, 1], ['+', 1, ['+', 1, 1]]],
 ['+', 1, ['^', ['+', 1, 1], ['+', 1, 1]]]] 
```

For evaluating tree encoding of integers we use the function
```python
sage: EvalT([['+', 1, ['+', 1, 1]], ['+', ['+', 1, 1], 1]])
6
```

# Non monotone formula encodings

The majority of functions implemented in the package deal with 
monotone formula encodings. The function NonMonotoneFormula 
provides a list of all valid monotone formulas encodings of
lenght bounded above by some specified length

```python
sage: NonMontoneFormula(3)
[[],
 [1, -1],
 [],
 [['+', 1, 1], ['+', 1, -1], ['+', -1, 1], ['+', -1, -1], ['*', 1, 1], ['*', 1, -1], ['*', -1, 1], ['*', -1, -1], ['^', 1, 1], ['^', 1, -1], ['^', -1, 1], ['^', -1, -1]],
 []]
```
the sublists in the output above correspond to encodings of different lengths. In order to prune out the 
formulas which admits as subformulas division by zero we use the following code.

```python
sage: sz=11  # Initializing the size parameter
sage: Lt =ReducedNonMonotoneFormula(sz) # Initialization of the list of formulas
sage: Rslt=[]
sage: for n in range(sz+1):
....:   L=[]; i=0
....:   while i<len(Lt[n]):
....:       L.append(Lt[n][i]) 
....:       i=i+1
....:   Rslt.append(Set([EvalT(L[i]) for i in range(len(L))]))  
sage: for i in range(1,len(Rslt)):
....:   for j in range(i):
....:       Rslt[i]=Rslt[i].difference(Rslt[j])
{},
 {1, -1},
 {},
 {2, -2},
 {},
 {3, -1/2, -3, 1/2},
 {},
 {-3/2, 4, I, 3/2, -1/3, 1/3, 1/4, -I, -4},
 {},
 {-5/2, sqrt(-2), 5, -4/3, -2/3, (-1)^(1/3), 5/2, 2/3, 4/3, -1/4, 5/4, -1/8, 1/8, 6, 1/9, 8, (-1)^(-I), -I - 1, -I + 1, -1/2*sqrt(-2), (-1)^I, I - 1, I + 1, -3/4, (-1)^(1/4), 9, sqrt(2), 1/2*sqrt(2), -8, -6, -5, -1},
 {},
 {-1/2*2^(2/3), (-1)^sqrt(-2), -7/3, sqrt(-2) - 1, (-1)^sqrt(2), 7, (-1)^(-1/2*sqrt(-2)), (-2)^(1/3), 10, -2*sqrt(-1/2), 2^(1/3), -sqrt(2), 5/3, 16, 7/3, -2/5, -1/5, 1/5, 2/5, 4/5, 1/4*sqrt(-2), -5/4, 27, -7/8, sqrt(2) - 1, (-1)^(1/3) - 1, -5/3, -8/9, (-1)^(1/8), (-2)^(3/2), -1/9, 2^(1/4), -1/3*sqrt(-3), 4/9, -7/4, 10/9, sqrt(-1/2), 2^(3/2), (-1)^((-1)^I), (-1)^(I - 1), (-2)^I, (-1)^(I + 1), -(-1)^(1/4), -(-1)^(-I), (-1)^((-1)^(1/4)), (-2)^(-I), 1/16, 1/2*I + 1/2, sqrt(-2) + 1, (-2)^(1/4), sqrt(-3), 1/2*sqrt(-2), sqrt(1/2), -27, (-1)^(-I) - 1, -I + 2, -(-1)^I, 7/2, (-1)^(1/4) - 1, (-1)^(5/4), -2*I, (-1)^I + 1, -1/27, 1/27, (-1)^I - 1, 2*I, 9/4, (-1)^(-I) + 1, 2^I, I - 2, -1/6, (-1)^((-1)^(-I)), (-1)^(-I - 1), -I - 2, (-1)^(-I + 1), 2^(-I), -1/2*I - 1/2, -1/2*I + 1/2, 3/4, 1/2*I - 1/2, (-1)^((-1)^(1/3)), I + 2, -sqrt(-2), -1/2*sqrt(-2) - 1, -9, -7, -9/8, 1/2*sqrt(2) - 1, -(-1)^(7/8), 2*sqrt(1/2), 1/4*sqrt(2), (-1)^(1/3) + 1, sqrt(2) + 1, -(-1)^(3/4), sqrt(3), 1/2*sqrt(2) + 1, 1/6, (-1)^(1/9), (-1)^(1/4) + 1, -1/2*sqrt(2), (-1)^(1/2*sqrt(2)), 9/8, -1/2*sqrt(-2) + 1, 1/3*sqrt(3), -(-1)^(1/3), 1/(-1), 1/2*2^(2/3), 7/8, -7/2}] 
```


# Bug report

Please report any bugs, it is greatly appreciated.
