import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["checkbox", "progress", "bar", "error"]
  static values = { url: String, date: String }

  connect() {
    this.checkboxTargets.forEach(checkbox => { checkbox.disabled = false })
  }

  async save({ currentTarget: checkbox }) {
    const checked = checkbox.checked
    checkbox.disabled = true
    this.errorTarget.hidden = true

    try {
      const response = await fetch(this.urlValue, {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
        },
        body: JSON.stringify({
          date: this.dateValue,
          exercise_key: checkbox.dataset.exerciseKey,
          set_number: Number(checkbox.dataset.setNumber),
          checked
        })
      })

      if (!response.ok) {
        throw new Error(response.status === 409
          ? "This checklist is out of date. Refresh the page to see today’s workout."
          : "Couldn’t save this set. Tap it again to retry.")
      }
    } catch (error) {
      checkbox.checked = !checked
      this.errorTarget.textContent = error instanceof TypeError
        ? "Couldn’t reach the tracker. Check your connection and try again."
        : error.message
      this.errorTarget.hidden = false
    } finally {
      checkbox.disabled = false
      this.updateProgress()
    }
  }

  updateProgress() {
    const total = this.checkboxTargets.length
    const completed = this.checkboxTargets.filter(checkbox => checkbox.checked).length
    this.progressTarget.textContent = completed === total
      ? "Workout complete"
      : `${completed} of ${total} sets`
    this.barTarget.value = completed
  }
}
