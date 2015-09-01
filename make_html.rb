

#第2引数のタグ名と第3引数のテキストからhtmlタグを生成し、書き込む
def make_tag(tag_type,text)
  case tag_type
  when "table" then
    tr_count = ARGV[2].to_i #縦要素数
    td_count = ARGV[3].to_i #横要素数

    tag = "<table>\n  <tbody>\n"
    tr_count.times do
      tag += "    <tr>\n"
      td_count.times do
        tag += "      <td>!text!</td>\n"
      end
      tag += "    </tr>\n"
    end
    tag += "  <tbody>\n</table>\n"
    puts tag

  when "ol","ul"
    li_count = ARGV[2].to_i #liタグを作る個数
    tag = "<" + tag_type + ">\n"
    li_count.times do
      tag += "  <li>!text!</li>\n"
    end
    tag += "</" + tag_type + ">\n"
  when "a" then
    tag = "<" + tag_type + " href=\"https://www.google.co.jp\">" + text + "</" + tag_type + ">\n"
    
  else
    tag = "<" + tag_type + ">" + text + "</" + tag_type + ">\n"
  end
  add(tag)
end

def add(tag_text)
  File.open("test.html", "a+") do |io|
    io.puts tag_text  #文末に改行を入れて書き込む
  end
end

#引数に取ったワードを含む行を消す
def delete(delete_text)
  out = []
  File.open('test.html', 'r') do |f|
    f.each_line.with_index(1) do |line,n|
      unless line.include?(delete_text)
        out << line
      end
    end
  end

  File.open("test.html", "w") do |io|
    out.each do |line|
      p io.puts line
    end
  end
end

#最後の行だけ消す
def delete_last_line()
  line_length = File.read('test.html').count("\n")
  out = []
  File.open('test.html', 'r') do |f|
    f.each_line.with_index(0) do |line,index|
      unless index == line_length -1
        out << line
      end
    end
  end

  File.open("test.html", "w") do |io|
    out.each do |line|
      io.puts line
    end
  end
end

def replace_text(text)
  f=File.open("test.html","r")
  buffer = f.read()

  #中身を変える
  buffer_new = buffer.sub("!text!",text)
  f=File.open("test.html","w")
  f.write(buffer_new)
  f.close()
end

case ARGV[0]
when "add" then
  tag = make_tag(ARGV[1],ARGV[2])
when "add_text" then
  replace_text(ARGV[1])
when "delete" then
  delete(ARGV[1])
when "delete_last_line" then
  delete_last_line()
else
  puts "一致するものがありません"
end
