# LinViz2D.jl

이 Julia 코드는 2차원에서 선형대수 개념을 시각화하는 데 유용한 여러 함수를 제공합니다. 좌표 평면을 그리고, 벡터를 표시하고, 선형 변환을 시각화하는 등의 작업을 수행할 수 있습니다.

## 목차
0. **`파일 불러오기`**
1.  **`grid` 함수**
    * `grid(x::Int64, y::Int64; ...)`: 기본적인 좌표축 그리기
    * `grid(x::Int64, y::Int64, matrix::Matrix; ...)`: 선형 변환된 좌표축 그리기
2.  **`grid_sb` 함수**
    * `grid_sb(x::Int64, y::Int64; ...)`: 표준 기저 벡터와 함께 좌표축 그리기
    * `grid_sb(x::Int64, y::Int64, matrix::Matrix; ...)`: 선형 변환된 기저 벡터와 함께 좌표축 그리기
3.  **`show_vector` 함수**
    * `show_vector(vector::Vector; ...)`: 원점에서 시작하는 벡터 그리기
    * `show_vector(p1::Vector, p2::Vector; ...)`: 두 점을 잇는 벡터 그리기
    * `show_vector(vector::Vector, matrix::Matrix; ...)`: 선형 변환된 벡터 그리기
4.  **`span` 함수**: 벡터의 스팬(span) 그리기
5.  **`viz_det` 함수**: 행렬식 시각화
6.  **`linearmap` 함수**
    * `linearmap(vector::Vector, matrix::Matrix; ...)`: 벡터에 대한 선형 변환 시각화
    * `linearmap(matrix::Matrix; ...)`: 단위 원에 대한 선형 변환 시각화
7.  **`unit_circ` 함수**: 단위 원 그리기
8.  **`draw_eigenvec` 함수**: 고유벡터 그리기
9.  **`projection` 함수**: 벡터의 정사영 그리기

### 파일 불러오기
```julia
include("LinViz2D.jl")
```

### 함수별 설명

#### 1. `grid` 함수

이 함수는 좌표 평면의 격자를 그리는 데 사용됩니다. `grid` 함수는 두 가지 다른 방식으로 호출될 수 있습니다 (multiple dispatch).

* **`grid(x::Int64, y::Int64; show = [-x, x, -y, y] ,bg="black",gc = c[1], grid = true,showaxis = true, size = (800, 600), dpi = 100)`**

    * **`x::Int64`**: x축의 양의 방향으로의 최댓값 (정수형). 격자의 범위는 `-x`에서 `x`까지 설정됩니다.
    * **`y::Int64`**: y축의 양의 방향으로의 최댓값 (정수형). 격자의 범위는 `-y`에서 `y`까지 설정됩니다.
    * **키워드 인자**:
        * `show`: 표시될 좌표축의 범위 (기본값: `[-x, x, -y, y]`). `[x_min, x_max, y_min, y_max]` 형태의 벡터로 지정합니다.
        * `bg`: 배경색 (기본값: `"black"`).
        * `gc`: 격자선 색상 (기본값: `c[1]`, 미리 정의된 색상 팔레트의 첫 번째 색상).
        * `grid`: 격자 표시 여부 (기본값: `true`).
        * `showaxis`: 좌표축 표시 여부 (기본값: `true`).
        * `size`: 그림 크기 (기본값: `(800, 600)`).
        * `dpi`: 해상도 (dots per inch) (기본값: `100`).

