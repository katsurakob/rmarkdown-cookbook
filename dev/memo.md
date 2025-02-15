# 校正を手伝ってくれる方へ

基本的に, タイポやサンプルコードが動作しない等あからさまなミスの指摘のみを受け付けます. 細かい言い回しの変更は, 誤解を招く, 文中で一貫性がないなど明確な理由がない限り対処しない予定です.

## 動作環境

* 私の作業環境は主に Ubuntu 20.04 です.
* 明白な誤字脱字の修正程度ならば github 上の操作だけでもできます

* ソースコードをいじる, 動作確認もしたいという場合は `SETUP.md` を参考にしてください (renv でパッケージのバージョン管理ができます).
* コマンドラインで git で GitHub にアクセスできる. 以下のようにしてローカル git リポジトリを設定する想定のため, また更新時刻を取得するため 
  
    ```
    git clone ...
    git remote add upstream git@github.com:yihui/rmarkdown-cookbook.git
    ```

* tinytex だと tikz に必要な LaTeX パッケージのいくつかを自動インストールできないかもしれません. (TODO: 現在 index.Rmd にも同じ処理を書いているが, これはあまり行儀が良くないので修正したい)

    ```
    tinytex::tlmgr_install(c("pgf", "preview", "xcolor", "grfext"))
    ```

* **cairoDevice** の引用のためにインストールが必要です. これには `libgtk2.0-dev` のインストールが必要かもしれません.

    ```
    sudo apt install libgtk2.0-dev
    ```
* Asymptote のグラフ描画のために Asymptote のインストールが必要です

    ```
    sudo apt install asymptote
    ```

* Windows の動作は確認していません

TODO: github workflow の動作設定

## ワークフロー

* フォントやインデント等の文章のスタイルやレイアウト, 特に PDF上のものはこれから rmdja の更新で解決していく予定なので, 本文の誤字脱字・誤訳・分かりづらい言い回し等を主に指摘していただければと思います. issue での指摘でも直接プルリクを上げても構いません.
* JP フォルダ以下に翻訳版が, EN フォルダに底本としたオリジナルが入っているので, 訳を確認したい方は両者の diff を取るとやりやすいと思います.
* `gh-pages` ブランチにはソースファイルや作業用ファイルを含めません. master か work からコミットしてください
* 本家はデプロイにTravis CI とか使ってますが, こちらは現状, RStudio のツールバーからビルドしてGithubに上げるという作業を手動でやっています (そのうち対応します)


## 翻訳・校正の方針

* 訳語はできれば統一する
* Yihui は括弧書きで補足説明を多用するが, 日本語では語順の関係で分かりづらくなる気がする (個人の感想?) のでなるべく括弧を使わない語順に置き換える
  * ただし括弧であることに強い意味がある場合は括弧を保持する.
* 原文の単語を1対1で置き換えたような訳文が嫌いなので同一文中での代名詞とか重複する名詞はなるべく省いている, ただし強調すべきと判断したときは省かない.
* HTML 版の表示の関係で見出しの文字数はなるべく減らしたい
* 副詞や機能語はひらがなで. 例えば以下のような表現は避ける
  * 下さい
  * と言うふうに
  * 出来る
  * 矢張り
  * 成る程

* エラーメッセージ等は英語版にするかローカライズされたものを使うか, 後者ならローカライズされてないものはどうするか
* ダミーのファイル名とかをなるべく日本語にしたほうがメリハリがきいて見やすいか?

### ターム・要注意単語の訳語

* developer advocate - 日本語訳が決まってない新しい概念. また職位でもあるので固有名詞として扱う?
* 多用される助動詞 may - 「することもできます」程度にする. おそらく should や can より強制力や信念の弱いニュアンス?
  * can は区別がつくようすこしひねった文言にする?
* plot, image, figure, etc.: 文脈に応じて「図」「グラフ」の2通りに訳し分ける?
* features と function/functionality
* output format - 出力フォーマット
* inline R expression - 「インライン (行内) R 評価式」だと堅苦しすぎるので「インライン (R) コード」する
  * 12章で expressions と (line of) codes の違いに言及している記述に出会ってしまった ...
* Section X/Chapter X - X節, X章?. section header のときはこれらの総称として「セクション」と表現する
* conditional function - 9章のみ登場. `knitr::is_html_output()` 等のことを指していると思われる. ここでしか使われないので用語として扱わず「条件付けのための関数」 と表現する.
* tips/trick/hack - それぞれ「豆知識」「小ワザ」「裏ワザ」小ワザとかはくだけすぎ?
* raw content/text/verbatim - raw content - プレーンテキストでいいか. verbatim は?
* LaTeX distribution - ---配布パッケージで良くない?
* fenced code block: Pandoc の公式ドキュメントも和訳されていないのでそのまま. 文脈に応じて何かを囲んでいるというニュアンスの修飾語句や補足を付ける

以下, まだはっきり決めてない

* subfigure - 「サブフィギュア」はわかりにくい...
* full example - ...
* 行内で R コードを書く時 `=` の前後にスペース入れたり入れなかったりは意味があるのか? (1箇所だけ明らかに挙動が変わる用例がある)
* base R graphics/grid graphics - この場合の base/grid ってパッケージ名?
* "in the wild" のニュアンス (Ch.16)

## 組版 TODO

* kranz は欧文なので和文にするしかない
* ~~今は bxjs だが完成したら ltjs にする~~ lualatex で bxjsreport にする
  * ~~ltjsreport には `\frontmatter` が定義されていない?~~
* いろいろと欧文向けのマクロ設定をしているようなので確認
  * キャプションだけ左揃えになっている?
* subsubsection で2桁になるとインデントが狂ってる
* ~~索引の漢字の読み指定が必要~~
* TODO: 15章の最後が日本語だとわかりにくいので適当なフリーフォントを探す

## cookbook に足りない話 (やや細かい話)

* pdf に svg を (knitr::include_graphics で) 埋め込む方法
* Fenced Div で二段組にすべきか
  + 特に beamer の場合は latex コードを直接埋め込むこともできる.  
* .Rmarkdown にすると RStudio は認識するが bookdown が勝手に読み込むことはない https://github.com/rstudio/blogdown/issues/97#issuecomment-307931024 root ディレクトリと bookdown デフォルト挙動の問題
* LaTeX のテンプレートを R Markdown に移植するときのポイント
