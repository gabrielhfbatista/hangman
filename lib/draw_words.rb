class DrawWords
    def self.draw(option = 1)
        v = []
        if option == 1
            File.open(File.expand_path('../../words.txt', __FILE__), 'r') do |arq|
                while line = arq.gets
                    v.push(line)
                end
            end        
            v.sample.strip
        elsif option == 2
            File.open(File.expand_path('../../palavras.txt', __FILE__), 'r') do |arq|
                while line = arq.gets
                    v.push(line)
                end
            end        
            v.sample.strip
        elsif option == 3
            File.open(File.expand_path('../../palabras.txt', __FILE__), 'r') do |arq|
                while line = arq.gets
                    v.push(line)
                end
            end        
            v.sample.strip
        else
            return puts "Option Invalid! There's no option like that!"
        end 
    end
end