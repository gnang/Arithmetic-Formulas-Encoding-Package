#*************************************************************************#
#       Copyright (C) 2013 Edinah K. Gnang <kgnang@.gmail.com>            #
#                                                                         #
#  Distributed under the terms of the GNU General Public License (GPL)    #
#                                                                         #
#    This code is distributed in the hope that it will be useful,         #
#    but WITHOUT ANY WARRANTY; without even the implied warranty of       #
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU    #
#    General Public License for more details.                             #
#                                                                         #
#  The full text of the GPL is available at:                              #
#                                                                         #
#                  http://www.gnu.org/licenses/                           #
#*************************************************************************#

r"""
Computational Investigations of Arithmetic Formulas formula encodings 
and related algorithms.


AUTHORS:
    -- Edinah K. Gnang and Doron Zeilberger (Wed Aug 21 2013)

TODO:
    -- Try to implement faster version of some of the procedures implemented here.

"""

def T2Pre(expr):
    """
    Converts formula written in the bracket tree encoding to the Prefix string encoding notation
    the symbol m will stand for the input -1


    EXAMPLES:
    The function implemented here tacitly assume that the input is valid
    ::
        sage: T2Pre(['+',1,1])
        '+11'


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    s = str(expr)
    return ((((s.replace("[","")).replace("]","")).replace(",","")).replace("'","")).replace(" ","").replace('-1','m')


def T2P(expr):
    """
    Converts the formula tree to Postfix notation


    EXAMPLES:
    The tacitly assume that the input is valid
    ::
        sage: T2P(['+',1,1])
        '11+'


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    s = str(expr)
    return ((((s.replace("[","")).replace("]","")).replace(",","")).replace("'","")).replace(" ","")[::-1].replace('-1','m')


def RollLD(L):
    """
    Given an Loaded die, L, the procedures rolls it


    EXAMPLES:
    The tacitly assume that the input is a valid binary tree expression
    ::
        sage: RollLD([1, 2, 3])
        3


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    N = sum(L)
    r = randint(1,N)
    for i in range(len(L)):
        if sum(L[:i+1]) >= r:
            return 1+i


@cached_function
def FaT(n):
    """
    The set of formula-binary trees only using addition gates
    which evaluates to the input integer n.

    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: FaT(3)
        [['+', 1, ['+', 1, 1]], ['+', ['+', 1, 1], 1]]


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    if n == 1:
        return [1]
    else :
        gu = []
        for i in range(1,n):
            gu = gu + [['+', g1, g2] for g1 in FaT(i) for g2 in FaT(n-i)]
        return gu


@cached_function
def FaPre(n):
    """
    The set of formula only using addition gates
    which evaluates to the input integer n in prefix notation.

    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: FaPre(3)
        ['+1+11', '++111']


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    return [T2Pre(g) for g in FaT(n)]


@cached_function
def FaP(n):
    """
    The set of formula only using addition gates
    which evaluates to the input integer n in postfix notation.

    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: FaP(3)
        ['11+1+', '111++']


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    return [T2P(g) for g in FaT(n)]


@cached_function
def Ca(n):
    """
    Outputs the number of formula-binary trees only using addition gates.

    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: Ca(3)
        2


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    if n == 1:
        return 1
    else :
        return sum([Ca(i)*Ca(n-i) for i in range(1,n)])


@cached_function
def LopFaT(n):
    """
    Outputs all the formula-binary trees only using addition
    but the first term of the addition is >= the second term

    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: LopFaT(3)
        [['+', ['+', 1, 1], 1]]


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    if n == 1:
        return [1]
    else :
        gu = []
        for i in range(1, 1+floor(n/2)):
            gu = gu + [['+', g1, g2] for g1 in LopFaT(n-i) for g2 in LopFaT(i)]
        return gu

@cached_function
def LopCa(n):
    """
    Outputs the number of formula-binary trees only using addition gates
    such that the first term of the addition is >= the second term.
    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: LopCa(3)
        1


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    if n == 1:
        return 1
    else :
        return sum([LopCa(i)*LopCa(n-i) for i in range(1,1+floor(n/2))])


def RaFaT(n):
    """
    Outputs a uniformly randomly chosen formula-binary tree
    which evaluate to the input integer n.
    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: RaFat(3)
        ['+', ['+', 1, 1], 1]


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    if n == 1:
        return 1
    else :
        # Rolling the Loaded Die.
        j = RollLD([Ca(i)*Ca(n-i) for i in range(1,n+1)])
        return ['+', RaFaT(j), RaFaT(n-j)]


def RaFaPre(n):
    """
    Outputs a uniformly randomly chosen formula-binary tree
    which evaluate to the input integer n in Prefix notation.
    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: RaFaPre(3)
        '+1+11'


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    return(T2Pre(RaFaT(n)))


def RaFaP(n):
    """
    Outputs a uniformly randomly chosen formula-binary tree
    which evaluate to the input integer n in Prefix notation.
    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: RaFaP(3)
        ['+', ['+', 1, 1], 1]


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    return(T2P(RaFaT(n)))


def RaLopFaT(n):
    """
    Outputs a uniformly randomly chosen formula-binary tree
    which evaluate to the input integer n such that the first
    term of the addition is >= the second term.
    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: RaLopFaT(3)
        ['+', ['+', 1, 1], 1]


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    if n == 1:
        return [1]
    else:
        # Rolling the Loaded Die.
        j = RollLD([LopCa(i)*LopCa(n-i) for i in range(1,2+floor(n/2))])
        return ['+', RaLopFaT(n-j), RaLopFaT(j)]


def RaLopFaPre(n):
    """
    Outputs a uniformly randomly chosen formula-binary tree
    which evaluate to the input integer n such that the first
    term of the addition is >= the second term in prefix notation.
    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: RaLopFaPre(3)
        ['+', ['+', 1, 1], 1]


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    return T2Pre(RaLopFaT(n))


