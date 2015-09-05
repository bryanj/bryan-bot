require_relative 'base'
require 'net/http'
require 'nokogiri'

module Task
  class FinanceTask < BaseTask
    def self.message(m)
      user, message = parse(m)
      if message == "!시총"
        print_finance(m)
      end
    end

    private
    def self.print_finance(m)
      http = Net::HTTP.new("finance.daum.net", 80)
      resp = http.get("/quote/marketvalue.daum?stype=Q")
      doc = Nokogiri::HTML(resp.body)
      first, second = doc.css("#tabSBody1 tr")[2..3]
      value1 = first.css("td")[5].text.gsub(",", "").to_i
      value2 = second.css("td")[5].text.gsub(",", "").to_i
      diff = value1 - value2
      if first.css("td")[1].text.strip == "다음카카오"
        m.reply "다음카카오는 현재 코스닥 시가총액 1위이며, 2위와의 차이는 #{diff}억원입니다."
        ratio = (value1.to_f / value2).round(4)
        m.reply "1다음카카오 = #{ratio}셀트리온"
      else
        m.reply "다음카카오는 현재 코스닥 시가총액 2위이며, 1위와의 차이는 #{diff}억원입니다."
        ratio = (value2.to_f / value1).round(4)
        m.reply "1다음카카오 = #{ratio}셀트리온"
      end
    end
  end
end
