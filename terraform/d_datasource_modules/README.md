### Data sources

AWS와 같은 특정 CSP에 대해 테라폼이 데이터 소스라는 동적 정보를 제공한다.
이를 API를 통해서 사용할 수 있다.

AMI나 가용영역(AZ), IP 주소 등에 대한 정보는 동적으로 변할 수 있으므로 사용자가 직접 입력하지 않고 이를 사용할 수 있다.

### 모듈
Terraform 코드를 재사용 가능하게 만들어준다.  
아래와 같이 저장소를 활용하거나 로컬 경로에서 모듈을 불러올 수 있다.  
원격 저장소를 활용하는 경우 `terraform get`으로 먼저 모듈을 불러오자.
```
module "example" {
    source = "github.com/user/modules"
}

module "example2" {
    source = "./modules"
}
```

`output` 을 통해서 코드의 일부를 모듈 출력으로 사용할 수 있다.
```
output "output-example" {
    value = "${module.example2.<...>}"
}
```