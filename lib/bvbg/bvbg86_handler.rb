class Bvbg::Bvbg86Handler
  def initialize(parser)
    @parser = parser
  end

  def self.accept?(parser)
    parser.for_tag(:BizGrpDtls).each do |file_type|
      return true if file_type[:BizGrpTp].include?("86")
    end
    false
  end

  def all_lines
    @parser.for_tag(:PricRpt).each do |item|
      yield build_line(item)
    end
  end

  def build_line(raw_item)
    {
      name: raw_item[:SctyId][:TckrSymb],
      symbol: raw_item[:SctyId][:TckrSymb],
      close: raw_item[:FinInstrmAttrbts][:LastPric],
      date: Date.parse(raw_item[:TradDt][:Dt]),
      open: raw_item[:FinInstrmAttrbts][:FrstPric],
      high: raw_item[:FinInstrmAttrbts][:MaxPric],
      low: raw_item[:FinInstrmAttrbts][:MinPric],
      average: raw_item[:FinInstrmAttrbts][:TradAvrgPric],
      bid: raw_item[:FinInstrmAttrbts][:BestBidPric],
      ask: raw_item[:FinInstrmAttrbts][:BestAskPric],
      volume: raw_item[:FinInstrmAttrbts][:NtlFinVol],
      quantity: raw_item[:FinInstrmAttrbts][:FinInstrmQty],
      trades: raw_item[:TradDtls][:TradQty],
      adj_close: raw_item[:FinInstrmAttrbts][:OscnPctg],
      future_adj: raw_item[:FinInstrmAttrbts][:AdjstdValCtrct]
    }
  end

  protected

  def bd_or_nil(value)
    if not value.nil?
      return BigDecimal.new(value)
    end
  end

end