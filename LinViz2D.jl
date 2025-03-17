using Statistics
using LinearAlgebra
using LaTeXStrings
using Plots

c = palette(:default)

# 좌표축을 그려주는 함수
function grid(x::Int64, y::Int64;show = [-x, x, -y, y] ,bg="black",gc = c[1], grid = true,showaxis = true, size = (800, 600), dpi = 100)
    gr(size=size, dpi=dpi)
    c = palette(:default)
    # 한계 설정
    # vertical limit
    a1 = collect(-x:x)
    a2 = ones(length(a1))*y
    a3 = ones(length(a2))*(-y)

    # horizontal limit 
    b1 = collect(-y:y)
    b2 = ones(length(b1))*x
    b3 = ones(length(b1))*(-x)

    # x = k
    A1 = transpose(hcat(a1, a2)) # (k, y)
    A2 = transpose(hcat(a1, a3)) # (k, -y)

    # y = k
    # 행렬의 첫 째 행은 x좌표 둘 째 행은 y좌표 
    B1 = transpose(hcat(b2, b1)) # (x, k)
    B2 = transpose(hcat(b3, b1)) # (x, -k)

    plt = plot(xlims = (show[1], show[2]), ylims = (show[3],show[4]), grid = false, aspect_ratio = true, background = bg, showaxis = showaxis)
    if grid 
        for i in 1:(2x + 1)
            plt = plot!([A1[1, i],A2[1, i]],[A1[2, i], A2[2, i]],  ls = :dash, label = false, color = gc)
        end

        for i in 1:(2y + 1)
            plt = plot!([B1[1, i],B2[1, i]],[B1[2, i], B2[2, i]],  ls = :dash, label = false, color = gc)
        end
        # x축, y축 그리기
        plt = plot!([-x, x], [0, 0], lw = 2, color = "white", label = false)
        plt = plot!([0, 0], [-y, y], lw = 2, color = "white", label = false)
        return plt
    else
        plt = plot!([-x, x], [0, 0], lw = 2, color = "white", label = false)
        plt = plot!([0, 0], [-y, y], lw = 2, color = "white", label = false)
        return plt
    end
end

# 기저변환을 해주는 함수
function grid(x::Int64, y::Int64,matrix::Matrix; show = [-x, x, -y, y] ,bg="black",gc = c[1], grid = true,showaxis = true, size = (800, 600), dpi = 100)
    gr(size=size, dpi=dpi)
    c = palette(:default)
    # 한계 설정
    # vertical limit
    a1 = collect(-x:x)
    a2 = ones(length(a1))*y
    a3 = ones(length(a2))*(-y)

    # horizontal limit 
    b1 = collect(-y:y)
    b2 = ones(length(b1))*x
    b3 = ones(length(b1))*(-x)

    # x = k
    A1 = transpose(hcat(a1, a2)) # (k, y)
    A2 = transpose(hcat(a1, a3)) # (k, -y)

    # y = k
    # 행렬의 첫 째 행은 x좌표 둘 째 행은 y좌표 
    B1 = transpose(hcat(b2, b1)) # (x, k)
    B2 = transpose(hcat(b3, b1)) # (x, -k)

    A1 = matrix * A1
    A2 = matrix * A2
    B1 = matrix * B1
    B2 = matrix * B2

    plt = plot(xlims = (show[1], show[2]), ylims = (show[3],show[4]), grid = false, aspect_ratio = true, background = bg, showaxis = showaxis)
    if grid 
        for i in 1:(2x + 1)
            plt = plot!([A1[1, i],A2[1, i]],[A1[2, i], A2[2, i]],  ls = :dash, label = false, color = gc)
        end

        for i in 1:(2y + 1)
            plt = plot!([B1[1, i],B2[1, i]],[B1[2, i], B2[2, i]],  ls = :dash, label = false, color = gc)
        end
        # x축, y축 그리기
        x1 = matrix * [-x, 0]
        x2 = matrix * [x , 0]
        y1 = matrix * [0 , y]
        y2 = matrix * [0 , -y]

        plt = plot!([x1[1], x2[1]], [x1[2], x2[2]], lw = 2, color = "white", label = false)
        plt = plot!([y1[1], y2[1]], [y1[2], y2[2]], lw = 2, color = "white", label = false)
        return plt
    else
        # x축, y축 그리기
        x1 = matrix * [-x, 0]
        x2 = matrix * [x , 0]
        y1 = matrix * [0,  y]
        y2 = matrix * [0 ,-y]

        plt = plot!([x1[1], x2[1]], [x1[2], x2[2]], lw = 2, color = "white", label = false)
        plt = plot!([y1[1], y2[1]], [y1[2], y2[2]], lw = 2, color = "white", label = false)
        return plt
    end
