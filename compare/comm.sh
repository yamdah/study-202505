
# 状況を整えるだけ（必要なもの：1.変更対象データ、2.データ変更前、3.データ変更後）
# 1
touch test.txt
# 2
touch a1.txt
# 3
touch b2.txt

# 差分を更に比較にかける
list='wc -l < test.txt'
echo -n 変更対象件数：
echo -n $list
echo 件

count=0
for target in 'comm -13 a1.txt b2.txt'
do
  count='expr $count + 1'
  echo -n $count
  echo -n :
  grep $target test.txt;
    if [ $? = 0]; then
      echo ##########変更は正常です##########
    else
      echo #########想定外の変更です#########
    fi
done

# 想定外の操作を確認
comm -23 a1.txt b2.txt
