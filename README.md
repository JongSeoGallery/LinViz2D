# LinViz2D
This repository provides 2D linear algebra visualization package of Julia.

본 리포지터리에선 줄리아의 2차원 선형대수 시각화를 다루는 파일인 LinViz2D를 제공합니다.

# 목차
- [LinViz2D란?](#LinViz2D란?)
- [파일 실행하는 방법](#파일-실행하는-방법)
- [기본 좌표축 생성](#기본-좌표축-생성)
  - [사용 예제](#사용-예제)
- [좌표축과 표준기저를 그려주는 함수](#좌표축과-표준기저를-그려주는-함수)
  - [사용 예제](#사용-예제)
- [벡터를 표시하는 함수](#벡터를-표시하는-함수)
  - [원점에서 벡터 생성하기](#원점에서-벡터-생성하기)
  - [시점, 종점이 있는 벡터 생성하기](#시점,-종점이-있는-벡터-생성하기)
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
|bg|String, RGB{Float64}|"black"|배경 색상
|gc|String, RGB{Float64}|palette(:default)[1]|격자 색상
|showaxis|Bool|true|x축, y축 표시 여부
|size|Tuple{Int, Int}|(800, 600)|그래프 크기(가로, 세로)
|dpi|Int|100|해상도(DPI)

### 사용 예제
```julia
grid(4,4)
```
![Uploaded Image](https://github.com/user-attachments/assets/1c678b26-28a0-4596-ad16-e4f2519c976e)

```julia
grid(4,4, show = [-4, 4, -1, 3], bg = "pink", showaxis = true, size = (800, 400))
```

![Uploaded Image](https://github.com/user-attachments/assets/be29ca78-26e3-41d4-87a4-1ec60473d24f)

## 좌표축과 표준기저를 그려주는 함수
기본 좌표축과 표준기저를 그려주는 함수는 grid_sb()함수를 사용합니다.
grid_sb()는 grid with standard basis라는 뜻 입니다.

1. 기능 설명
grid_sb()함수는 좌표축과 격자를 그림과 동시에 표준기저를 시각화 해주는 함수입니다.
* 입력 매개변수는 grid()함수와 동일합니다.

2. 매개변수 설명
```julia
grid_sb(x::Int64, y::Int64; bg="black", showaxis = true, size = (800, 600), dpi = 100)
```
|매개변수|타입|기본값|설명
|-----|----|----|----|
|x|Int64|(필수)|x축 방향의 최대 좌표값
|y|Int64|(필수)|y축 방향의 최대 좌표값
|show|Vector{Int}|[-x, x, -y, y]|그래프의 표시 범위(x_min, x_max, y_min, y_max)
|bg|String, RGB{Float64}|"black"|배경 색상
|gc|String, RGB{Float64}|palette(:default)[1]|격자 색상
|showaxis|Bool|true|x축, y축 표시 여부
|size|Tuple{Int, Int}|(800, 600)|그래프 크기(가로, 세로)
|dpi|Int|100|해상도(DPI)

### 사용 예제
```julia
grid_sb(3,2,bg="black", gc = "white", showaxis = false, dpi = 100)
```
![Uploaded Image](https://github.com/user-attachments/assets/284db54a-2834-4ee6-93ac-41feadc1d9c3)

## 벡터를 표시하는 함수
벡터를 표시하는 함수는 show_vector()함수를 사용합니다.

1. 기능 설명 
show_vector()함수는 메서드가 2개입니다. 
첫 번째 메서드는 기본적으로 벡터의 시점은 원점이기 때문에 원점에서 종점으로 향하는 벡터를 생성합니다.
두 번째 메서드는 시점과 종점이 있는 벡터를 생성합니다.

LinViz2D의 철학은 grid를 생성한 다음, 벡터 혹은 이외의 것을 추가히는 것이기 때문에, show_vector()함수를 실행하기 위해선 기본적으로 grid()함수를 실행하여 grid를 생성해야 합니다.

### 원점에서 벡터 생성하기
2.1. 매개변수 설명
```julia
show_vector(vector::Vector; color = palette(:default)[2], iscord = false, cordsize = 10, cord_color = :white)
```

|매개변수|타입|기본값|설명|
|----|----|----|----|
|vector|Vector{Float64}|없음|벡터(x, y) 좌표
|color|Symbol|palette(:default)[2]|벡터|색상
|iscord|Bool|false|벡터의 좌표를 표시할지 여부
|cordsize|Int	10|좌표 글씨 크기
|cord_color|Symbol|:white|좌표 글씨 색상
### 시점, 종점이 있는 벡터 생성하기
2.2. 매개변수 설명
```julia
show_vector(p1::Vector, p2::Vector; color = palette(:default)[2], iscord = false, cordsize = 10, cord_color = :white)
```



