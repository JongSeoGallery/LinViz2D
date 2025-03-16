# Linear Algebra Visualization in 2D : LinViz2D.jl

## 파일 개요
**파일명:** `linear_algebra_visualization.jl`

이 파일은 선형대수학 개념을 시각화하기 위한 Julia 함수들의 모음입니다. 벡터, 좌표계, 선형변환, 행렬식 등의 선형대수학 개념을 직관적으로 이해할 수 있도록 시각화하는 함수들을 제공합니다.

## 의존성
```julia
using Statistics
using LinearAlgebra
using LaTeXStrings
using Plots
```

## 함수 목록

### 1. `grid` 함수
#### 설명
좌표축을 그려주는 함수로, 2차원 데카르트 좌표계를 시각화합니다.

#### Multiple Dispatch
- **첫 번째 메서드**: 기본 좌표축 그리기
  ```julia
  grid(x::Int64, y::Int64; show = [-x, x, -y, y], bg="black", gc = c[1], grid = true, showaxis = true, size = (800, 600), dpi = 100)
  ```
  - `x`: x축 범위를 지정하는 정수
  - `y`: y축 범위를 지정하는 정수
  - `show`: 표시할 창의 범위 `[x_min, x_max, y_min, y_max]`
  - `bg`: 배경색
  - `gc`: 그리드 색상
  - `grid`: 그리드 표시 여부
  - `showaxis`: 축 표시 여부
  - `size`: 그래프 크기
  - `dpi`: 해상도

- **두 번째 메서드**: 선형변환이 적용된 좌표축 그리기
  ```julia
    grid(x::Int64, y::Int64, matrix::Matrix; show = [-x, x, -y, y], bg="black", gc = c[1], grid = true, showaxis = true, size = (800, 600), dpi = 100)
  ```
  - 기본 매개변수들은 위와 동일
  - `matrix`: 좌표축에 적용할 선형변환 행렬

#### 사용 예제
```julia
# 기본 좌표축 그리기
plt = grid(5, 5)

# 선형변환이 적용된 좌표축 그리기
A = [1 1; 0 1]  # 전단변환(shear transformation) 행렬
plt = grid(5, 5, A)
```

### 2. `grid_sb` 함수
#### 설명
좌표축과 함께 표준기저 벡터를 그려주는 함수입니다.

#### Multiple Dispatch
- **첫 번째 메서드**: 표준 좌표축과 표준기저 벡터 그리기
  ```julia
  grid_sb(x::Int64, y::Int64; show = [-x, x, -y, y], bg="black", gc = c[1], grid = true, showaxis = true, size = (800, 600), dpi = 100)
  ```
  - 매개변수는 `grid` 함수와 동일

- **두 번째 메서드**: 선형변환이 적용된 좌표축과 기저 벡터 그리기
  ```julia
  grid_sb(x::Int64, y::Int64, matrix::Matrix; show = [-x, x, -y, y], bg="black", gc = c[1], grid = true, showaxis = true, size = (800, 600), dpi = 100)
  ```
  - 기본 매개변수들은 위와 동일
  - `matrix`: 좌표축과 기저 벡터에 적용할 선형변환 행렬

#### 사용 예제
```julia
# 표준 좌표축과 표준기저 벡터 그리기
plt = grid_sb(5, 5)

# 선형변환이 적용된 좌표축과 기저 벡터 그리기
A = [2 0; 0 2]  # 스케일링 행렬
plt = grid_sb(5, 5, A)
```

### 3. `show_vector` 함수
#### 설명
벡터를 화살표로 표시하는 함수입니다.

#### Multiple Dispatch
- **첫 번째 메서드**: 원점에서 시작하는 벡터 그리기
  ```julia
  show_vector(vector::Vector; color = palette(:default)[2], iscord = false, cordsize = 10, cord_color = :white)
  ```
  - `vector`: 그릴 벡터
  - `color`: 벡터 색상
  - `iscord`: 좌표값 표시 여부
  - `cordsize`: 좌표값의 크기
  - `cord_color`: 좌표값의 색상

- **두 번째 메서드**: 임의의 점에서 시작하는 벡터 그리기
  ```julia
  show_vector(p1::Vector, p2::Vector; color = palette(:default)[2], iscord = false, cordsize = 10, cord_color = :white)
  ```
  - `p1`: 시작점
  - `p2`: 끝점
  - 다른 매개변수는 위와 동일

