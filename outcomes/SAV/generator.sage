# globally set display of matrices
latex.matrix_delimiters("[", "]")
latex.matrix_column_alignment("c")

#Typeset a linear combination without simplifying, as Sage likes to do automatically
class linearCombination(SageObject):    
    def __init__(self,coeffs,vecs,parentheses=false):
        self.coefficients=[]
        self.vectors=[]
        self.length=min(len(coeffs),len(vecs))
        for i in range(0,self.length):
            self.coefficients.append(coeffs[i])
            self.vectors.append(vecs[i])
        self.parentheses=parentheses
 
    def _latex_(self):
        string=""
        for i in range(0,self.length-1):
            string+= latex(self.coefficients[i])
            if self.parentheses:
                string+= r"\left("+latex(self.vectors[i])+r"\right)"
            else: 
                string+=latex(self.vectors[i])
            string+="+"
        string+= latex(self.coefficients[-1])
        if self.parentheses:
            string+= r"\left("+latex(self.vectors[-1])+r"\right)"
        else: 
            string+=latex(self.vectors[-1])
        return string


class Generator(BaseGenerator):
    def data(self):

        #linear combo
        rows = 4
        columns = 4
        number_of_pivots = 3
        a,b,c,d = var("a b c d")
        ls = [a,b,c,d][:rows]
        A = CheckIt.simple_random_matrix_of_rank(number_of_pivots,rows=rows,columns=columns)
        coeffs = [
            randrange(1,4)*choice([-1,1])
            for _ in range(columns)
        ]
        lin_combo = sum([
            coeffs[p]*A.column(p)
            for p in A.pivots()
        ])
        lin_combo_exp = linearCombination(
            [
                coeffs[A.pivots()[i]]
                for i in range(number_of_pivots)
            ],
            [
                column_matrix(A.column(A.pivots()[i]))
                for i in range(number_of_pivots)
            ],
        )
        position = randrange(0,4)
        return {
            "lin_combo_exp": lin_combo_exp,
            "target": ls[position],
            "value": lin_combo[position]
            
        }