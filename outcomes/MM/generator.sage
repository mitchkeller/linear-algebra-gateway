# globally set display of matrices
latex.matrix_delimiters("[", "]")
latex.matrix_column_alignment("c")

class Generator(BaseGenerator):
    def data(self):
        # shuffle 2,3,4,5 to get dimensions
        dims = [2,3,4]
        shuffle(dims)

        # create matrices. only first two are multiply-able
        m = list(zip([
            random_matrix(QQ,dims[0],dims[1],algorithm='echelonizable',rank=min(dims[0],dims[1]),upper_bound=7),
            random_matrix(QQ,dims[1],dims[2],algorithm='echelonizable',rank=min(dims[1],dims[2]),upper_bound=7)
        ],["A","B"]))
        #shuffle(m)

        matrices, indices = zip(*m)

        letters = ["A","B"]

        #productName = letters[indices.index("L")] + letters[indices.index("R")]
        product = matrices[0] * matrices[1]

        matrixSpots = dims[0]*dims[2]
        entries = [var("a"),var("b"),var("c"),var("d"),var("ze",latex_name="e"),
                   var("f"),var("g"),var("h"),var("i"),var("j"),
                   var("k"),var("l"),var("m"),var("n"),var("o"),var("p")]
        ABTemplate = matrix(SR,dims[0],dims[2],entries[0:dims[0]*dims[2]])
        row = randrange(0,dims[0])
        column = randrange(0,dims[2])
        return {
            "A": matrices[0],
            "B": matrices[1],
            "ABTemplate": ABTemplate,
            "target": ABTemplate[row][column],
            "value": product[row][column]
        }