- **세 번째 메서드**: 선형변환이 적용된 벡터 그리기
  ```julia
  show_vector(vector::Vector, matrix::Matrix; color = palette(:default)[2], iscord = false, cordsize = 10, cord_color = :white)
  ```
  - `vector`: 그릴 벡터
  - `matrix`: 벡터에 적용할 선형변환 행렬
  - 다른 매개변수는 위와 동일

#### 사용 예제
```julia
# 원점에서 시작하는 벡터 그리기
plt = grid(5, 5)
plt = show_vector([3, 2], iscord = true)

# 임의의 점에서 시작하는 벡터 그리기
plt = grid(5, 5)
plt = show_vector([1, 1], [4, 3], iscord = true)

# 선형변환이 적용된 벡터 그리기
plt = grid(5, 5)
A = [0 1; 1 0]  # 대칭 행렬
plt = show_vector([3, 2], A, iscord = true)
```

### 4. `span` 함수
#### 설명
벡터에 의해 생성되는 1차원 부분공간(span)을 시각화하는 함수입니다.

#### 매개변수
```julia
span(vector::Vector; color = palette(:default)[1], t = 5, label = false)
```
- `vector`: span을 생성할 벡터
- `color`: 선 색상
- `t`: 표시할 스팬의 길이 배수
- `label`: 레이블 표시 여부

#### 사용 예제
```julia
# 벡터 [1, 2]에 의해 생성되는 span 그리기
plt = grid(5, 5)
plt = show_vector([1, 2], iscord = true)
plt = span([1, 2], label = true)
```

### 5. `viz_det` 함수
#### 설명
행렬식을 시각적으로 표현하는 함수입니다. 행렬의 두 열벡터가 이루는 평행사변형의 넓이를 표시합니다.

#### 매개변수
```julia
viz_det(matrix::Matrix; color = palette(:default)[2], iscord = false, coordsize = 10, cord_color = :white, showarea = true, afs = 10, afc = :white)
```
- `matrix`: 행렬식을 계산할 2×2 행렬
- `color`: 평행사변형의 색상
- `iscord`: 좌표값 표시 여부
- `coordsize`: 좌표값의 크기
- `cord_color`: 좌표값의 색상
- `showarea`: 면적(행렬식) 표시 여부
- `afs`: 면적 텍스트의 크기
- `afc`: 면적 텍스트의 색상

#### 사용 예제
```julia
# 행렬 [2 1; 1 3]의 행렬식 시각화
plt = grid(5, 5)
A = [2 1; 1 3]
plt = viz_det(A)
```

### 6. `linearmap` 함수
#### 설명
선형변환을 시각화하는 함수입니다.

#### Multiple Dispatch
- **첫 번째 메서드**: 벡터에 선형변환 적용
  ```julia
  linearmap(vector::Vector, matrix::Matrix; color = palette(:default)[2], iscord = false, cordsize = 10, cord_color = :white)
  ```
  - `vector`: 변환할 벡터
  - `matrix`: 선형변환을 나타내는 행렬
  - 다른 매개변수는 `show_vector`와 동일

- **두 번째 메서드**: 단위원에 선형변환 적용
  ```julia
  linearmap(matrix::Matrix; theta = 0:0.01:2pi, color = c[3])
  ```
  - `matrix`: 선형변환을 나타내는 행렬
  - `theta`: 단위원을 표현하는 각도 범위
  - `color`: 변환된 도형의 색상

#### 사용 예제
```julia
# 벡터 [1, 1]에 행렬 [2 0; 0 1]을 적용한 선형변환 시각화
plt = grid(5, 5)
A = [2 0; 0 1]  # x축 방향으로 2배 늘리는 변환
plt = linearmap([1, 1], A, iscord = true)

# 단위원에 선형변환 적용
plt = grid(5, 5)
plt = unit_circ()  # 단위원 그리기
A = [2 1; 0 1]  # 전단변환과 x축 방향 늘리기 조합
plt = linearmap(A)  # 변환된 단위원 그리기
```

### 7. `unit_circ` 함수
#### 설명
단위원을 그리는 함수입니다.

#### 매개변수
```julia
unit_circ(theta = 0:0.01:2pi, color = c[1])
```
- `theta`: 단위원을 표현하는 각도 범위
- `color`: 단위원의 색상

#### 사용 예제
```julia
# 단위원 그리기
plt = grid(5, 5)
plt = unit_circ()
```