- 예제
```julia
grid(4,2)
```
![Sample Image](https://github.com/user-attachments/assets/f5711eae-673b-48fd-be00-1348e760def0)

* **`grid(x::Int64, y::Int64, matrix::Matrix; show = [-x, x, -y, y] ,bg="black",gc = c[1], grid = true,showaxis = true, size = (800, 600), dpi = 100)`**

    * **`x::Int64`**: x축의 양의 방향으로의 최댓값 (정수형).
    * **`y::Int64`**: y축의 양의 방향으로의 최댓값 (정수형).
    * **`matrix::Matrix`**: 2x2 행렬 (행렬형). 이 행렬은 격자에 선형 변환을 적용합니다.
    * **키워드 인자**: 위와 동일.
 
- 예제
```julia
matrix = [1 1/2;1/2 1]
grid(8,8, matrix, show = [-4, 4, -4, 4])
```
![Image](https://github.com/user-attachments/assets/456075ab-81f4-44d8-a925-d334582a0601)


#### 2. `grid_sb` 함수

이 함수는 표준 기저 벡터 (i-hat: [1, 0], j-hat: [0, 1])와 함께 좌표 평면의 격자를 그리는 데 사용됩니다. `grid_sb` 함수 역시 multiple dispatch를 지원합니다.

* **`grid_sb(x::Int64, y::Int64; show = [-x, x, -y, y], bg="black",gc = c[1], grid = true, showaxis = true, size = (800, 600), dpi = 100)`**

    * **`x::Int64`**: x축의 양의 방향으로의 최댓값 (정수형).
    * **`y::Int64`**: y축의 양의 방향으로의 최댓값 (정수형).
    * **키워드 인자**: `grid` 함수의 첫 번째 정의와 동일합니다. 추가적으로 표준 기저 벡터가 그려집니다.
 
- 예제
```julia
grid_sb(4, 2)
```
![Image](https://github.com/user-attachments/assets/094024fc-497f-45e7-a534-375d50f243ea)

* **`grid_sb(x::Int64, y::Int64, matrix::Matrix; show = [-x, x, -y, y], bg="black",gc = c[1], grid = true, showaxis = true, size = (800, 600), dpi = 100)`**

    * **`x::Int64`**: x축의 양의 방향으로의 최댓값 (정수형).
    * **`y::Int64`**: y축의 양의 방향으로의 최댓값 (정수형).
    * **`matrix::Matrix`**: 2x2 행렬 (행렬형). 이 행렬은 격자와 표준 기저 벡터 모두에 선형 변환을 적용합니다.
    * **키워드 인자**: 위와 동일. 변환된 표준 기저 벡터가 그려집니다.
  
- 예제
```julia
matrix = [1 1/2;1/2 1]
grid_sb(8, 8, matrix, show = [-4, 4,-4, 4])
```
![Image](https://github.com/user-attachments/assets/62ca7f37-02fb-4633-9dd0-6ceca7f626aa)


#### 3. `show_vector` 함수

이 함수는 벡터를 시각화하는 데 사용됩니다. `show_vector` 함수는 세 가지 다른 방식으로 호출될 수 있습니다.

* **`show_vector(vector::Vector; color = palette(:default)[2], iscord = false, cordsize = 10, cord_color = :white)`**

    * **`vector::Vector`**: 표시할 2차원 벡터 (벡터형). 예를 들어 `[1, 2]`와 같은 형태입니다. 벡터는 원점 `(0, 0)`에서 시작하여 지정된 좌표에서 끝나는 화살표로 그려집니다.
    * **키워드 인자**:
        * `color`: 벡터의 색상 (기본값: `palette(:default)[2]`).
        * `iscord`: 벡터의 좌표를 표시할지 여부 (기본값: `false`).
        * `cordsize`: 좌표 텍스트 크기 (기본값: `10`).
        * `cord_color`: 좌표 텍스트 색상 (기본값: `:white`).
     
- 예제
```julia
grid(4, 2)
show_vector([2, 1], color = "pink", iscord = true)
```
![Image](https://github.com/user-attachments/assets/bc22210e-51ae-4edb-949a-09767e601cf9)

* **`show_vector(p1::Vector, p2::Vector; color = palette(:default)[2], iscord = false, cordsize = 10, cord_color = :white)`**

    * **`p1::Vector`**: 벡터의 시작점 좌표 (벡터형).
    * **`p2::Vector`**: 벡터의 끝점 좌표 (벡터형). 이 함수는 점 `p1`에서 시작하여 점 `p2`에서 끝나는 화살표를 그립니다.
    * **키워드 인자**: 위와 동일합니다. 좌표는 `p2 - p1`으로 계산된 상대적인 벡터를 기준으로 표시됩니다.

 - 예제
```julia
grid(4, 3)
show_vector([2, 1], [-2, -1.5], color = "pink", iscord = true, cordsize = 15)
```
![Image](https://github.com/user-attachments/assets/eb86395a-92d7-4ece-b656-9c2b9b10dc2b)


* **`show_vector(vector::Vector, matrix::Matrix; color = palette(:default)[2], iscord = false, cordsize = 10, cord_color = :white)`**

    * **`vector::Vector`**: 표시할 2차원 벡터 (벡터형).
    * **`matrix::Matrix`**: 2x2 변환 행렬 (행렬형). 이 함수는 먼저 주어진 벡터에 행렬을 곱하여 선형 변환을 적용한 다음, 변환된 벡터를 원점에서 시작하는 화살표로 그립니다.
    * **키워드 인자**: 위와 동일합니다. 좌표는 변환된 벡터를 기준으로 표시됩니다.
 
- 예제
```julia
matrix = [1 2;2 1]
grid(4, 4, matrix)
show_vector([1, 0], matrix, iscord = true, cord = false)
show_vector([0, 1], matrix,color = c[3], iscord = true, cord = false)
```
![Image](https://github.com/user-attachments/assets/f7b985db-3a1e-4cb3-9449-99a3278d6773)

```julia
c = palette(:default)
matrix = [1 2;2 1]
grid(4, 4, matrix)
show_vector([1, 0], matrix, iscord = true, cord = true)
show_vector([0, 1], matrix,color = c[3], iscord = true, cord = true)
```
![Image](https://github.com/user-attachments/assets/3ac79825-afa9-4f53-87d5-2e4c131db5de)

#### 4. `span` 함수

이 함수는 주어진 벡터의 스팬(span)을 선으로 그립니다.

* **`span(vector::Vector; color = palette(:default)[1], t = 5, label = false)`**

    * **`vector::Vector`**: 스팬을 그릴 2차원 벡터 (벡터형).
    * **키워드 인자**:
        * `color`: 스팬 선의 색상 (기본값: `palette(:default)[1]`).
        * `t`: 스팬을 그릴 범위의 스케일 (기본값: `5`). 선은 `-t * vector`에서 `t * vector`까지 그려집니다.
        * `label`: 레이블 표시 여부 (기본값: `false`). `true`로 설정하면 "span of (vector)" 형태의 레이블이 표시됩니다.
     
- 예제
```julia
grid(4, 2)
span([2, 1], t = 0.5)
span([-2, 1], t = 2, color = "gray")
```
![Image](https://github.com/user-attachments/assets/97366fa3-881c-4791-bad6-04363d127059)

#### 5. `viz_det` 함수

이 함수는 2x2 행렬이 나타내는 평행사변형을 그리고 행렬식의 값을 표시하여 행렬식을 시각화합니다.

* **`viz_det(matrix::Matrix; color = palette(:default)[2], iscord = false, coordsize = 10, cord_color =:white, showarea = true, afs = 10, afc =:white)`**

    * **`matrix::Matrix`**: 시각화할 2x2 행렬 (행렬형). 행렬의 두 열 벡터는 평행사변형의 변을 정의합니다.
    * **키워드 인자**:
        * `color`: 벡터 및 평행사변형의 색상 (기본값: `palette(:default)[2]`).
        * `iscord`, `coordsize`, `cord_color`: (현재 사용되지 않음).
        * `showarea`: 행렬식 값 (넓이)을 표시할지 여부 (기본값: `true`).
        * `afs`: 넓이 텍스트 크기 (기본값: `10`).
        * `afc`: 넓이 텍스트 색상 (기본값: `:white`).
     
- 예제
```julia
c = palette(:default)
grid(4, 4)
viz_det([2 1;1 2], color = c[5])
```
![Image](https://github.com/user-attachments/assets/8e579dfc-270a-4fc5-bb73-53c40d5eff06)

#### 6. `linearmap` 함수

이 함수는 벡터 또는 단위 원에 선형 변환을 적용한 결과를 시각화합니다.

* **`linearmap(vector::Vector, matrix::Matrix; color = palette(:default)[2], iscord = false, cordsize = 10, cord_color = :white)`**

    * **`vector::Vector`**: 선형 변환을 적용할 2차원 벡터 (벡터형).
    * **`matrix::Matrix`**: 2x2 변환 행렬 (행렬형). 이 함수는 주어진 벡터에 행렬을 곱하여 선형 변환을 적용하고, `show_vector` 함수를 사용하여 변환된 벡터를 그립니다.
    * **키워드 인자**: `show_vector` 함수의 키워드 인자와 동일합니다.
 
- 예제
```julia
matrix = [0 2;1 0]
linearmap([1, 1], matrix, color = c[3])
```
![Image](https://github.com/user-attachments/assets/3c590c76-1b04-4505-aff9-512363708ab9)

* **`linearmap(matrix::Matrix; theta = 0:0.01:2pi, color = c[3])`**

    * **`matrix::Matrix`**: 단위 원에 적용할 2x2 변환 행렬 (행렬형).
    * **키워드 인자**:
        * `theta`: 단위 원을 그리기 위한 각도 범위 (기본값: `0:0.01:2pi`).
        * `color`: 변환된 단위 원의 색상 (기본값: `c[3]`). 이 함수는 단위 원의 각 점에 주어진 행렬을 곱하여 선형 변환을 적용하고, 변환된 모양을 그립니다.
     
- 예제
```julia
grid(3, 3)
unit_circ()
matrix = [1 2;2 1]
linearmap(matrix, color = c[2])
```
![Image](https://github.com/user-attachments/assets/7b7b5981-e1c2-4143-8d69-0b10121828d6)


#### 7. `unit_circ` 함수

이 함수는 단위 원을 그립니다.

* **`unit_circ(theta = 0:0.01:2pi, color = c[1])`**

    * **키워드 인자**:
        * `theta`: 원을 그리기 위한 각도 범위 (기본값: `0:0.01:2pi`).
        * `color`: 원의 색상 (기본값: `c[1]`).
     
- 예제
```julia
grid(2,2)
unit_circ()
```
![Image](https://github.com/user-attachments/assets/6ddc47df-0dff-4127-9ff1-a293cc8587f2)

```julia
grid(2,2)
unit_circ(theta = 0:0.1:π)
```
![Image](https://github.com/user-attachments/assets/b69932a3-06ba-4e25-bb0b-e361f18228e9)

#### 8. `draw_eigenvec` 함수

이 함수는 주어진 행렬의 고유벡터를 그립니다.

* **`draw_eigenvec(matrix::Matrix; color = "gray", iscord = false, cordsize = 10, cord_color = :white)`**

    * **`matrix::Matrix`**: 고유벡터를 계산할 2x2 행렬 (행렬형).
    * **키워드 인자**: `show_vector` 함수의 키워드 인자와 유사합니다. 고유벡터는 회색으로 그려집니다.
 
- 예제
```julia
grid(3, 3)
unit_circ()
matrix = [1 2;2 1]
linearmap(matrix, color = c[2])
draw_eigenvec(matrix, iscord = true)
```
![Image](https://github.com/user-attachments/assets/3a7835fa-fcb8-4f6d-8c19-0d9566734abd)


#### 9. `projection` 함수

이 함수는 벡터 `v`를 벡터 `w`에 정사영한 결과를 그립니다.

* **`projection(v::Vector, w::Vector; trace = true, color = palette(:default)[2], iscord = false, cordsize = 10, cord_color = :white)`**

    * **`v::Vector`**: 정사영할 벡터 (벡터형).
    * **`w::Vector`**: 정사영의 대상이 되는 벡터 (벡터형).
    * **키워드 인자**:
        * `trace`: 원래 벡터에서 정사영된 벡터로 이어지는 점선을 그릴지 여부 (기본값: `true`).
        * `color`: 정사영된 벡터의 색상 (기본값: `palette(:default)[2]`).
        * `iscord`, `cordsize`, `cord_color`: `show_vector` 함수의 키워드 인자와 동일합니다.

- 예제
```julia
grid(3,3, show = [0, 3, 0, 3])
show_vector([3, 1])
show_vector([1, 3], color = c[3])
projection([1, 3], [3, 1], color = c[1])
```
![Image](https://github.com/user-attachments/assets/80e02d74-7dac-449a-83c0-950b6a781c44)
