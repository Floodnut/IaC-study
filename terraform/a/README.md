### 명령

`terraform console`
- `terraform` 콘솔을 사용할 수 있다.

`terraform init`
- provider를 초기화하고 플러그인을 다운로드 한다.

`terraform plan`
- 실제 인프라에 테라폼 파일을 적용하지 않고도 사전 계획을 확인할 수 있다.
- `terraform plan -out <out.terraform>` 을 통해 출력값을 확인하고 이용할 수 있다.

`terraform apply`
- 테라폼 파일을 실제 인프라에 반영함
- `terraform apply out.terraform` 으로 이전 `plan` 단계에서 출력한 값 만을 반영할 수도 있다.
- `plan` 단계를 거치지 않는 것이 분명히 빠르다.
- 하지만 실제 프로덕션 단계에서는 `plan` 을 통한 검증을 꼭 수행하자.

`terraform destroy`
- 프로덕션 환경에서 `destroy` 를 사용하면 전체 인프라를 삭제할 수 있으니 사용하지 않도록 주의하기.

## 변수 타입

Terraform이 자동으로 타입을 할당할 수도 있지만 명시적으로 지정할 수도 있다.

```go
/* main.tf */
variable "myvar" { //terraform plan, apply 없이 테스트 할 수 있음.
  //type = "string" //deprecated
  type = string
  default = "hello terraform"
}

variable "mymap" { //terraform plan, apply 없이 테스트 할 수 있음.
  type = map(string)
  default = {
    mykey = "value"
  }
}

variable "mylist"{
    type = list
    default = [1,2,3]
}
```

`type` 으로 지정할 수 있는 기본 타입은 다음과 같다.

- string
- number
- bool

`type` 으로 지정할 수 있는 복합 타입은 다음과 같다.

- List
    - `[ … ]` 형태
    - ordered
    - 각 원소가 모두 같은 타입을 가진다.
- Set
    - `[ … ]` 형태
    - unordered & unque
    - 출력 시 정렬함.
- Map
    - `{ “key” = “value” }` 형태
    - 모든 속성이 같은 타입을 가진다.
- Object
    - `{ “key” = “value”, … }` 형태
    - 각 속성이 서로 다른 타입을 가질 수 있다.
- Tuple
    - `[ … ]` 형태
    - 각 원소가 서로 다른 타입을 가질 수 있다.