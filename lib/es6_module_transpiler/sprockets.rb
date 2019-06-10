require 'sprockets'
require 'grease'

mime_type = Tilt::ES6ModuleTranspilerTemplate.default_mime_type

if Sprockets.respond_to?(:register_engine)
  # Sprockets 2/3
  args = ['.es6']
  if Sprockets::VERSION.start_with?("3")
    args << Grease.apply(Tilt::ES6ModuleTranspilerTemplate)
    args << { mime_type: mime_type, silence_deprecation: true }
  else
    args << Tilt::ES6ModuleTranspilerTemplate
  end

  Sprockets.register_engine(*args)
else
  # Sprockets 4 or later
  Sprockets.register_mime_type(mime_type, extensions: %w(.es6 .js.es6))
  Sprockets.register_transformer(mime_type, 'text/javascript', Grease.apply(Tilt::ES6ModuleTranspilerTemplate))
end
