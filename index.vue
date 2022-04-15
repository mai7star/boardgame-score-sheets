<template>
  <div class="container">
    <div class="row">
      <div class="col">
        <h3>テラフォーミング・マーズ</h3>
      </div>
    </div>

    <div class="row align-items-center mt-3">
      <div class="col-3 text-right">
        TR
      </div>
      <div class="col-2 ml-auto">
        <b-form-input v-model="input_tr" type="number" />
      </div>
      <div class="col-2 text-left">
        {{ tr }}
      </div>
    </div>

    <div class="row align-items-center mt-1">
      <div class="col-3 text-right">
        褒賞
      </div>
      <div class="col-2 ml-auto">
        <b-form-select v-model="input_milestone">
          <b-form-select-option :value="0">0</b-form-select-option>
          <b-form-select-option :value="1">1</b-form-select-option>
          <b-form-select-option :value="2">2</b-form-select-option>
          <b-form-select-option :value="3">3</b-form-select-option>
        </b-form-select>
      </div>
      <div class="col-2 text-left">
        {{ milestone }}
      </div>
    </div>

    <div class="row align-items-center mt-1">
      <div class="col-3 text-right">
        称号
      </div>
      <div class="col-6 ml-auto d-flex">
        <b-input-group prepend="1位">
          <b-form-select v-model="input_award_1st">
            <b-form-select-option :value="0">0</b-form-select-option>
            <b-form-select-option :value="1">1</b-form-select-option>
            <b-form-select-option :value="2">2</b-form-select-option>
            <b-form-select-option :value="3">3</b-form-select-option>
          </b-form-select>
        </b-input-group>  
        <b-input-group prepend="2位">
          <b-form-select v-model="input_award_2nd">
            <b-form-select-option :value="0">0</b-form-select-option>
            <b-form-select-option :value="1">1</b-form-select-option>
            <b-form-select-option :value="2">2</b-form-select-option>
            <b-form-select-option :value="3">3</b-form-select-option>
          </b-form-select>
        </b-input-group>  
      </div>
      <div class="col-2 text-left">
        {{ award }}
      </div>
    </div>

    <div class="row align-items-center mt-1">
      <div class="col-3 text-right">
        緑地
      </div>
      <div class="col-2 ml-auto">
        <b-form-input v-model="input_greenery" type="number" />
      </div>
      <div class="col-2 text-left">
        {{ greenery }}
      </div>
    </div>

    <div class="row align-items-center mt-1">
      <div class="col-3 text-right">
        都市
      </div>
      <div class="col-6 ml-auto">
        <b-form-textarea rows="2" v-model="input_cities" placeholder="1 2 1 ..." />
        <small class="form-text text-muted">
          各都市の点数をスペース区切りで入力。
        </small>
      </div>
      <div class="col-2 text-left">
        {{ cities }}
      </div>
    </div>

    <div class="row align-items-center mt-1">
      <div class="col-3 text-right">
        カード
      </div>
      <div class="col-6 ml-auto">
        <b-form-textarea rows="2" v-model="input_cards" placeholder="1 2 -1 ..." />
        <small class="form-text text-muted">
          各カードの点数をスペース区切りで入力。
        </small>
      </div>
      <div class="col-2 text-left">
        {{ cards }}
      </div>
    </div>

    <div class="row align-items-center mt-4">
      <div class="col-3 text-right font-weight-bold h2">
        Total
      </div>
      <div class="col">
      </div>
      <div class="col-2 text-left font-weight-bold h2">
        {{ total }}
      </div>
    </div>
  </div>
</template>

<script>
  export default {
  data() {
    return {
      input_tr: '20',
      input_milestone: '0',
      input_award_1st: '0',
      input_award_2nd: '0',
      input_greenery: '0',
      input_cities: '',
      input_cards: '',
    }
  },

  computed: {
    tr() {
      return parseInt(this.input_tr, 10) || 0
    },

    milestone() {
      return parseInt(this.input_milestone, 10) * 5
    },

    award() {
      return parseInt(this.input_award_1st, 10) * 5 + parseInt(this.input_award_2nd, 10) * 2
    },

    greenery() {
      return parseInt(this.input_greenery, 10) || 0
    },

    cities() {
      return this.input_cities.split(/\s+/).filter(Boolean).map(e => parseInt(e, 10)).reduce((p, c) => p + c, 0)
    },

    cards() {
      return this.input_cards.split(/\s+/).filter(Boolean).map(e => parseInt(e, 10)).reduce((p, c) => p + c, 0)
    },

    total() {
      return this.tr + this.milestone + this.award + this.greenery + this.cities + this.cards
    },
  }
}
</script>