end


# 좌표축과 표준기저를 그려주는 함수
function grid_sb(x::Int64, y::Int64;show = [-x, x, -y, y], bg="black",gc = c[1], grid = true, showaxis = true, size = (800, 600), dpi = 100)
    gr(size=size, dpi=dpi)
    c = palette(:default)
    # 한계 설정
    # vertical limit
    a1 = collect(-x:x)
    a2 = ones(length(a1))*y
    a3 = ones(length(a2))*(-y)

    # horizontal limit 
    b1 = collect(-y:y)
    b2 = ones(length(b1))*x
    b3 = ones(length(b1))*(-x)

    # x = k
    A1 = transpose(hcat(a1, a2)) # (k, y)
    A2 = transpose(hcat(a1, a3)) # (k, -y)

    # y = k
    # 행렬의 첫 째 행은 x좌표 둘 째 행은 y좌표 
    B1 = transpose(hcat(b2, b1)) # (x, k)
    B2 = transpose(hcat(b3, b1)) # (x, -k)

    plt = plot(xlims = (show[1], show[2]), ylims = (show[3],show[4]), grid = false, aspect_ratio = true, background = bg, showaxis = showaxis)
    if grid

        for i in 1:(2x + 1)
            plt = plot!([A1[1, i],A2[1, i]],[A1[2, i], A2[2, i]],  ls = :dash, label = false, color = gc)
        end

        for i in 1:(2y + 1)
            plt = plot!([B1[1, i],B2[1, i]],[B1[2, i], B2[2, i]],  ls = :dash, label = false, color = gc)
        end
        # x축, y축 그리기
        plt = plot!([-x, x], [0, 0], lw = 2, color = "white", label = false)
        plt = plot!([0, 0], [-y, y], lw = 2, color = "white", label = false)
    else
        # x축, y축 그리기
        plt = plot!([-x, x], [0, 0], lw = 2, color = "white", label = false)
        plt = plot!([0, 0], [-y, y], lw = 2, color = "white", label = false)
    end
    
    # 화살표 그기기
    plt = plot!([0,1], [0,0], lw = 3, arrow = true, color = c[2], label = false)
    plt = plot!([0,0], [0,1], lw = 3, arrow = true, color = c[3], label = false)
end

