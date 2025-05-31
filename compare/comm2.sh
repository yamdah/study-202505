
# 状況を整えるだけ（必要なもの：1.登録用データ）
# 1
touch test.txt

# 差分を更に比較にかける
list='wc -l < test.txt'
echo -n レコード件数：
echo -n $list
echo 件

# INSERT
sort -o test.txt test.txt
count=0
echo -en 'INSERT INTO test_table (test_data, created) VALUES'
while read testData;
do
  count='expr $count + 1'
  echo -en '("'
  echo -en $testData
  if [$count -eq $list]; then
    echo -en '", CURRENT_TIMESTAMP())'
  else
    echo -e '", CURRENT_TIMESTAMP()),'
  fi
done < test.txt
echo -e ';'

# DELETE
sort -o test.txt test.txt
count=0
echo -en 'DELETE FROM test_table WHERE test_data IN ('
while read testData;
do
  count='expr $count + 1'
  echo -en '"'
  echo -en $testData
  if [$count -eq $list]; then
    echo -en '"'
  else
    echo -e '",'
  fi
done < test.txt
echo -e ');'

