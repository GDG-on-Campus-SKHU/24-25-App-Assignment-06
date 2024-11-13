# ✏️ 24-25 App Assignment 05

### 🙋🏻‍♀️ Profile and Goal Management App 만들기 
#### 🗣️ 과제  설명 
  지난 차시에 만들었던 MyProfile에 `SQflite`를 이용하여, 목표를 추가하고 삭제하는 기능을  만들어봅니다. **Goal을 추가하고 삭제하는 기능은 필수로 구현**해야하며, Validation과 목표를 수정하는 기능은 선택 사항입니다. 아래 예시 참고하며, 수행하시면 됩니다. 

>Goal 모델을 정의할 때, 데이터베이스 테이블에는 두 가지 속성이 필요합니다. 첫 번째는 `id`로, 데이터 타입은 정수(int)입니다. 두 번째는 `title`로, 데이터 타입은 문자열(string)입니다.
이 두 속성은 Dart 파일에서도 동일하게 선언해야 합니다. 즉, Goal 모델을 만들 때는 데이터베이스 테이블과 Dart 모델 파일 모두에서 `id`와 `title` 두 가지 속성을 포함해야 합니다.

#### ✔️ 필수 요구 사항
- Goal 추가 기능 
    - App Bar에 있는 추가하는 아이콘 버튼을 눌렀을 때, Goal를 추가할 수 있는 기능
- Goal 삭제 기능 
    - 삭제 아이콘을 눌렀을 때 해당 Goal이 삭제되는  기능 
#### 👏🏻 선택 요구 사항 
- 유효성 검사 기능 
    - Goal을 추가할 때, 아무 값도 입력하지 않고, 추가하기 버튼을 누르면 `목표를 입력하세요`라는 메세지 출력
- 수정 기능 
    - 삭제 버튼 옆에 수정 관련 아이콘을 누르면 해당 Goal을 수정할 수 있는 기능 

*cf. 수정 기능은 `update()`를 활용하면 됩니다.*
#### 🤷🏻‍♀️ 예시


<details><summary>필수 사항 예시 
</summary>
<details><summary>기본 화면
</summary>

![required_example1 png](https://github.com/user-attachments/assets/a745a883-509a-4b16-8543-9e5745618ac4)
</details>
<details><summary>목표 추가 작성 화면 
</summary>


![required_example3](https://github.com/user-attachments/assets/5a12ce31-88d5-48f6-ae4f-9154c0b46fa5)
</details>

<details><summary> 목표 추가 완료 화면
</summary>

![required_example2](https://github.com/user-attachments/assets/b0774f3b-362f-480d-8e84-ac3bfc19e453)
</details>




</details>


<details><summary>  추가 사항 예시 
</summary>



<details><summary> 유효성 검사 실행된 화면 
</summary>

![optional_example2](https://github.com/user-attachments/assets/2080f596-f76e-463e-9d99-83cd968df9e3)



</details>

<details><summary> 목표 수정 화면 
</summary>

![optional_example3](https://github.com/user-attachments/assets/733daf38-17e8-476e-80c1-e8f8eadd5b25)
</details>

<details><summary> 추가 완료 화면 
</summary>

![optional_example1](https://github.com/user-attachments/assets/7712c963-155b-43b3-a8b8-d3071da82432)
</details>

</details>

---
### ‼️ 과제 제출 관련
레포지토리 `fork`를 통해 과제를 수행하셔야 합니다. (AIOS 때 진행한 fork 방식과 동일 노션에 추가자료란에 첨부되어있습니다.) 과제에 대한 코드를 작성하시고, `Pull Request(PR)`를 작성해주시면 됩니다. PR 작성하실 때, 궁금한 점이나 어려웠던 점 등을 적어주세요. 그리고 **구현한 UI 사진도 같이 첨부해주세요**
과제 제출 마감 기한은 **11월 17일 23:59**까지입니다.

