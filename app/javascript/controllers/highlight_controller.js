import { Controller } from "@hotwired/stimulus"
import hljs from 'highlightjs';
export default class extends Controller {
  connect() {
    hljs.highlightAll()

  }
}
