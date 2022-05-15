import { Controller } from "@hotwired/stimulus"
import hljs from 'highlightjs';

export default class extends Controller {
  connect() {
      console.log("hello")
    hljs.highlightAll()

  }
}