def RaLopFaP(n):
    """
    Outputs a uniformly randomly chosen formula-binary tree
    which evaluate to the input integer n such that the first
    term of the addition is >= the second term in poistfix notation.
    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: RaLopFaP(3)
        ['+', ['+', 1, 1], 1]


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    return T2P(RaLopFaT(n))


def LopFaPre(n):
    """
    Outputs all the formula-binary tree
    which evaluate to the input integer n such that the first
    term of the addition is >= the second term in prefix notation.
    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: LopFaPre(3)
        ['+', ['+', 1, 1], 1]


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    return [T2Pre(f) for f in LopFaT(n)]


def LopFaP(n):
    """
    Outputs all the formula-binary tree
    which evaluate to the input integer n such that the first
    term of the addition is >= the second term in prefix notation.
    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: LopFaP(3)
        ['+', ['+', 1, 1], 1]


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    return [T2P(f) for f in LopFaT(n)]


def FamTa(n):
    """
    The set of formula-binary trees only using addition  and
    multiplication gates with the top gate being an addition
    gate which evaluates to the input integer n.

    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: FamTa(3)
        [['+', 1, ['+', 1, 1]], ['+', ['+', 1, 1], 1]]


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    if n == 1:
        return [1]
    else :
        gu = []
        for i in range(1,n):
            gu = gu + [['+', g1, g2] for g1 in FamT(i) for g2 in FamT(n-i)]
        return gu


@cached_function
def FamTm(n):
    """
    The set of formula-binary trees only using addition  and
    multiplication gates with the top gate being a multiplication
    gate which evaluates to the input integer n.

    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: FamTm(3)
        [['+', 1, ['+', 1, 1]], ['+', ['+', 1, 1], 1]]


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    if n == 1:
        return []
    else :
        gu = []
        for i in range(2,1+floor(n/2)):
            if mod(n,i) == 0:
                gu = gu + [['*', g1, g2] for g1 in FamT(i) for g2 in FamT(n/i)]
        return gu


def FamT(n):
    """
    The set of formula-binary trees only using addition and
    multiplication gates.

    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: FamT(6)
        [['+', 1, ['+', 1, 1]], ['+', ['+', 1, 1], 1]]


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    return FamTa(n) + FamTm(n)


@cached_function
def Cama(n):
    """
    Output the size of the set of formulas produced by the procedure FamTa(n).

    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: Cama(6)
        [['+', 1, ['+', 1, 1]], ['+', ['+', 1, 1], 1]]


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    if n==1:
        return 1
    else:
        return sum([Cam(i)*Cam(n-i) for i in range(1,n)])


@cached_function
def Camm(n):
    """
    Output the size of the set of formulas produced by the procedure FamTa(n).

    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: Camm(6)
        [['+', 1, ['+', 1, 1]], ['+', ['+', 1, 1], 1]]


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    return sum([Cam(i)*Cam(n/i) for i in range(2,1+floor(n/2)) if mod(n,i)==0])


@cached_function
def Cam(n):
    """
    Output the size of the set of formulas produced by the procedure FamTa(n).

    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: Cam(2)
        1


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    return Cama(n)+Camm(n)


def RaFamTa(n):
    """
    Outputs a formula-binary tree sampled uniformly at random
    which evaluates to the input integer n using only addition
    and multiplication gates.

    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: RaFamT(6)
        [['+', 1, ['+', 1, 1]], ['+', ['+', 1, 1], 1]]


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    if n==1:
        return 1
    else:
        j = RollLD([Cam(i)*Cam(n-i) for i in range(1,n)])
        return ['+', RaFamT(j), RaFamT(n-j)]


def RaFamTm(n):
    """
    Outputs a formula-binary tree sampled uniformly at random
    which evaluates to the input integer n using only addition
    and multiplication gates.

    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: RaFamT(6)
        [['+', 1, ['+', 1, 1]], ['+', ['+', 1, 1], 1]]


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    if not is_prime(n):
        lu = []
        L  = []
        for i in range(2,1+floor(n/2)):
            if mod(n,i)==0:
                lu.append(i)
                L.append(Cam(i)*Cam(n/i))
        j = RollLD(L)
        return ['*', RaFamT(lu[j-1]), RaFamT(n/lu[j-1])]


def RaFamT(n):
    """
    Outputs a formula-binary tree sampled uniformly at random
    which evaluates to the input integer n using only addition
    and multiplication gates.

    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: RaFamT(6)
        [['+', 1, ['+', 1, 1]], ['+', ['+', 1, 1], 1]]


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    if n==1:
        return 1
    else:
        i = RollLD([Cama(n),Camm(n)])
        if i==1:
            return RaFamTa(n)
        else :
            return RaFamTm(n)


@cached_function
def FamP(n):
    """
    Outputs the set of formula-binary tree written in postfix notation
    which evaluates to the input integer n using only addition
    and multiplication gates.

    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: FamP(6)
        [['+', 1, ['+', 1, 1]], ['+', ['+', 1, 1], 1]]


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    return [T2P(f) for f in FamT(n)]


@cached_function
def FamPre(n):
    """
    Outputs the set of formula-binary tree written in prefix notation
    which evaluates to the input integer n using only addition
    and multiplication gates.

    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: FamPre(6)
        [['+', 1, ['+', 1, 1]], ['+', ['+', 1, 1], 1]]


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    return [T2Pre(f) for f in FamT(n)]


def RaFamP(n):
    """
    Outputs a uniformly randomly sample formula-binary tree written
    in postfix notation which evaluates to the input integer n using
    only addition and multiplication gates.

    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: RaFamP(6)
        [['+', 1, ['+', 1, 1]], ['+', ['+', 1, 1], 1]]


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    return T2P(RaFamT(n))


def RaFamPre(n):
    """
    Outputs a uniformly randomly sample formula-binary tree written
    in prefix notation which evaluates to the input integer n using
    only addition and multiplication gates.

    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: RaFamPre(6)
        [['+', 1, ['+', 1, 1]], ['+', ['+', 1, 1], 1]]


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    return T2Pre(RaFamT(n))


