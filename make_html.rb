

#第2引数のタグ名と第3引数のテキストからhtmlタグを生成し、書き込む
def make_tag(tag,text)
  tag_all = "<" + tag + ">" + text + "</" + tag + ">"
end

def add(tag_text)
  File.open("test.html", "a+") do |io|
    p io.puts tag_text  #文末に改行を入れて書き込む
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
      p io.puts line
    end
  end
end

case ARGV[0]
when "add" then
  tag_text = make_tag(ARGV[1],ARGV[2])
  add(tag_text)
when "delete" then
  delete(ARGV[1])
when "delete_last_line" then
  delete_last_line()
else
  puts "一致するのもがありません"
end
