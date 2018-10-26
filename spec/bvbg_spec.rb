require 'spec_helper'
require 'date'

RSpec.describe Bvbg do

  let(:date) { Date.parse('2017-08-28') }
  let(:bvbg86_file) { File.new('spec/fixtures/bvbg86_example.xml') }
  let(:bvbg86_parser) { Bvbg::Parser.new(bvbg86_file, date) }
  let(:bvbg87_file) { File.new('spec/fixtures/bvbg87_example.xml') }
  let(:bvbg87_parser) { Bvbg::Parser.new(bvbg87_file, date) }
  let(:dummy_file) { File.new('spec/fixtures/dummy.txt') }
  
  describe '#parse' do 
    context "when calling parser" do
      it "should return an array" do
        expect(bvbg86_parser.parse).to be_an(Array)
      end
      it "should yield control if called with block" do
        expect { |b| bvbg86_parser.parse(&b) }.to yield_control
        result = bvbg86_parser.parse
        expect { |b| bvbg86_parser.parse(&b) }.to yield_control.at_most(result.count).times
      end
      it "should raise file unsupported if file is not supported" do
        expect { Bvbg::Parser.new(dummy_file, date).parse }.to raise_error("Unsupported file")
      end
    end

    context 'when parsing bvbg86' do
      it "should return prices" do
        expect(bvbg86_parser.parse.count).to eq 4
      end
      it "should reads the close field in the XML file" do
        expect(bvbg86_parser.parse.first[:close]).to eq "13.87"
      end

      it "should reads the date field in the XML file" do
        expect(bvbg86_parser.parse.first[:date]).to eq Date.parse('2017-08-28')
      end

      it "should reads the open field in the XML file" do
        expect(bvbg86_parser.parse.first[:open]).to eq "13.93"
      end

      it "should reads the high field in the XML file" do
        expect(bvbg86_parser.parse.first[:high]).to eq "14.03"
      end

      it "should reads the low field in the XML file" do
        expect(bvbg86_parser.parse.first[:low]).to eq "13.76"
      end

      it "should reads the average field in the XML file" do
        expect(bvbg86_parser.parse.first[:average]).to eq "13.89"
      end

      it "should reads the bid field in the XML file" do
        expect(bvbg86_parser.parse.first[:bid]).to eq "13.85"
      end

      it "should reads the ask field in the XML file" do
        expect(bvbg86_parser.parse.first[:ask]).to eq "13.87"
      end

      it "should reads the volume field in the XML file" do
        expect(bvbg86_parser.parse.first[:volume]).to eq "378100009"
      end

      it "should reads the quantity field in the XML file" do
        expect(bvbg86_parser.parse.first[:quantity]).to eq "27208100"
      end

      it "should reads the trades field in the XML file" do
        expect(bvbg86_parser.parse.first[:trades]).to eq "18762"
      end

      it "should reads the adj_close field in the XML file" do
        expect(bvbg86_parser.parse.first[:adj_close]).to eq "-0.07"
      end

      it "should reads the security field in the XML file" do
        expect(bvbg86_parser.parse.first[:symbol]).to eq "PETR4"
      end
    end

    context "when reading bvbg87" do
      it "should return indexes" do
        expect(bvbg87_parser.parse.count).to eq 24
      end
      it "should read the symbol field" do
        expect(bvbg87_parser.parse.first[:symbol]).to eq "BDRX"
      end
      it "should read the value field" do
        expect(bvbg87_parser.parse.first[:value]).to eq "4266.32"
      end
    end
  end

end
