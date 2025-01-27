### A Pluto.jl notebook ###
# v0.19.46

using Markdown
using InteractiveUtils

# ╔═╡ 8f4a063a-bd23-46ef-a6b0-51781c3f0e08
md"""
# How many digits can I rely on?
"""

# ╔═╡ f986fd6e-852e-4bb6-85d8-aa33cd771fb1
md"""
For very big or very small inputs ($x$), how does the the function value $f(x)$ behave? Independent of doing the calculations for analysing the condition of $f$.

- **"Assumption"**: Subtraction is an arithmetic operation that erases information (because it is ill-conditioned).

- Function in its original-form and under the prev. assumption (ill-conditioned). 

$$f(x) = \sqrt x - \sqrt{x+1}$$

"""

# ╔═╡ 7031d67e-dca4-11ef-3a00-ad67b61e98b6
# (Big) Input 
x = 80000000

# ╔═╡ b9235597-308f-4874-ae69-42cd9ce9779a
f_x_original = sqrt(x) - sqrt(1+x)

# ╔═╡ 85a520c5-a28e-422f-a4d2-58917e51ee4e
md"""
With some algebra trick, we can transform the ill-conditioned problem into a better form (i.e. one that does not rely on the subtraction arith. operator, preferebly using $\{+, x, /, \sqrt{} \}$ since they are well-conditioned arith. operators: $\kappa(\cdot) =  \{\frac{1}{2}, 1\} \quad \forall (\cdot) \in \{+, x, /, \sqrt{} \}$.

$$f(x) = \sqrt x - \sqrt{x+1} = (\sqrt x - \sqrt{x+1}) \cdot \frac{(\sqrt x + \sqrt{x+1})}{(\sqrt x + \sqrt{x+1})} = \frac{-1}{\sqrt x + \sqrt{x+1}}$$

"""

# ╔═╡ d364642c-a0f6-470d-8989-0970bc74ac5f
f_x_well_cond = (-1/(sqrt(x) + sqrt(x+1)))

# ╔═╡ 9abb4498-f063-4981-8267-2e5a25f6d09d
diff = abs(f_x_original - f_x_well_cond)

# ╔═╡ 59c18b67-bcce-4c75-974f-3ed83dc2734d
md"""
## Digit Analysis

Now, how many digits can I rely on for $f_{original}$? 

- We are using IEEE double precision, so there are 16 decimal digits available.

- For the input $x = 80000000$, the computer sees it as $x_{computer} = 8*10^7$
- The ill-conditioned formulation of $f_{original-computer} = -5.590169894276187e-5$, which for us humans is  $f_{original} = -0.00005590169894276187$.

Now, out of the 16 available digits we observe that 5 digits have been erased (i.e. equal to zero, 1 before the comma and 4 after the comma), $16 - 5 = 11$, hence there are only $11$ reliable digits.

Reasonable part of the output for the ill-conditioned formulation of $f$ is  $-0.0000559016$, the remaining digits are trash (i.e. $...9894276187$).

--- 

Now, how many digits can I rely on for $f_{well-cond.}$?

- The well-conditioned formulation gives $f_{well-cond.} = -5.590169926280193e-5$, which for us humans is  $f_{well-cond.} = -0.00005590169926280193$.

Now, out of the 16 available digits we observe that 5 digits have been erased (i.e. equal to zero, 1 before the comma and 4 after the comma), $16 - 5 = 11$, hence there are only $11$ reliable digits.

Reasonable part of the output for the well-conditioned formulation of $f$ is  $-0.0000559016$, the remaining digits are trash (i.e. $...9926280193$).

- Finally, observe that, $diff = | f_{original-computer} - f_{well-cond.} | = 3.2004006243107133e-13$, means that from digit 13th onwards that the $f$ values differ.

---

## Conclusion

The amount of digits I can rely on does not change for the input $x=80000000$, yet we see some small differences appear across the different formulations of $f$.
"""

