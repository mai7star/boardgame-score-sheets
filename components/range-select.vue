<template>
  <b-form-select :value="value" @input="$emit('input', $event)">
    <b-form-select-option v-for="v in values" :key="v" :value="v">{{ v }}</b-form-select-option>    
  </b-form-select>
</template>

<script>
export default {
  props: {
    value: { type: Number, default: 0 },
    min: { type: Number, required: true },
    max: { type: Number, required: true }
  },

  computed: {
    values() {
      return Array(this.max - this.min + 1).fill(true).map((v, k) => k + this.min)
    }
  }
}
</script>
