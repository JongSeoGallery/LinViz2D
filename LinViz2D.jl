using Statistics
using LinearAlgebra
using LaTeXStrings
using Plots

c = palette(:default)

# 좌표축을 그려주는 함수
function grid(x::Int64, y::Int64;show = [-x, x, -y, y] ,bg="black",gc = c[1], showaxis = true, size = (800, 600), dpi = 100)
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

    for i in 1:(2x + 1)
        plt = plot!([A1[1, i],A2[1, i]],[A1[2, i], A2[2, i]],  ls = :dash, label = false, color = gc)
    end

    for i in 1:(2y + 1)
        plt = plot!([B1[1, i],B2[1, i]],[B1[2, i], B2[2, i]],  ls = :dash, label = false, color = gc)
    end
    # x축, y축 그리기
    plt = plot!([-x, x], [0, 0], lw = 2, color = "gray", label = false)
    plt = plot!([0, 0], [-y, y], lw = 2, color = "gray", label = false)
    return plt
end

# 좌표축과 표준기저를 그려주는 함수
function grid_sb(x::Int64, y::Int64; bg="black", showaxis = true, size = (800, 600), dpi = 100)
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

    plt = plot(xlims = (-x, x), ylims = (-y,y), grid = false, aspect_ratio = true, background = bg, showaxis = showaxis)

    for i in 1:(2x + 1)
        plt = plot!([A1[1, i],A2[1, i]],[A1[2, i], A2[2, i]],  ls = :dash, label = false, color = c[1])
    end

    for i in 1:(2y + 1)
        plt = plot!([B1[1, i],B2[1, i]],[B1[2, i], B2[2, i]],  ls = :dash, label = false, color = c[1])
    end
    # x축, y축 그리기
    plt = plot!([-x, x], [0, 0], lw = 2, color = "gray", label = false)
    plt = plot!([0, 0], [-y, y], lw = 2, color = "gray", label = false)
    
    # 화살표 그기기
    plt = plot!([0,1], [0,0], lw = 3, arrow = true, color = c[2], label = false)
    plt = plot!([0,0], [0,1], lw = 3, arrow = true, color = c[3], label = false)
end

# 벡터를 표시하는 함수
function show_vector(vector::Vector; color = palette(:default)[2], iscord = false, cordsize = 10, cord_color = :white)
    plt = plot!([0, vector[1]], [0, vector[2]], lw = 3, arrow = true, color = color, label = false)
    if iscord
        plt = annotate!(1.15*vector[1], 1.15*vector[2], ("$((vector[1], vector[2]))", cordsize, cord_color))
    else
        return plt
    end
end

# 시점이 있는 벡터를 표시하는 함수
function show_vector(p1::Vector, p2::Vector; color = palette(:default)[2], iscord = false, cordsize = 10, cord_color = :white)
    plt = plot!([p1[1], p2[1]], [p1[2], p2[2]], lw = 3, arrow = true, color = color, label = false)
    if iscord
        x = p2[1] + 0.15(p2[1] - p1[1])
        y = p2[2] + 0.15(p2[1] - p1[1])
        plt = annotate!(x, y, ("$(((p2[1] - p1[1]),(p2[2] - p1[2])))", cordsize, cord_color)) 
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
function unit_circ(theta = 0:0.01:2pi)
    c = palette(:default)
    plot!(cos.(theta), sin.(theta), lw = 3, color = c[1], label = false)
end

# 단위원에 따른 선형변환을 하는 함수
function linearmap(matrix::Matrix;theta = 0:0.01:2pi)
    c = palette(:default)
    x_circ = cos.(theta)
    y_circ = sin.(theta)
    xy_matrix = transpose(hcat(x_circ, y_circ))
    res = matrix * xy_matrix
    plot!(res[1, :], res[2, :], lw = 3, color = c[2], label = false)
end