@cached_function
def FameTa(n):
    """
    The set of formula-binary trees only using addition,
    multiplication, and exponentiation gates. The top gate
    being an addition gate and and the formula evaluates to
    the input integer n.

    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: FameTa(3)
        [['+', 1, ['+', 1, 1]], ['+', ['+', 1, 1], 1]]


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    if n == 1:
        return [1]
    else:
        gu = []
        for i in range(1,n):
            gu = gu + [['+', g1, g2] for g1 in FameT(i) for g2 in FameT(n-i)]
        return gu


@cached_function
def FameTm(n):
    """
    The set of formula-binary trees only using addition.
    multiplication and exponentiation gates with the top
    gate being a multiplication gate which evaluates to the
    input integer n.

    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: FameTm(6)
        [['*', ['+', 1, 1], ['+', 1, ['+', 1, 1]]],
         ['*', ['+', 1, 1], ['+', ['+', 1, 1], 1]],
         ['*', ['+', 1, ['+', 1, 1]], ['+', 1, 1]],
         ['*', ['+', ['+', 1, 1], 1], ['+', 1, 1]]]


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    if n == 1:
        return []
    else :
        gu = []
        for i in range(2,1+floor(n/2)):
            if mod(n,i) == 0:
                gu = gu + [['*', g1, g2] for g1 in FameT(i) for g2 in FameT(n/i)]
        return gu


@cached_function
def FameTe(n):
    """
    The set of formula-binary trees only using addition.
    multiplication and exponentiation gates with the top
    gate being an exponetiation gate which evaluates to the
    input integer n.

    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: FameTe(4)
        [['^', ['+', 1, 1], ['+', 1, 1]]]


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    if n == 1:
        return []
    else :
        gu = []
        for i in range(2,2+floor(log(n)/log(2))):
            if floor(n^(1/i)) == ceil(n^(1/i)):
                gu = gu + [['^', g1, g2] for g1 in FameT(i) for g2 in FameT(n^(1/i))]
        return gu


@cached_function
def FameT(n):
    """
    The set of formula-binary trees only using addition.
    multiplication and exponentiation gates which evaluates to the
    input integer n.

    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: FameT(3)
        [['+', 1, ['+', 1, 1]], ['+', ['+', 1, 1], 1]]


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    return FameTa(n) + FameTm(n) + FameTe(n)


@cached_function
def Camea(n):
    """
    Output the size of the set of formulas produced by the procedure FameTa(n).

    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: Camea(6)
        54


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    if n==1:
        return 1
    else:
        return sum([Came(i)*Came(n-i) for i in range(1,n)])


@cached_function
def Camem(n):
    """
    Output the size of the set of formulas produced by the procedure FameTm(n).

    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: Camem(6)
        4


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    return sum([Came(i)*Came(n/i) for i in range(2,1+floor(n/2)) if mod(n,i)==0])


@cached_function
def Camee(n):
    """
    Output the size of the set of formulas produced by the procedure FameTe(n).

    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: Camee(9)
        2


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    return sum([Came(i)*Came(n^(1/i)) for i in range(2,2+floor(log(n)/log(2))) if floor(n^(1/i)) == ceil(n^(1/i))])


@cached_function
def Came(n):
    """
    Output the size of the set of formulas produced by the procedure FameT(n).
    Which counts all monotone formula encodings evaluating using a combination
    of fanin two addition, multiplication and exponentiation gates which evaluates
    to the input integer n

    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: Came(6)
        58


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    return Camea(n)+Camem(n)+Camee(n)


def RaFameTa(n):
    """
    Output a Random Formula Tres chosen uniformly at random amoung all
    Tree representation of the positive integer n which use a combination
    of addition, multiplication and exponentiation gates with the top gate
    being the addition gate

    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: RaFameTa(6)
        [['+', 1, ['+', 1, 1]], ['+', ['+', 1, 1], 1]]


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    if n == 1:
        return 1
    else:
        j = RollLD([Came(i)*Came(n-i) for i in range(1,n)])
        return ['+', RaFameT(j), RaFameT(n-j)]
        
def RaFameTm(n):
    """
    Outputs a formula-binary tree sampled uniformly at random
    which evaluates to the input integer n using only addition
    and multiplication and exponentiaiton gates, with the top
    gate being a multiplication gate.

    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: RaFameT(9)
        ['*', ['+', ['+', 1, 1], 1], ['+', ['+', 1, 1], 1]]


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    if not is_prime(n):
        lu = []
        L  = []
        for i in range(2,1+floor(n/2)):
            if mod(n,i)==0:
                lu.append(i)
                L.append(Came(i)*Came(n/i))
        j = RollLD(L)
        return ['*', RaFameT(lu[j-1]), RaFameT(n/lu[j-1])]

def RaFameTe(n):
    """
    Outputs a formula-binary tree sampled uniformly at random
    which evaluates to the input integer n using only addition
    and multiplication and exponentiaiton gates, with the top
    gate being an exponentiation gate.

    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: RaFameTe(27)
        ['^', ['+', 1, ['+', 1, 1]], ['+', ['+', 1, 1], 1]]


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    if not is_prime(n) and n>1:
        lu = []
        L  = []
        for i in range(2,1+floor(n/2)):
            if floor(n^(1/i)) == ceil(n^(1/i)):
                lu.append(i)
                L.append(Came(i)*Came(n^(1/i)))
        j = RollLD(L)
        return ['^', RaFameT( n^(1/lu[j-1]) ), RaFameT(lu[j-1])]

def RaFameT(n):
    """
    Outputs a formula-binary tree sampled uniformly at random
    which evaluates to the input integer n using only addition
    multiplication and exponentiation gates.

    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: RaFameT(6)
        [['+', 1, ['+', 1, 1]], ['+', ['+', 1, 1], 1]]


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    if n==1:
        return 1
    else:
        i = RollLD([Camea(n),Camem(n),Camee(n)])
        if i==1:
            return RaFameTa(n)
        elif i==2:
            return RaFameTm(n)
        else :
            return RaFameTe(n)

