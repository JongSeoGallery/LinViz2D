**파일 이름**: LinViz2D.jl  
**파일 설명**: 2D 선형 대수 개념을 시각화하기 위한 줄리아(Julia) 함수 모음입니다. 좌표계 변환, 벡터 표시, 행렬식 계산, 선형 변환 효과를 직관적으로 보여주는 데 활용됩니다. Plots 패키지를 기반으로 그래픽을 생성하며, **multiple dispatch**를 통해 다양한 입력 유형을 지원합니다.

---

### 📌 주요 함수 설명

#### 1. **`grid` 함수**  
**기능**: 기본 또는 변환된 좌표계의 격자와 축을 생성합니다.  
- **`grid(x::Int64, y::Int64)`**: `[-x, x]` (가로)와 `[-y, y]` (세로) 범위의 기본 좌표계를 그림니다.  
- **`grid(x::Int64, y::Int64, matrix::Matrix)`**: 주어진 행렬로 좌표계를 변환한 후 격자를 그림니다.  

**매개변수**:  
- `x`, `y`: 좌표계의 범위 (정수).  
- `matrix` (선택): 2x2 변환 행렬 (예: 회전, 확대 행렬).  
- `show`: 표시할 축의 범위 (기본값: `[-x, x, -y, y]`).  
- `bg`: 배경색 (기본값: "black").  
- `grid`: 격자 표시 여부 (기본값: `true`).  

**예제**:  
```julia
# 기본 좌표계 (3x3 범위)
plt = grid(3, 3, show=[-5,5,-5,5], bg="white")

# 변환 행렬 적용 (45도 회전)
A = [cos(π/4) -sin(π/4); sin(π/4) cos(π/4)]
plt = grid(3, 3, A, gc=:lightblue)
```

---

#### 2. **`grid_sb` 함수**  
**기능**: 표준 기저 벡터(화살표)가 추가된 좌표계를 그림니다.  
- **`grid_sb(x::Int64, y::Int64)`**: 기본 기저 벡터 (x축, y축)를 표시합니다.  
- **`grid_sb(x::Int64, y::Int64, matrix::Matrix)`**: 변환된 기저 벡터를 표시합니다.  

**예제**:  
```julia
# 변환된 기저 벡터 (확대)
B = [2 0; 0 2]
plt = grid_sb(2, 2, B, gc=:gray)
```

---

#### 3. **`show_vector` 함수**  
**기능**: 벡터를 화살표로 표시하며 좌표값을 추가할 수 있습니다.  
- **`show_vector(vector::Vector)`**: 원점에서 시작하는 벡터.  
- **`show_vector(p1::Vector, p2::Vector)`**: `p1`에서 `p2`로 향하는 벡터.  
- **`show_vector(vector::Vector, matrix::Matrix)`**: 변환된 좌표계에서의 벡터.  

**매개변수**:  
- `color`: 화살표 색상 (기본값: 빨강).  
- `iscord`: 좌표값 표시 여부 (기본값: `false`).  

**예제**:  
```julia
plt = grid(3, 3)
show_vector([2, 1], color=:red, iscord=true)  # (2,1) 벡터
show_vector([1,1], [3,2], color=:green)       # (1,1) → (3,2)
```

---

#### 4. **`span` 함수**  
**기능**: 주어진 벡터 방향의 무한 직선을 점선으로 표시합니다.  
**예제**:  
```julia
span([1, 2], color=:blue)  # 벡터 [1,2] 방향 직선
```

---

#### 5. **`viz_det` 함수**  
**기능**: 행렬의 열벡터로 형성된 평행사변형과 행렬식 값을 그림니다.  
**예제**:  
```julia
C = [1 2; 3 4]
viz_det(C, color=:orange)
```

---

#### 6. **`linearmap` 함수**  
**기능**: 벡터 또는 단위원에 선형 변환을 적용해 결과를 표시합니다.  
- **`linearmap(vector::Vector, matrix::Matrix)`**: 단일 벡터 변환.  
- **`linearmap(matrix::Matrix)`**: 단위원을 변환한 타원 표시.  

**예제**:  
```julia
D = [1 -1; 1 1]  # 45도 회전 + 확대
linearmap([1,0], D, color=:purple)  # 벡터 변환
linearmap(D)                        # 단위원 변환 결과
```

---

#### 7. **`unit_circ` 함수**  
**기능**: 반지름 1의 단위원을 그림니다.  
**예제**:  
```julia
unit_circ(color=:pink)  # 분홍색 단위원
```

---

### 🚀 통합 예제  
```julia
using Plots

# 변환 행렬: 전단(shear) + 회전
M = [1 0.5; 0.5 1]

# 1. 변환된 격자 생성
plt = grid_sb(3, 3, M, show=[-5,5,-5,5], bg="white")

# 2. 벡터 [1,1] 변환 후 표시
show_vector([1, 1], M, color=:red, iscord=true)

# 3. 행렬식 영역 표시
viz_det(M, color=:teal)

# 4. 단위원 변환
linearmap(M)

# 5. 결과 출력
display(plt)
```

---

### 💡 사용 팁  
- **패키지 로드**: `using Plots, LinearAlgebra`를 먼저 실행하세요.  
- **색상 설정**: `palette(:default)`에서 색상 목록을 확인할 수 있습니다.  
- **행렬 입력**: 2x2 행렬만 지원되며, **열벡터** 기준으로 변환이 적용됩니다.