# ╔═╡ 039e69f7-2d72-46f0-afb4-f3c2bc36557c
md"""
## Final Experiment

Let $x$ be truely huge, say $x=8*10^{23}$. Now, by comparing the ill- against the well-condition formulation of $f$, we observe that for very big values of $x$ no single digit is reliable for $f_{original}$. 

The last value of $x$ that gives ($16 - 8 = 8$) reliable digits is $x_{last-power}=8*10^{14}$. From the 15th power onwards, no single digit is reliable for the original formulation of $f$, contrary to $f_{well-cond.}$ which still returns a meaningful result, now with only $(16 - 8 = 8)$ reliable digits. 
"""

# ╔═╡ 940ed494-434b-40b7-839c-32692216025b
md""" #### Inputs """

# ╔═╡ 97359e71-19d4-48dd-ab9b-397d38cb3ce9
x_bigger = 800000000000000000000000

# ╔═╡ 96d23fd9-8116-4b4a-a5ee-1e925aab27dd
x_last_power = 800000000000000

# ╔═╡ 6dc348bb-57f2-439d-a069-a5026b54807a
md""" #### 1st Test """

# ╔═╡ 44e26c59-cb2a-48a8-9d14-afad991daf2d
f_x_original_last_power = sqrt(x_last_power) - sqrt(1+x_last_power)

# ╔═╡ 6cc57f63-e724-426c-b60c-9aefa7dd0512
f_x_well_cond_last_power = (-1/(sqrt(x_last_power) + sqrt(x_last_power+1)))

# ╔═╡ 5a06d3ab-4ce8-4920-8efd-b39e017d6377
diff_last_power = abs(f_x_original_last_power-f_x_original_last_power)

# ╔═╡ f3f0c465-a4f6-4c75-91ce-1ec6e56edd9f
md""" #### 2nd Test """

# ╔═╡ 0edee82f-56c5-42b8-b8a7-35dd3ce31606
f_x_original_bigger = sqrt(x_bigger) - sqrt(1+x_bigger)

# ╔═╡ 3e3a3ec0-d464-46b2-a023-eefd6c365e09
f_x_well_cond_bigger = (-1/(sqrt(x_bigger) + sqrt(x_bigger+1)))

# ╔═╡ 6abdea29-8b5a-4fce-8d71-b99c1f3e73bd
diff_bigger = abs(f_x_original_bigger-f_x_well_cond_bigger)

# ╔═╡ Cell order:
# ╠═8f4a063a-bd23-46ef-a6b0-51781c3f0e08
# ╠═f986fd6e-852e-4bb6-85d8-aa33cd771fb1
# ╠═7031d67e-dca4-11ef-3a00-ad67b61e98b6
# ╠═b9235597-308f-4874-ae69-42cd9ce9779a
# ╠═85a520c5-a28e-422f-a4d2-58917e51ee4e
# ╠═d364642c-a0f6-470d-8989-0970bc74ac5f
# ╠═9abb4498-f063-4981-8267-2e5a25f6d09d
# ╠═59c18b67-bcce-4c75-974f-3ed83dc2734d
# ╠═039e69f7-2d72-46f0-afb4-f3c2bc36557c
# ╠═940ed494-434b-40b7-839c-32692216025b
# ╠═97359e71-19d4-48dd-ab9b-397d38cb3ce9
# ╠═96d23fd9-8116-4b4a-a5ee-1e925aab27dd
# ╠═6dc348bb-57f2-439d-a069-a5026b54807a
# ╠═44e26c59-cb2a-48a8-9d14-afad991daf2d
# ╠═6cc57f63-e724-426c-b60c-9aefa7dd0512
# ╠═5a06d3ab-4ce8-4920-8efd-b39e017d6377
# ╠═f3f0c465-a4f6-4c75-91ce-1ec6e56edd9f
# ╠═0edee82f-56c5-42b8-b8a7-35dd3ce31606
# ╠═3e3a3ec0-d464-46b2-a023-eefd6c365e09
# ╠═6abdea29-8b5a-4fce-8d71-b99c1f3e73bd