def RaFameP(n):
    """
    Outputs a uniformly randomly sample formula-binary tree written
    in postfix notation which evaluates to the input integer n using
    only addition, multiplication and exponentiation gates.

    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: RaFameP(6)
        '111+11+*1++'


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    return T2P(RaFameT(n))


def RaFamePre(n):
    """
    Outputs a uniformly randomly sample formula-binary tree written
    in prefix notation which evaluates to the input integer n using
    only addition, multiplication  and exponentiation gates.

    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: RaFamePre(6)
        '*++111+11'


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    return T2Pre(RaFameT(n))


@cached_function
def ShortestTame(n):
    """
    Outputs the length and an example of the smallest binary-tree
    formula using addition, multiplication and exponentiation

    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: ShortestTame(2)
        ['+', 1, 1]


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    if n==1:
        return [1,1]
    else:
        aluf = []
        si = 2*n
        for i in range(1,n):
            T1 = ShortestTame(i)
            T2 = ShortestTame(n-i)
            if (T1[0]+T2[0]+1) < si:
                si = T1[0]+T2[0]+1
                if EvalT(T1[1]) <= EvalT(T2[1]):
                    aluf = ['+', T1[1], T2[1]]
                else:
                    aluf = ['+', T2[1], T1[1]]

        for i in range(2,floor(n/2)):
            if mod(n,i)==0:
                T1 = ShortestTame(i)
                T2 = ShortestTame(n/i)
                if (T1[0]+T2[0]+1) < si:
                    si = T1[0]+T2[0]+1
                    if EvalT(T1[1]) <= EvalT(T2[1]):
                        aluf = ['*', T1[1], T2[1]]
                    else:
                        aluf = ['*', T2[1], T1[1]]

        for i in range(2,2+floor(log(n)/log(2))):
            if floor(n^(1/i)) == ceil(n^(1/i)):
                T1 = ShortestTame(n^(1/i))
                T2 = ShortestTame(i)
                if (T1[0]+T2[0]+1) < si:
                    si = T1[0]+T2[0]+1
                    aluf = ['^', T1[1], T2[1]]
        return [si, aluf]

def get_permutation(la,lb):
    """
    Obtains a permutation list from two lists of the same size.
    No check is performed here the user must be very carefull
    to input lists of the same size
    
 
    EXAMPLES:
    ::
        sage: get_permutation([1, 2, 3, 4, 6, 8],[1, 2, 4, 8, 3, 6])
        [0, 1, 4, 2, 5, 3]

    AUTHORS:
    - Edinah K. Gnang
    - To Do: 
    """
    # Initializing the output
    L = list()

    # Loop performing the evaluation.
    for i1 in range(len(la)):
        for i2 in range(len(lb)):
            if la[i1] == lb[i2]:
                L.append(i2)
                break
    return L

def permute(l,p):
    """
    Permutes the entries of the list l according to the permutation p
    No check is performed here the user must be very carefull
    to input lists of the same size
 
    EXAMPLES:
    ::
        sage: permute([1, x, x^x, x^(x + 1), x + 1, (x + 1)*x],[0, 1, 4, 2, 5, 3])
        [1, x, x+1, x^x, x*(x+1), x^(x+1)]

    AUTHORS:
    - Edinah K. Gnang
    - To Do: 
    """
    # Initializing the output
    L = list()
    # Loop performing the evaluation.
    for i in range(len(l)):
        L.append(l[p[i]])
    return L


@cached_function
def NaiveZetaT(nbit):
    """
    Produces Tree associated with the Second Canonical Forms.

    ::
        sage: ZetaT(2)
        [[['+', 1, 1], ['+', 1, ['+', 1, 1]]],
         [1, ['+', 1, 1], ['+', 1, ['+', 1, 1]], ['^', ['+', 1, 1], ['+', 1, 1]]]]
    """

    # Initial conditions
    Pk = [['+',1,1]]
    Nk = [1] + Pk
    for it in range(1,nbit):
        L = []
        for p in Pk:
            if L == []:
                L = [1] + [p] + [['^',p,Nk[i]] for i in range(1,len(Nk))]

            else:
                Lp = [p] + [['^',p,Nk[i]] for i in range(1,len(Nk))]
                L  = L + [['*',L[i],n] for i in range(1,len(L)) for n in Lp] + Lp

        # Sorting the list
        Va = [EvalT(l) for l in L]
        Vb = copy(Va)
        Vb.sort()
        perm = get_permutation(Vb, Va)
        # Reinitialization of the list Nk
        Nk = permute(L, perm)
        # Set completion
        l = len(Nk)
        i = 0
        while i < l-1:
            if EvalT(Nk[i+1]) - EvalT(Nk[i]) == 2 :
                Pk.append(['+',1,Nk[i]])
                Nk.insert(i+1, ['+',1,Nk[i]])
                l = l+1
            else:
                i = i+1
    return [Pk, Nk]

@cached_function
def Goodstein(number_of_iterations=1):
    """
    Produces the set of symbolic expressions associated with the
    the first canonical form. In all the expressions the symbolic
    variable x stands for a short hand notation for the formula (1+1).

    ::
        sage: Goodstein(1)
        [1, x^x, x, x^x + 1, x + 1, x^x + x, x^x + x + 1]
    """
    # Initial condition of Initial set
    Ng0 = [1, x]

    # Main loop performing the iteration
    for iteration in range(number_of_iterations):
        # Implementation of the set recurrence
        Ng0 = [1] + [x^n for n in Ng0]
        # Initialization of a buffer list Ng1
        # which will store updates to Ng0
        Ng1 = []
        for n in Set(Ng0).subsets():
            if n.cardinality() > 0:
                Ng1.append(sum(n))
        Ng0 = list(Ng1)
    Nf = []
    for i in range(len(Ng0)):
        Nf.append([])
    for i in range(len(Nf)):
        Nf[(Ng0[i]).subs(x=2)-1].append(Ng0[i])
    Ng0=[]
    for i in range(len(Nf)):
        Ng0.append(Nf[i][0])
    return Ng0


@cached_function
def GoodsteinT(number_of_iterations=1):
    """
    Produces Tree associated with Goodstein Trees.

    ::
        sage: GoodsteinT(1)
       [1,
        ['+', 1, 1],
        ['^', ['+', 1, 1], ['+', 1, 1]],
        ['+', 1, ['+', 1, 1]],
        ['+', 1, ['^', ['+', 1, 1], ['+', 1, 1]]],
        ['+', ['+', 1, 1], ['^', ['+', 1, 1], ['+', 1, 1]]],
        ['+', ['+', 1, ['+', 1, 1]], ['^', ['+', 1, 1], ['+', 1, 1]]]] 
    """
    # Initial condition of Initial set
    Ng0 = [1, ['+',1,1]]
    # Main loop performing the iteration
    for iteration in range(number_of_iterations):
        # Implementation of the set recurrence
        Tmp = copy(Ng0)
        Tmp.pop(0)
        Ng0 = [1] + [['+',1,1]] + [['^',['+',1,1], m] for m in Tmp]
        # Initialization of a buffer list Ng1
        # which will store updates to Ng0
        Ng1 = []
        for n in Set(range(len(Ng0))).subsets():
            if n.cardinality() == 1:
                Ng1.append(Ng0[n[0]])
            elif n.cardinality() > 1:
                T = Ng0[n[0]]
                for j in range(1,n.cardinality()):
                    T = ['+', T, Ng0[n[j]]]
                Ng1.append(T)
        Ng0 = copy(Ng1)
    # Sorting the obtained list
    Nf = []
    for i in range(len(Ng0)):
        Nf.append([])
    for i in range(len(Nf)):
        Nf[EvalT(Ng0[i])-1].append(Ng0[i])
    Ng0=[]
    for i in range(len(Nf)):
        Ng0.append(Nf[i][0])
    return Ng0


def list_eval(l):
    """
    Perform the evaluation of the list to integers
 
    EXAMPLES:
    ::
        sage: var('x')
        sage: list_eval([1, x, x+1, x^x])
        [1,2,3,4]

    AUTHORS:
    - Edinah K. Gnang
    - To Do: 
    """
    # Initializing the output
    L = list()

    # Loop performing the evaluation.
    for i in range(len(l)):
        L.append(l[i].substitute(x=2))
   
    return L


def get_permutation(la,lb):
    """
    Obtains a permutation list from two lists of the same size.
    No check is performed here the user must be very carefull
    to input lists of the same size
    
 
    EXAMPLES:
    ::
        sage: get_permutation([1, 2, 3, 4, 6, 8],[1, 2, 4, 8, 3, 6])
        [0, 1, 4, 2, 5, 3]

    AUTHORS:
    - Edinah K. Gnang
    - To Do: 
    """
    # Initializing the output
    L = list()

    # Loop performing the evaluation.
    for i1 in range(len(la)):
        for i2 in range(len(lb)):
            if la[i1] == lb[i2]:
                L.append(i2)
                break
   
    return L

def permute(l,p):
    """
    Permutes the entries of the list l according to the permutation p
    No check is performed here the user must be very carefull
    to input lists of the same size
 
    EXAMPLES:
    ::
        sage: permute([1, x, x^x, x^(x + 1), x + 1, (x + 1)*x],[0, 1, 4, 2, 5, 3])
        [1, x, x+1, x^x, x*(x+1), x^(x+1)]

    AUTHORS:
    - Edinah K. Gnang
    - To Do: 
    """
    # Initializing the output
    L = list()

    # Loop performing the evaluation.
    for i in range(len(l)):
        L.append(l[p[i]])
   
    return L

@cached_function
def base2expansion(n):
    """
    Returns the polynomial encoding the binary expansion
     
    EXAMPLES: 
    The function is a crucial first step to the recursive encoding
    
    ::
        sage: p = base2expansion(10)
        sage: p
        x^3 + x

    AUTHORS:
    - Edinah K. Gnang
    -  
    """
    x = var('x')
    # polynomial
    p = 0
    k = 2
    if n == 1:
        return 1
    elif n > 1:
        while k < n:
            k = k^2
        if k == n:
            return x^(log(k,2))
        elif k > n:
            k = sqrt(k)
            while k < n:
                k = 2*k
                if k == n:
                    return x^(log(k,2))
                elif k > n:
                    p = x^(floor(log(k/2,2))) + base2expansion(n-k/2)
    return p

@cached_function
def base2expansionT(n):
    """
    Returns the polynomial encoding the binary expansion
     
    EXAMPLES: 
    The function is a crucial first step to the recursive encoding
    
    ::
        sage: p = base2expansionT(2)
        ['+',1,1]

    AUTHORS:
    - Edinah K. Gnang
    -  
    """
    x = var('x')
    # polynomial
    p = 0
    k = 2
    if n == 1:
        return 1
    elif n > 1:
        while k < n:
            k = k^2
        if k == n:
            return ['^',['+',1,1],log(k,2)]
        elif k > n:
            k = sqrt(k)
            while k < n:
                k = 2*k
                if k == n:
                    return ['^',['+',1,1],log(k,2)]
                elif k > n:
                    p = ['+',['^',['+',1,1],(floor(log(k/2,2)))],base2expansionT(n-k/2)]
    return p


@cached_function
def recurse_base2expansion(n):
    """
    Returns the Goodstein encoding of the input integer n
     
    EXAMPLES: 
    The function builds the crucial base2expansion function
    however it should be noted that it's a horrible idea
    to use this function to compute the recursive encoding
    for a list of consecutive integer the number of recursive
    call is unmanageabl
    
    ::
        sage: Lt = leading_term(x^(x^x+1)+x^x+x+1)
        sage: Lt
        x^(x^x+1)

    AUTHORS:
    - Edinah K. Gnang
    -  
    """
    # polynomial
    p = 0
    k = 2
    if n == 1:
        return 1
    elif n > 1:
        while k < n:
            k = k^2
    
        if k == n:
            return x^recurse_base2expansion(log(k,2))

        elif k > n:
            k = sqrt(k)
            while k < n:
                k = 2*k
                if k == n:
                    return x^recurse_base2expansion(log(k,2))
                elif k > n:
                    p = x^recurse_base2expansion(floor(log(k/2,2))) + recurse_base2expansion(n-k/2)
    return p

@cached_function
def recurse_base2expansionT(n):
    """
    Returns the Goodstein Tree encoding of the input integer n
     
    EXAMPLES: 
    The function builds the crucial base2expansion function
    however it should be noted that it's a horrible idea
    to use this function to compute the recursive encoding
    for a list of consecutive integer the number of recursive
    call is unmanageabl
    
    ::
        sage: recurse_base2expansionT(2)
        ['+',1,1]

    AUTHORS:
    - Edinah K. Gnang
    -  
    """
    # polynomial
    p = 0
    k = 2
    if n == 1:
        return 1
    elif n > 1:
        while k < n:
            k = k^2
    
        if k == n:
            return ['^',['+',1,1],recurse_base2expansionT(log(k,2))]

        elif k > n:
            k = sqrt(k)
            while k < n:
                k = 2*k
                if k == n:
                    return ['^',['+',1,1],recurse_base2expansionT(log(k,2))]
                elif k > n:
                    p = ['+',['^',['+',1,1],recurse_base2expansionT(floor(log(k/2,2)))],recurse_base2expansionT(n-k/2)]
    return p

def N_1_k_plus_1(Nk, Pk, k):
    L = []
    for q in Pk: 
        for n in range(floor(N(ln(2^(k+1)))/N(ln(q.subs(x=2)))), floor(N(ln(2^(k+2)))/N(ln(q.subs(x=2))))):
            L.append(q^Nk[n])
    return L

def generate_factor_script(c):
    """
    Creates a file N_c_kplus1.sage which contains a sage script which is responsible 
    for generating the c-prime-factors integers.
 
    EXAMPLE:
 
    ::
        sage: generate_factor_script(2)
        1
        sage: cat N_2_kplus1.sage
        def N_2_k_plus_1(Nk, Pk, k):
            L = []
            for p0 in Pk: 
                for n0 in range(floor(ln(2^(k+2))/ln(p0.subs(x=2)))):
                    for p1 in Pk[Pk.index(p0)+1:]:
                        if floor(ln(2^(k+1)/(p0^Nk[n0]).subs(x=2))/ln(p1.subs(x=2)))>=0:
                            for n1 in range(floor(ln(2^(k+1)/(p0^Nk[n0]).subs(x=2))/ln(p1.subs(x=2))), floor(ln(2^(k+2)/(p0^Nk[n0]).subs(x=2))/ln(p1.subs(x=2)))):
                                L.append(p0^Nk[n0]*p1^Nk[n1])
            return L

    AUTHORS:
    - Edinah K. Gnang
    - To Do: 
    """
    # Creating the string corresponding to the file name
    filename = 'N_'+str(c)+'_kplus1.sage'

    # Opening the file
    f = open(filename,'w')
    f.write('def N_'+str(c)+'_k_plus_1(Nk, Pk, k):\n')
    f.write('    L = []\n')
    # variable storing the spaces
    sp = ''
    for i in range(c):
        if i<1:
            sp=sp+'    '
            f.write(sp+'for p'+str(i)+' in Pk:\n')
            sp=sp+'    '
            f.write(sp+'for n'+str(i)+' in range(floor(N(ln(2^(k+2)))/N(ln(p'+str(i)+'.subs(x=2))))):\n' )
        elif i==c-1:
            sp=sp+'    '
            f.write(sp+'for p'+str(i)+' in Pk[Pk.index(p'+str(i-1)+')+1:]:\n')
            sp=sp+'    '
            dv = ''
            for d in range(i):
                # string keeping track of the divisors
                if d == i-1:
                    dv=dv+'(p'+str(i-1)+'^Nk[n'+str(i-1)+']).subs(x=2)'
                else:
                    dv=dv+'(p'+str(d)+'^Nk[n'+str(d)+']).subs(x=2)*'
            f.write(sp+'if floor(N(ln(2^(k+1)/('+dv+')))/N(ln(p'+str(i)+'.subs(x=2))))>=0:\n')
            sp=sp+'    '
            f.write(sp+'for n'+str(i)+' in range(floor(N(ln(2^(k+1)/('+dv+')))/N(ln(p'+str(i)+'.subs(x=2)))),floor(N(ln(2^(k+2)/('+dv+')))/N(ln(p'+str(i)+'.subs(x=2))))):\n')
            sp=sp+'    '
            mt = ''
            for d in range(c):
                # string keeping track of the symbolic SCF expression 
                if d == c-1:
                    mt=mt+'p'+str(c-1)+'^Nk[n'+str(c-1)+']'
                else:
                    mt=mt+'p'+str(d)+'^Nk[n'+str(d)+']*'
            f.write(sp+'L.append('+mt+')\n    return L')
        else:
            sp=sp+'    '
            f.write(sp+'for p'+str(i)+' in Pk[Pk.index(p'+str(i-1)+')+1:]:\n')
            sp=sp+'    '
            dv = ''
            for d in range(i):
                # string keeping track of the divisors
                if d==i-1:
                    dv=dv+'(p'+str(i-1)+'^Nk[n'+str(i-1)+']).subs(x=2)'
                else:
                    dv=dv+'(p'+str(d)+'^Nk[n'+str(d)+']).subs(x=2)*'
            f.write(sp+'for n'+str(i)+' in range(floor(N(ln(2^(k+2)/('+dv+')))/N(ln(p'+str(i)+'.subs(x=2))))):\n')
    # Closing the file
    f.close()

@cached_function
def imprvdzetarecursion(nbitr):
    # Defining the symbolic variables x which corresponds
    # to shorthand notation for (1+1).
    var('x')

    # Initial conditions for the zeta recursion.
    # Initial list of primes in SCF encoding
    Pi = [x]
    # Initial list of expression associated with the SCF
    # integer encoding.
    Ni = [1] + Pi
    if nbitr == 0:
        return [Ni, Pi, i] 
 
    # The first iteration properly starts here
    i = 0
    Rb = []
    Rb.append(Ni[len(Ni)-1])
    Rb = Rb + N_1_k_plus_1(Ni, Pi, i) 
    # Sorting the obtainted list 
    Tmp = []
    for f in range(2^(i+1),2^(i+2)+1):
        Tmp.append([])
    for f in Rb:
        Tmp[-2^(i+1)+f.subs(x=2)].append(f)
    # Filling up Rb in order
    Rb = []
    for f in range(len(Tmp)):
        if len(Tmp[f]) == 1:
            Rb.append(Tmp[f][0])
        else:
            Rb.append(Tmp[f-1][0]+1)
            Pi.append(Tmp[f-1][0]+1)
    Ni = list(Ni+Rb[1:])
    if nbitr == 1:
        return [Ni, Pi, i] 
    for i in range(1, nbitr+1):
        print 'Iteration number '+str(i)
        Rb = []
        Rb.append(Ni[len(Ni)-1])
        Rb = Rb + N_1_k_plus_1(Ni, Pi, i)
        # Code for going beyound a single prime factors 
        #prm = 2*3
        prm = 6
        c = 2
        while  prm < 2^(i+2):
            generate_factor_script(c)
            load('N_'+str(c)+'_kplus1.sage')
            Rb = Rb + eval("N_"+str(c)+"_k_plus_1(Ni, Pi, i)")
            # Since ironically c indexes the next prime we have 
            prm = prm*Integer((Pi[c-1]).subs(x=2))
            c = c+1
        # Sorting the obtainted list 
        Tmp = []
        for f in range(2^(i+1),2^(i+2)+1):
            Tmp.append([])
        for f in Rb:
            Tmp[-2^(i+1)+f.subs(x=2)].append(f)
        # Filling up Rb in order
        Rb = []
        for f in range(len(Tmp)):
            if len(Tmp[f]) == 1:
                Rb.append(Tmp[f][0])
            else:
                Rb.append(Tmp[f-1][0]+1)
                Pi.append(Tmp[f-1][0]+1)
        Ni = list(Ni+Rb[1:])
    return [Ni, Pi, i]

@cached_function
def Fa3T(n):
    """
    The set of formula-binary trees only using fan-in three addition gates
    which evaluates to the input integer n.

    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: Fa3T(3)
        [['+', 1, 1, 1]]]

    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    if n == 1:
        return [1]
    else :
        gu = []
        for i in range(1,n,2):
            for j in range(1,n-i,2):
                gu = gu + [['+', g1, g2, g3] for g1 in Fa3T(i) for g2 in Fa3T(j) for g3 in Fa3T(n-i-j)]
        return gu

