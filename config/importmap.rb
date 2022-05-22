# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.js"
pin "@hotwired/stimulus", to: "https://ga.jspm.io/npm:@hotwired/stimulus@3.0.1/dist/stimulus.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "highlightjs", to: "https://ga.jspm.io/npm:highlight.js@11.4.0/es/index.js"
pin "stimulus-clipboard", to: "https://ga.jspm.io/npm:stimulus-clipboard@3.1.0/dist/stimulus-clipboard.es.js"
