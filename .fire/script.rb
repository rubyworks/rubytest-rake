book :test do
  desc "run unit tests if lib changes"
  rule 'lib/**/*.rb' do
    #
  end
end

book :doc do
  private
  desc "update yard docs if lib changes"
  rule 'lib/**/*.rb' do
    sh "yard doc"
  end
end