function grid_sb(x::Int64, y::Int64, matrix::Matrix;show = [-x, x, -y, y], bg="black",gc = c[1], grid = true, showaxis = true, size = (800, 600), dpi = 100)
    gr(size=size, dpi=dpi)
    c = palette(:default)
    # 한계 설정
    # vertical limit
    a1 = collect(-x:x)
    a2 = ones(length(a1))*y
    a3 = ones(length(a2))*(-y)

    # horizontal limit 
    b1 = collect(-y:y)
    b2 = ones(length(b1))*x
    b3 = ones(length(b1))*(-x)

    # x = k
    A1 = transpose(hcat(a1, a2)) # (k, y)
    A2 = transpose(hcat(a1, a3)) # (k, -y)

    # y = k
    # 행렬의 첫 째 행은 x좌표 둘 째 행은 y좌표 
    B1 = transpose(hcat(b2, b1)) # (x, k)
    B2 = transpose(hcat(b3, b1)) # (x, -k)

    A1 = matrix * A1
    A2 = matrix * A2
    B1 = matrix * B1
    B2 = matrix * B2

    plt = plot(xlims = (show[1], show[2]), ylims = (show[3],show[4]), grid = false, aspect_ratio = true, background = bg, showaxis = showaxis)
    if grid

        for i in 1:(2x + 1)
            plt = plot!([A1[1, i],A2[1, i]],[A1[2, i], A2[2, i]],  ls = :dash, label = false, color = gc)
        end

        for i in 1:(2y + 1)
            plt = plot!([B1[1, i],B2[1, i]],[B1[2, i], B2[2, i]],  ls = :dash, label = false, color = gc)
        end
        # x축, y축 그리기
        x1 = matrix * [-x, 0]
        x2 = matrix * [x , 0]
        y1 = matrix * [0 , y]
        y2 = matrix * [0 , -y]

        plt = plot!([x1[1], x2[1]], [x1[2], x2[2]], lw = 2, color = "white", label = false)
        plt = plot!([y1[1], y2[1]], [y1[2], y2[2]], lw = 2, color = "white", label = false)
    else
        # x축, y축 그리기
        x1 = matrix * [-x, 0]
        x2 = matrix * [x , 0]
        y1 = matrix * [0 , y]
        y2 = matrix * [0 , -y]

        plt = plot!([x1[1], x2[1]], [x1[2], x2[2]], lw = 2, color = "white", label = false)
        plt = plot!([y1[1], y2[1]], [y1[2], y2[2]], lw = 2, color = "white", label = false)
    end
    
    # 화살표 그기기
    plt = plot!([0,matrix[:, 1][1]], [0,matrix[: ,1][2]], lw = 3, arrow = true, color = c[2], label = false)
    plt = plot!([0,matrix[:, 2][1]], [0,matrix[: ,2][2]], lw = 3, arrow = true, color = c[3], label = false)
end

# 벡터를 표시하는 함수
function show_vector(vector::Vector; color = palette(:default)[2], iscord = false, cordsize = 10, cord_color = :white)
    plt = plot!([0, vector[1]], [0, vector[2]], lw = 3, arrow = true, color = color, label = false)

    x_cord = round(vector[1], digits = 2)
    y_cord = round(vector[2], digits = 2)

    if iscord
        plt = annotate!(1.1*vector[1], 1.1*vector[2], ("$((x_cord,  y_cord))", cordsize, cord_color))
    else
        return plt
    end
end

# 시점이 있는 벡터를 표시하는 함수
function show_vector(p1::Vector, p2::Vector; color = palette(:default)[2], iscord = false, cordsize = 10, cord_color = :white)
    plt = plot!([p1[1], p2[1]], [p1[2], p2[2]], lw = 3, arrow = true, color = color, label = false)


    if iscord
        x = p2[1] + 0.1(p2[1] - p1[1])
        y = p2[2] + 0.1(p2[1] - p1[1])
        x_cord = round((p2[1] - p1[1]), digits = 2)
        y_cord = round((p2[2] - p1[2]), digits = 2)
        plt = annotate!(x, y, ("$(((p2[1] - p1[1]),(p2[2] - p1[2])))", cordsize, cord_color)) 
    else
        return plt
    end
end


# 기저가 주어질 때 표준기저에 따른 좌표벡터를 표시하는 함수
# cord = true이면 표준기저에 따른 좌표벡터를 보여줌
# cord = false이면 기저에 따른 좌표벡터를 보여줌
# 기본적인 벡터는 기저에 따른 좌표벡터를 입력해야 함함
function show_vector(vector::Vector, matrix::Matrix; cord = true ,color = palette(:default)[2], iscord = false, cordsize = 10, cord_color = :white)
    vector1 = matrix * vector
    plt = plot!([0, vector1[1]], [0, vector1[2]], lw = 3, arrow = true, color = color, label = false)
    if iscord
        if cord
            plt = annotate!(1.1*vector1[1], 1.1*vector1[2], ("$((vector1[1], vector1[2]))", cordsize, cord_color))
        else
            plt = annotate!(1.1*vector1[1], 1.1*vector1[2], ("$((vector[1], vector[2]))", cordsize, cord_color))
        end
    else
        return plt
    end