@cached_function
def Ca3(n):
    """
    Outputs the number of formula-binary trees only using fan-in three addition gates.
    This is a special  case of the Fuss-Catalan sequence.

    EXAMPLES:
    The input n must be greater than 0
    ::
        sage: Ca3(3)
        1


    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    if n == 1 :
        return 1
    else :
        return sum([Ca3(i)*Ca3(j)*Ca3(n-i-j) for i in range(1,n,2) for j in range(1,n-i,2)])

def Zeta(nbitr):
    """
    Produces Tree associated with the Second Canonical Forms.
    Implements an improved version of the zeta recurrence and
    the combinatorial tower sieve.
    ::
        sage: Zeta(2)
        [[['+', 1, 1], ['+', 1, ['+', 1, 1]]],
         [1, ['+', 1, 1], ['+', 1, ['+', 1, 1]], ['^', ['+', 1, 1], ['+', 1, 1]]]]
    """
    x = var('x')
    
    # Pr corresponds to the initial list of primes
    Pr = [x]
    
    # Nu corresponds to the initial list of integer
    NuC  = [1,x]
    TNuC = [1,x]
    
    # Initializing the upper and lower bound
    upr_bnd = 2^2
    lwr_bnd = 2
    
    # Computing the set recurrence
    for itr in range(nbitr):
        for jtr in range(log(upr_bnd,2)-log(lwr_bnd,2)):
            TpNu = [1]
            for p in Pr:
                TpNu=TpNu+[m*pn for m in TpNu for pn in [p^n for n in NuC if (p^n).subs(x=2)<=2^(log(lwr_bnd,2)+jtr+1)] if (m*pn).subs(x=2)<=2^(log(lwr_bnd,2)+jtr+1)]
            # Keeping only the elements within the range of the upper and lower bound
            Nu = [f for f in TpNu if (2^(log(lwr_bnd,2)+jtr)<f.subs(x=2) and f.subs(x=2)<=2^(log(lwr_bnd,2)+jtr+1))]

            print '\nThe current iteration will uncover '+str(2^(N(log(lwr_bnd,2))+jtr+1)-2^(N(log(lwr_bnd,2))+jtr)-len(Nu))+' new primes in the range ['+str(2^(N(log(lwr_bnd,2))+jtr))+', '+str(2^(N(log(lwr_bnd,2))+jtr+1))+']'

            # Obtaining the corresponding sorted integer list
            la = [f.subs(x=2) for f in Nu]; lb = copy(la); lb.sort()
            # Obtaining the sorting permutation
            perm = []
            for i1 in range(len(la)):
                for i2 in range(len(lb)):
                    if lb[i1]==la[i2]:
                        perm.append(i2)
                        break
            # Sorting the list using the obtained permutation
            Nu = [Nu[perm[j]] for j in range(len(Nu))]
            # Computing the set completion
            TNuC = TNuC + Nu
            l = len(TNuC)
            i = 2^(log(lwr_bnd,2)+jtr-1)
            while i<l-1:
                if(TNuC[i+1].subs(x=2)-TNuC[i].subs(x=2)==2):
                    Pr.append(TNuC[i]+1)
                    TNuC.insert(i+1,TNuC[i]+1)
                    l=l+1
                else:
                    i=i+1
        # Updating the list of integers
        NuC = TNuC
        # Updating the upper and lower bound
        lwr_bnd = upr_bnd
        upr_bnd = 2^upr_bnd
    return [Pr,NuC]        


@cached_function
def ZetaT(nbitr):
    """
    Produces Tree associated with the Second Canonical Forms.
    Implements an improved version of the zeta recurrence and
    the combinatorial tower sieve.
    ::
        sage: ZetaT(2)
        [[['+', 1, 1], ['+', 1, ['+', 1, 1]]],
         [1, ['+', 1, 1], ['+', 1, ['+', 1, 1]], ['^', ['+', 1, 1], ['+', 1, 1]]]]
    """

    # Pr corresponds to the initial list of primes
    Pr = [ ['+',1,1] ]

    # Nu corresponds to the initial list of integer
    NuC  = [1] + Pr
    TNuC = [1] + Pr

    # Initializing the upper and lower bound
    upr_bnd = 2^2
    lwr_bnd = 2

    # Computing the set recurrence
    for itr in range(nbitr):
        for jtr in range(log(upr_bnd,2)-log(lwr_bnd,2)):
            TpNu = [1]
            for p in Pr:
                TpNu = TpNu+[pn for pn in [['^',p,n] for n in NuC if EvalT(['^',p,n])<=2^(log(lwr_bnd,2)+jtr+1)]]+[['*',m,pn] for m in TpNu[1:] for pn in [['^',p,n] for n in NuC if EvalT(['^',p,n])<=2^(log(lwr_bnd,2)+jtr+1)]  if EvalT(['*',m,pn])<=2^(log(lwr_bnd,2)+jtr+1)]
            # Keeping only the elements within the range of the upper and lower bound
            Nu = [f for f in TpNu if (2^(log(lwr_bnd,2)+jtr)<EvalT(f) and EvalT(f)<=2^(log(lwr_bnd,2)+jtr+1))] 

            print '\nThe current iteration will uncover '+str(2^(N(log(lwr_bnd,2))+jtr+1)-2^(N(log(lwr_bnd,2))+jtr)-len(Nu))+' new primes in the range ['+str(2^(N(log(lwr_bnd,2))+jtr))+', '+str(2^(N(log(lwr_bnd,2))+jtr+1))+']'
            # Obtaining the corresponding sorted integer list
            la = [EvalT(f) for f in Nu]; lb = copy(la); lb.sort()
            # Obtaining the sorting permutation
            perm = []
            for i1 in range(len(la)):
                for i2 in range(len(lb)):
                    if lb[i1]==la[i2]:
                        perm.append(i2)
                        break
            # Sorting the list using the obtained permutation
            Nu = [Nu[perm[j]] for j in range(len(Nu))]
            # Perfoming the set completion
            TNuC = TNuC + Nu
            l = len(TNuC)
            i = 2^(log(lwr_bnd,2)+jtr-1)
            while i<l-1:
                if(EvalT(TNuC[i+1])-EvalT(TNuC[i])==2):
                    Pr.append(['+',1,TNuC[i]])
                    TNuC.insert(i+1,['+',1,TNuC[i]])
                    l=l+1
                else:
                    i=i+1
        # Updating the list of integers
        NuC = TNuC
        # Updating the upper and lower bound
        lwr_bnd = upr_bnd
        upr_bnd = 2^upr_bnd
    return [Pr,NuC]        

def Horner(nbitr):
    x = var('x')
    Nk  = [1, x, 1+x, x^x]
    # Initialization of the lists
    LEk = [x^x]
    LOk = [1+x]
    LPk = [x, x^x]
    # Main loop computing the encoding
    for i in range(nbitr):
        # Updating the list
        LEkp1 = [lp*lo for lp in LPk for lo in LOk] + [x^m for m in LEk+LOk]
        LOkp1 = [n+1 for n in LEk]
        LPkp1 = LPk + [x^m for m in LEk+LOk]
        # The New replaces the old
        Nk = Nk + LEkp1+LOkp1
        LEk = LEkp1
        LOk = LOkp1
        LPk = LPkp1
    return Nk

def HornerT(nbitr):
    # Initial set
    Nk  = [ 1, ['+',1,1], ['+',1,['+',1,1]], ['^',['+',1,1],['+',1,1]] ]
    # Initialization of the lists
    LEk = [ ['^',['+',1,1],['+',1,1]] ]
    LOk = [ ['+',1,['+',1,1]] ]
    LPk = [ ['+',1,1], ['^',['+',1,1],['+',1,1]] ]
    # Main loop computing the recursive horner encoding
    for i in range(nbitr):
        # Updating the list
        LEkp1 = [['*',lp,lo] for lp in LPk for lo in LOk] + [['^',['+',1,1],m] for m in LEk+LOk]
        LOkp1 = [['+',1,n] for n in LEk]
        LPkp1 = LPk + [['^',['+',1,1],m] for m in LEk+LOk]
        # The New replaces the old
        Nk = Nk+LEkp1+LOkp1
        LEk = LEkp1
        LOk = LOkp1
        LPk = LPkp1
    return Nk

def EvalT(T):
    """
    Outputs the evaluation value of a tree.

    EXAMPLES:
    ::
        sage: EvalT([['+', 1, ['+', 1, 1]], ['+', ['+', 1, 1], 1]])
        6

    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger
    """
    if T == 1:
        return 1
    elif T == -1:
        return -1
    elif T[0] == '+':
        return EvalT(T[1]) + EvalT(T[2])
    elif T[0] == '*':
        return EvalT(T[1]) * EvalT(T[2])
    elif T[0] == '^':
        return EvalT(T[1]) ^ EvalT(T[2])
    else:
        print 'IMPROPER INPUT !!!'

def NonMonotoneFormula(n):
    """
    Outputs non-monotone formula encodings of length at most n.

    EXAMPLES:
    ::
        sage: NonMontoneFormula(3)
        [[], [1,-1], []]

    AUTHORS:
    - Edinah K. Gnang and Doron Zeilberger

    To Do :
    - Try to implement faster version of this procedure

    """
    if n<=3:
        return [[], [1,-1], [], []]
    elif n>3:
        # Initialization of the list of formula.
        A=[[], [1,-1]] + [[] for t in range(n-1)]
        # Main loop.
        for sz in range(3,n+1):
            # Initialization of the fifth entry
            for o in ['+', '*', '^']:
                for i in range(1,sz):
                        A[sz]=A[sz]+[[o,s,t] for s in A[i] for t in A[sz-i-1] if (len(A[i])>0) and (len(A[sz-i-1])>0)]
        return A 
