<template>
  <b-form-textarea v-model="value" :placeholder="placeholder" :rows="rows" @update="update" />
</template>

<script>
export default {
  props: {
    placeholder: { type: String, default: '' },
    rows: { type: Number, default: 2 }
  },

  data() {
    return {
      value: ''
    }
  },

  methods: {
    update(value) {
      const sum = value.split(/[,\s]+/).map(e => parseInt(e, 10)).filter(Boolean).reduce((p, c) => p + c, 0) || 0
      this.$emit('input', sum)
    }
  }
}
</script>
