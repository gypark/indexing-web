# Indexing-Web

## 개요

어떤 책의 색인이 2단이나 3단 등으로 구성되어 있고, 동일한 내용을 여러 키워드를 통해 참조하고 있다고 하자. 전공 서적이나 기술 서적의 경우 이런 경우가 많다.

```
A
Addition			      5,20
Arithmetic			      5-9
	Addition		      5,20
	Division		      6
	Multiplication		  7-8
	Subtraction		      8-9
D
Division			      6
M
Multiplication			  7-8
N
Numeric			          3-18,20,30-40
	Calculation		      5-8
		Addition	      5,20
		Division	      6
		Multiplication	  7-8
		Subtraction	      8-9
S
Subtraction			      8-9
```

위 색인의 경우 "Addition", "Division" 등의 항목이 세 번씩 나온다. 이 색인을 여러 사람이 분담해서 번역하는 경우, 또는 한 명이 하더라도 수천 개의 색인 항목을 번역하다보면 일관성이 없어져서 한 번은 "덧셈"이라고 번역하고 또 다른 곳에서는 "더하기"라고 번역하는 식으로 달라질 수 있다.

따라서 일관성 있게 번역하려면 색인 항목들을 알파벳 순으로 보다가 페이지 순으로 바꿔서 다시 보는 식의 과정을 자꾸 반복해야 하는데, 엑셀에서 이렇게 하려니 썩 편하지 않아서 만들어보았음

## 요구 사항

* Perl - 5.10 이상(아마도)
* 다음 플랫폼에서 이상없이 실행되는 것을 확인하였음
 * 윈도우10 + Strawberry Perl 5.22
 * 우분투 리눅스 + Perl 5.18
 * 맥 OS X 10.11 + Perl 5.18

## 설치 및 실행

1. 적당한 디렉토리에 저장소를 복제하거나 ZIP 파일을 다운받아 푼다.

    ``` bash
    $ git clone https://github.com/gypark/Indexing-Web.git
    ```

2. 필요한 펄 모듈을 설치한다.

    ``` bash
    $ cd Indexing-Web
    $ cpanm --installdeps .
    ```

3. 데이터베이스를 설치한다.
 * `config/schema_sqlite.sql`을 참고하여 자신이 사용하는 데이터베이스 시스템에 DB와 테이블을 추가하거나
 * SQLite 데이터베이스 파일인 `db/mybook.db3.example` 파일을 복사해서 사용한다.

    ```` bash
    $ cp db/mybook.db3.example db/mybook.db3
    ````

4. 설정 파일을 만들어준다. 샘플로 들어있는 `config/index_web.conf.example` 파일을 `config/index_web.conf`로 복사한 후 수정한다.

5. 실행한다.

    ``` bash
    $ perl -Ilib index-web daemon                     # 3000번 포트 사용
    $ perl -Ilib index-web daemon -l "http://*:9999"  # 다른 포트를 쓸 경우
    ```

6. 웹 브라우저로 `http://localhost:3000`에 접속한다.


## 사용법 예시

### 색인 작업을 위해 준비된 엑셀 파일

`example/mybook_index.xlsx` 파일

* 엑셀 파일의 형식은 정확히 이 파일과 동일해야 한다.
* 1행과 2행은 필드이름이 들어가는 부분이니 고치지 말고, 3행부터 데이터가 들어 있어야 한다.

![스크린샷1](example/indexing-shot10.png?raw=true)

### 첫 실행 후 화면

* 이 엑셀 파일을 "Upload XLSX to DB"에 있는 파일 업로드 폼을 통해 업로드한다.

![스크린샷2](example/indexing-shot20.png?raw=true)

### 엑셀 파일 업로드 후

* "Go to"에 있는 "Row"는 엑셀 파일의 행번호와 동일하다. 1단 항목의 행번호들이 나열되어 있다.
* "Page"는 각 색인 항목들이 가리키는 페이지 번호가 정렬되어 있다. 0페이지는 페이지가 명시되지 않은 항목들이 나타난다.

![스크린샷3](example/indexing-shot30.png?raw=true)

### 엑셀 파일의 행 기준으로 보기

* 엑셀 파일과 동일한 순서로 1단 항목들과 그 항목에 속한 2단, 3단 항목들을 보여준다.
* "pages" 컬럼에 있는 숫자를 클릭하면 해당 페이지로 이동한다.

![스크린샷4](example/indexing-shot40.png?raw=true)

### 특정 페이지에 해당하는 색인 항목들 보기

* 특정한 페이지(스크린샷의 경우는 5페이지)에 해당하는 색인 항목들을 보여준다. 동일한 "Addition"이 서로 다르게 번역된 것을 확인하고 수정할 수 있다.

![스크린샷5](example/indexing-shot50.png?raw=true)

* "Arithmetic"이나 "Calculation"은 20페이지에 해당되지는 않지만, 그 하위 항목인 "Addition"만 따로 표시될 경우 맥락을 정확히 알 수 없어 불편하므로 상위 항목들도 같이 표시한다.

![스크린샷5](example/indexing-shot51.png?raw=true)

### 번역 수정

* 항목을 번역하고 "update" 버튼을 누르거나 엔터를 치면 저장된다. 한 항목을 두 번 이상 번역할 경우 과거의 번역 내역을 보여주므로 수정한 이력을 파악하거나 다시 되돌릴 수 있다.
* 엑셀 파일을 다운로드할 때는 가장 마지막에 저장한 내용이 반영된다.

![스크린샷6](example/indexing-shot60.png?raw=true)

### 잠그기

* "Numeric" 같은 항목은 수십 페이지에 걸쳐서 계속 표시되므로, 페이지를 넘길 때마다 자꾸 눈에 들어오면 불편할 수 있다. 어떤 항목을 번역하고 나서 더 이상 신경쓰고 싶지 않거나 확정하는 의미로 "Lock"에 체크하여 저장하면 그 다음부터는 입력 폼이 아니라 평범한 텍스트로 출력된다.
* 체크를 해제할 수도 있다.

![스크린샷7](example/indexing-shot70.png?raw=true)

### 다음 페이지로 이동

* 이런 식으로 한 페이지씩 번역하고 다음 페이지로 진행한다. 2단이나 3단 항목을 번역할 때는 다시 "Row" 기준으로 보면서 같은 그룹의 다른 항목들의 번역 내용을 참고할 수도 있다.

![스크린샷8](example/indexing-shot80.png?raw=true)

### 엑셀 파일로 다운로드

* 첫 페이지의 "Download" 버튼을 누르면 현재 DB에 저장된 내용대로 엑셀 파일이 생성된다.
* 한 항목을 여러 번 번역했을 경우 가장 마지막에 저장한 내용이 반영된다.
* "코멘트", "번역자", "잠금" 필드는 필요하면 놔두고(나중에 다시 업로드할 때 DB에 반영할 수 있다), 작업이 다 끝나면 지우거나 말거나...

![스크린샷9](example/indexing-shot90.png?raw=true)

### DB 지우기

테스트가 끝났다거나 기타 등등의 이유로 DB의 내용을 다 지우고 싶다면:

* 그냥 `db/XXXXX.db` 파일을 삭제하고 새로 빈 DB 파일을 복사하거나
* 웹 브라우저로 `localhost:3000/cleardb`에 접속해서 "DELETE ALL" 버튼을 누른다.

