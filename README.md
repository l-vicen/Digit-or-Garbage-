# How many digits can I rely on?

## Problem Statement

For very big or very small inputs ($x$), how does the function value $f(x)$ behave? This analysis is independent of performing the calculations for analyzing the condition of $f$.

### Assumption

Subtraction is an arithmetic operation that erases information (because it is ill-conditioned).

### Original Function

The function is defined as:

$$f(x) = \sqrt{x} - \sqrt{x+1}$$

### Improved Formulation

Using algebra, we can transform the ill-conditioned problem into a better form that avoids subtraction:

$$f(x) = \sqrt{x} - \sqrt{x+1} = \frac{-1}{\sqrt{x} + \sqrt{x+1}}$$

This new form uses only well-conditioned arithmetic operations ($+, \times, /, \sqrt{}$).

---

## Example with Input $x = 80000000$

- **Ill-conditioned formulation:**  
  $f_{\text{original}} = \sqrt{x} - \sqrt{x+1} = -0.00005590169894276187$
- **Well-conditioned formulation:**  
  $f_{\text{well-cond.}} = \frac{-1}{\sqrt{x} + \sqrt{x+1}} = -0.00005590169926280193$

### Digit Analysis

- **Ill-conditioned:**  
  Out of the 16 available decimal digits, 5 digits are erased, leaving 11 reliable digits: $-0.0000559016$.
  
- **Well-conditioned:**  
  Similarly, 5 digits are erased, leaving 11 reliable digits: $-0.0000559016$.

### Observations

- The difference between the two formulations is:  
  $$\text{diff} = |f_{\text{original}} - f_{\text{well-cond.}}| = 3.2004 \times 10^{-13}$$  
  This means the results start to diverge from the 13th digit onward.

---

## Final Experiment

### Input $x = 8 \times 10^{23}$

For this truly huge value of $x$, we observe:

1. **Ill-conditioned formulation:**  
   No single digit is reliable for $f_{\text{original}}$.
2. **Well-conditioned formulation:**  
   Reliable digits decrease, but meaningful results are still obtained with $(16 - 8 = 8)$ reliable digits.

### Threshold Input

For $x = 8 \times 10^{14}$, the last value of $x$ that retains 8 reliable digits is:

- **Ill-conditioned formulation:**  
  $(16 - 8 = 8)$ reliable digits.  
- **Well-conditioned formulation:**  
  Still returns meaningful results with $(16 - 8 = 8)$ reliable digits.

---

## Conclusion

The number of reliable digits decreases with increasing input size, but the well-conditioned formulation of $f$ consistently outperforms the ill-conditioned version for very large values of $x$.