end


# 1차원 span을 그려주는 함수
function span(vector::Vector; color = palette(:default)[1], t = 5, label = false)
    if label == false
        plt = plot!([-t*vector[1], t*vector[1]], [-t*vector[2], t*vector[2]], color = color, lw = 3, ls = :dash, label = label)
    else
        plt = plot!([-t*vector[1], t*vector[1]], [-t*vector[2], t*vector[2]], color = color, lw = 3, ls = :dash, label = "span of $(vector)")
    end
    return plt
end

# 행렬식을 그리는 함수
function viz_det(matrix::Matrix; color = palette(:default)[2], iscord = false, coordsize = 10, cord_color =:white, showarea = true, afs = 10, afc =:white)
    v1 = matrix[:, 1]
    v2 = matrix[:, 2]
    plt = plot!([0, v1[1]], [0, v1[2]], lw = 3, arrow = false, color = color, label = false)
    plt = plot!([0, v2[1]], [0, v2[2]], lw = 3, arrow = false, color = color, label = false)
    plt = plot!([v1[1], v1[1] + v2[1]], [v1[2], v1[2] + v2[2]], lw = 3, arrow = true, color = color, label = false)
    plt = plot!([v2[1], v1[1] + v2[1]], [v2[2], v1[2] + v2[2]], lw = 3, arrow = true, color = color, label = false)

    xs = [0, v1[1], v1[1] + v2[1], v2[1], 0]
    ys = [0, v1[2], v1[2] + v2[2], v2[2], 0]
    plt = plot!(Shape(xs, ys), color = color, fillalpha = 0.5, label = false, lw=0)

    if showarea
        area = det(matrix)
        plt = annotate!(0.5*(v1[1] + v2[1]), 0.5*(v1[2] + v2[2]), ("$(area)", afs, afc))
    else
        return plt
    end
end

# 선형변환을 하는 함수
function linearmap(vector::Vector, matrix::Matrix; color = palette(:default)[2], iscord = false, cordsize = 10, cord_color = :white)
    result = matrix * vector
    return show_vector(result, color = color, iscord = iscord, cordsize = cordsize, cord_color = cord_color)
end

# 단위원을 그리는 함수
function unit_circ(;theta = 0:0.01:2pi, color = c[1], r = 1)
    plot!(r*cos.(theta), r*sin.(theta), lw = 3, color = color, label = false)
end


# 단위원에 따른 선형변환을 하는 함수
function linearmap(matrix::Matrix;theta = 0:0.01:2pi, color = c[3])
    x_circ = cos.(theta)
    y_circ = sin.(theta)
    xy_matrix = transpose(hcat(x_circ, y_circ))
    res = matrix * xy_matrix
    plot!(res[1, :], res[2, :], lw = 3, color = color, label = false)
end

# 고유벡터를 그리는 함수
function draw_eigenvec(matrix::Matrix; color = "gray", iscord = false, cordsize = 10, cord_color = :white)
    eigenvector = eigvecs(matrix)
    v1 = eigenvector[:, 1]
    v2 = eigenvector[:, 2]
    plt = show_vector(v1; color = color, iscord = iscord, cordsize = cordsize, cord_color = cord_color)
    plt = show_vector(v2; color = color, iscord = iscord, cordsize = cordsize, cord_color = cord_color)
    return plt
end

# 정사영을 그리는 함수
# v를 w에 정사영시키는 함수
function projection(v::Vector, w::Vector;trace = true, color = palette(:default)[2], iscord = false, cordsize = 10, cord_color = :white)
    proj = (sum(v .* w)/(norm(w)^2))*w
    plt = show_vector(proj; color = color, iscord = iscord, cordsize = cordsize, cord_color = cord_color)
    if trace
        plt = plot!([v[1], proj[1]], [v[2], proj[2]], ls =:dash, color = :gray, lw = 3, label = false)
    end
    return plt
end