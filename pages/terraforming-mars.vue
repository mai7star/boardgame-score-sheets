<template>
  <div class="container">
    <div class="row">
      <div class="col">
        <h4>テラフォーミング・マーズ</h4>
      </div>
    </div>

    <b-tabs>
      <b-tab title='score' active>
        <div class="row align-items-center mt-3">
          <div class="col-3 text-right">
            TR
          </div>
          <div class="col-4 ml-auto">
            <b-form-input v-model="tr" type="number" :number="true" :min="20" />
          </div>
          <div class="col-2 text-left">
            {{ tr || 0}}
          </div>
        </div>

        <div class="row align-items-center mt-1">
          <div class="col-3 text-right">
            褒賞
          </div>
          <div class="col-4 ml-auto">
            <range-select v-model="milestone" :value="1" :min="0" :max="3" />
          </div>
          <div class="col-2 text-left">
            {{ milestone }}
          </div>
        </div>

        <div class="row align-items-center mt-1">
          <div class="col-3 text-right">
            称号
          </div>
          <div class="col-6 ml-auto">
            <b-input-group prepend="1位">
              <range-select v-model="award_1st" :value="0" :min="0" :max="3" />
            </b-input-group>  
            <b-input-group prepend="2位">
              <range-select v-model="award_2nd" :value="0" :min="0" :max="3" />
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
          <div class="col-4 ml-auto">
            <b-form-input v-model="greenery" type="number" :number="true" :min="0" />
          </div>
          <div class="col-2 text-left">
            {{ greenery || 0 }}
          </div>
        </div>

        <div class="row align-items-center mt-1">
          <div class="col-3 text-right">
            都市
          </div>
          <div class="col-7 ml-auto">
            <sum-numbers v-model="cities" placeholder="1,2,1 ..." />
            <small class="form-text text-muted">
              各都市の点数をカンマ区切りで入力。
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
          <div class="col-7 ml-auto">
            <sum-numbers v-model="cards" placeholder="1,2,1 ..." />
            <small class="form-text text-muted">
              各カードの点数をカンマ区切りで入力。
            </small>
          </div>
          <div class="col-2 text-left">
            {{ cards }}
          </div>
        </div>

        <div class="row align-items-center mt-4">
          <div class="col-3 text-right font-weight-bold h3">
            Total
          </div>
          <div class="col">
          </div>
          <div class="col-2 text-left font-weight-bold h3">
            {{ total }}
          </div>
        </div>
      </b-tab>
    </b-tabs>
  </div>
</template>

<script>
  export default {
  data() {
    return {
      tr: 20,
      milestone: 0,
      award_1st: 0,
      award_2nd: 0,
      greenery: 0,
      cities: 0,
      cards: 0,
    }
  },

  computed: {
    award() {
      return this.award_1st * 5 + this.award_2nd * 2
    },

    total() {
      return (this.tr || 0) + this.milestone + this.award + (this.greenery || 0) + this.cities + this.cards
    },
  }
}
</script>
