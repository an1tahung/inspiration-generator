class PexelScraper

  PATH = "https://www.pexels.com/popular-photos/#content"
  class << self
    def get_random_pexel
      pictures = Nokogiri::HTML(open(PATH)).xpath("//img/@src")
      index = rand(0..pictures.size-1)
      img = pictures[index].value.sub(/-medium/, '')
      too_small?(img) ? get_random_pexel : img
    end

    def too_small?(url)
      img = Magick::Image::read(url)[0]
      puts "This image is #{img.columns}x#{img.rows} pixels"
      img.columns < 1920 || img.rows < 1080
    end
  end
end