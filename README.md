# LinViz2D
This repository provides linear algebra visualization package of Julia.

본 리포지터리에선 줄리아의 2차원 선형대수 시각화를 다루는 파일인 LinViz2D를 제공합니다.

# 목차
- [LinViz2D란?](#LinViz2D란?)
- [파일 실행하는 방법](#파일-실행하는-방법)
- [기본 좌표축 생성](#기본-좌표축-생성)
  - [사용 예제](#사용-예제)
## LinViz2D란?

Linear Algebra Visualization in 2-Dimension의 약자로 2차원 벡터에 대한 선형대수학적 시각화 기능을 제공하는 줄리아 파일입니다.

## 파일 실행하는 방법
파일을 실행하기 위해선 본 리포지터리에서 LinViz2D.jl을 다운받은 후 실행하면 됩니다.

```julia
include("LinViz2D.jl")
```

## 기본 좌표축 생성
기본 좌표축을 생성하기 위해선 grid()함수를 사용합니다.

1. 기능 설명 
grid()함수는 좌표축과 격자를 그려주는 역할을 합니다.
* 입력한 x, y 값을 기준으로 좌표 평면을 생성합니다.
* Plots.jl을 사용하여 점선 격자(grid lines)와 x축, y축을 시각적으로 표시합니다.
* 배경색, 해상도, 그래프 크기 등의 옵션을 조절할 수 있습니다.

2. 매개변수 설명
```julia
grid(x::Int64, y::Int64; show = [-x, x, -y, y], bg="black", showaxis = true, size = (800, 600), dpi = 100)
```
|매개변수|타입|기본값|설명
|-----|----|----|----|
|x|Int64|(필수)|x축 방향의 최대 좌표값
|y|Int64|(필수)|y축 방향의 최대 좌표값
|show|Vector{Int}|[-x, x, -y, y]|그래프의 표시 범위(x_min, x_max, y_min, y_max)
|bg|String|"black"|배경 색상
|showaxis|Bool|true|x축, y축 표시 여부
|size|Tuple{Int, Int}|(800, 600)|그래프 크기(가로, 세로)
|dpi|Int|100|해상도(DPI)

### 사용 예제
```julia
grid(4,4)
```
![Uploaded Image](https://github.com/user-attachments/assets/1c678b26-28a0-4596-ad16-e4f2519c976e)
