class Bvbg::Parser

  def initialize(file, date)
    @date = date
    @file = file
    @handlers = [Bvbg::Bvbg86Handler, Bvbg::Bvbg87Handler]
  end

  def parse
    parser = Saxerator.parser(@file) do |config|
      config.adapter = :ox
      config.symbolize_keys!
    end
    
    handler = get_handler(parser)
    raise "Unsupported file" unless not handler.nil?
    
    lines = []
    
    handler.all_lines do |line|
      yield line if block_given?
      lines << line
    end

    lines

  end

  def get_handler(parser)
    supported_handler = nil
    
    @handlers.each do |handler|
      if handler.accept? parser
        supported_handler = handler.new(parser)
      end
    end

    supported_handler

  end
  
end