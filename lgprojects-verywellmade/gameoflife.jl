using Plots
using Random

function findNextGen(mat) # Credit to geeksforgeeks for the python version. Adapted to Julia.
    m, n = size(mat)
    
    nextGen = zeros(Int, m, n)

    directions = [(0, 1), (1, 0), (0, -1), (-1, 0),
                  (1, 1), (-1, -1), (1, -1), (-1, 1)]

    for i in 1:m
        for j in 1:n
            live = 0

            for (dx, dy) in directions
                x, y = i + dx, j + dy
                if 1 <= x <= m && 1 <= y <= n && mat[x, y] == 1
                    live += 1
                end
            end

            if mat[i, j] == 1 && (live < 2 || live > 3)
                nextGen[i, j] = 0
            elseif mat[i, j] == 0 && live == 3
                nextGen[i, j] = 1
            else
                nextGen[i, j] = mat[i, j]
            end
        end
    end

    return nextGen
end

function runAndGenerateGIF()
    Random.seed!(42) 
    mat = rand([0, 1], 100, 100)

    anim = @animate for i in 1:200
        heatmap(mat, clim=(0, 1), color=:greys, legend=false, axis=false, 
                title="Conway's Game of Life - Generation $i")
        mat = findNextGen(mat)
    end

    gif(anim, "gameoflife.gif", fps=10)
end