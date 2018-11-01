class Bvbg::Bvbg87Handler
  def initialize(parser)
    @parser = parser
  end

  def self.accept?(parser)
    parser.for_tag(:BizGrpDtls).each do |file_type|
      return true if file_type[:BizGrpTp].include?("87")
    end
    false
  end

  def all_lines
    @parser.for_tag(:BizGrpDtls).each do |file_details|
      @date = Date.parse(file_details[:CreDtAndTm].to_s.split('T')[0])
    end
    @parser.for_tag(:IndxInf).each do |item|
      yield build_line(item)
    end
  end

  def build_line(raw_item)
    {
      symbol: raw_item[:SctyInf][:SctyId][:TckrSymb],
      value: raw_item[:SctyInf][:ClsgPric],
      date: @date
    }
  end

end