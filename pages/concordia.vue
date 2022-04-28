<template>
  <div>
    <div class="row">
      <div class="col">
        <h4>コンコルディア</h4>
      </div>
    </div>

    <b-tabs>
      <b-tab title='score' active>
        <div class="row align-items-center mt-3">
          <div class="col-9 text-right">
            残金
          </div>
          <div class="col-3 ml-auto">
            <b-form-input v-model="coins" type="number" :number="true" :min="0" />
          </div>
        </div>

        <div class="row align-items-center mt-3">
          <div class="col">
            瓦礫
          </div>
          <div class="col">
            食料
          </div>
          <div class="col">
            道具
          </div>
          <div class="col">
            葡萄酒
          </div>
          <div class="col">
            織物
          </div>
        </div>

        <div class="row align-items-center">
          <div class="col">
            <b-form-input v-model.number="resources.bricks" type="number" :number="true" :min="0" />
          </div>
          <div class="col">
            <b-form-input v-model.number="resources.foods" type="number" :number="true" :min="0" />
          </div>
          <div class="col">
            <b-form-input v-model.number="resources.tools" type="number" :number="true" :min="0" />
          </div>
          <div class="col">
            <b-form-input v-model.number="resources.wines" type="number" :number="true" :min="0" />
          </div>
          <div class="col">
            <b-form-input v-model.number="resources.cloths" type="number" :number="true" :min="0" />
          </div>
        </div>

        <div class="row align-items-center mt-3">
          <div class="col-9 text-right">
            残金
          </div>
          <div class="col-3 ml-auto">
            {{ totalCoins }}
          </div>
        </div>

        <div class="row align-items-center mt-3">
          <div class="col">
            瓦礫
          </div>
          <div class="col">
            食料
          </div>
          <div class="col">
            道具
          </div>
          <div class="col">
            葡萄酒
          </div>
          <div class="col">
            織物
          </div>
        </div>

        <div class="row align-items-center">
          <div class="col">
            <b-form-input v-model.number="houses.bricks" type="number" :number="true" :min="0" />
          </div>
          <div class="col">
            <b-form-input v-model.number="houses.foods" type="number" :number="true" :min="0" />
          </div>
          <div class="col">
            <b-form-input v-model.number="houses.tools" type="number" :number="true" :min="0" />
          </div>
          <div class="col">
            <b-form-input v-model.number="houses.wines" type="number" :number="true" :min="0" />
          </div>
          <div class="col">
            <b-form-input v-model.number="houses.cloths" type="number" :number="true" :min="0" />
          </div>
        </div>

        <div class="row align-items-center mt-3">
          <div class="col-9 text-right">
            入植者
          </div>
          <div class="col-3 ml-auto">
            <b-form-input v-model.number="colonists" type="number" :number="true" :min="2" :max="6" />
          </div>
        </div>

        <div class="row align-items-center mt-3">
          <div class="col-9 text-right">
            家のある属州
          </div>
          <div class="col-3 ml-auto">
            <b-form-input v-model.number="provinces" type="number" :number="true" :min="0" :max="20" />
          </div>
        </div>

        <hr />

        <div class="row align-items-center mt-3">
          <div class="col-4 text-right">
            VESTA
            <small class="form-text text-muted">
              ウェスタ
            </small>
          </div>
          <div class="col-3 text-right">
            {{ vestaUnit }}
          </div>
          <div class="col-3 ml-auto">
            <b-form-input v-model="vesta.num" type="number" :number="true" :min="0" />
          </div>
          <div class="col-2 text-right">
            {{ vestaTotal }}
          </div>
        </div>

        <div class="row align-items-center mt-3">
          <div class="col-4 text-right">
            JVPITER
            <small class="form-text text-muted">
              ユピテル
            </small>
          </div>
          <div class="col-3 text-right">
            {{ jvpiterUnit }}
          </div>
          <div class="col-3 ml-auto">
            <b-form-input v-model="jvpiter.num" type="number" :number="true" :min="0" />
          </div>
          <div class="col-2 text-right">
            {{ jvpiterTotal }}
          </div>
        </div>

        <div class="row align-items-center mt-3">
          <div class="col-4 text-right">
            SATVRNVS
            <small class="form-text text-muted">
              サトゥルヌス
            </small>
          </div>
          <div class="col-3 text-right">
            {{ satvrnvsUnit }}
          </div>
          <div class="col-3 ml-auto">
            <b-form-input v-model="satvrnvs.num" type="number" :number="true" :min="0" />
          </div>
          <div class="col-2 text-right">
            {{ satvrnvsTotal }}
          </div>
        </div>

        <div class="row align-items-center mt-3">
          <div class="col-4 text-right">
            MERCVRIVS
            <small class="form-text text-muted">
              メルクリウス
            </small>
          </div>
          <div class="col-3 text-right">
            {{ mercvrivsUnit }}
          </div>
          <div class="col-3 ml-auto">
            <b-form-input v-model="mercvrivs.num" type="number" :number="true" :min="0" />
          </div>
          <div class="col-2 text-right">
            {{ mercvrivsTotal }}
          </div>
        </div>

        <div class="row align-items-center mt-3">
          <div class="col-4 text-right">
            MARS
            <small class="form-text text-muted">
              マルス
            </small>
          </div>
          <div class="col-3 text-right">
            {{ marsUnit }}
          </div>
          <div class="col-3 ml-auto">
            <b-form-input v-model="mars.num" type="number" :number="true" :min="0" />
          </div>
          <div class="col-2 text-right">
            {{ marsTotal }}
          </div>
        </div>

        <div class="row align-items-center mt-3">
          <div class="col-4 text-right">
            MINERVA
            <small class="form-text text-muted">
              ミネルヴァ
            </small>
          </div>
          <div class="col-6 ml-auto">
            <b-form-checkbox-group v-model="minerva.selected" :options="minerva.options" stacked />
          </div>
          <div class="col-2 text-right">
            {{ minervaTotal }}
          </div>
        </div>

        <div class="row align-items-center mt-3">
          <div class="col-4 text-right">
            CONCORDIA
            <small class="form-text text-muted">
              コンコルディア
            </small>
          </div>
          <div class="col-6">
            <b-form-checkbox v-model="concordia.has" />
          </div>
          <div class="col-2 text-right">
            {{ concordiaTotal }}
          </div>
        </div>

        <div class="row align-items-center mt-4">
          <div class="col-3 text-right font-weight-bold h3">
            Total
          </div>
          <div class="col">
          </div>
          <div class="col-2 text-right font-weight-bold h3">
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
      coins: 0,
      resources: { bricks: 0, foods: 0, tools: 0, wines: 0, cloths: 0 },
      houses: { bricks: 0, foods: 0, tools: 0, wines: 0, cloths: 0 },
      colonists: 2,
      provinces: 0,

      vesta: { unit: 0, num: 0 },
      jvpiter: { unit: 0, num: 0 },
      satvrnvs: { unit: 0, num: 0 },
      mercvrivs: { unit: 0, num: 0 },
      mars: { unit: 0, num: 0 },
      minerva: {
        selected: [],
        options: [
          { text: '瓦礫', value: 'bricks' },
          { text: '食料', value: 'foods' },
          { text: '道具', value: 'tools' },
          { text: '葡萄酒', value: 'wines' },
          { text: '織物', value: 'cloths' },
        ]
      },
      concordia: { has: false }
    }
  },

  computed: {
    totalCoins() {
      return this.coins + this.resources.bricks * 3 + this.resources.foods * 4 + this.resources.tools * 5
                        + this.resources.wines * 6 + this.resources.cloths * 7
    },

    vestaUnit() {
      return Math.floor(this.totalCoins / 10)
    },

    vestaTotal() {
      return this.vestaUnit * this.vesta.num
    },

    jvpiterUnit() {
      return this.houses.foods + this.houses.tools + this.houses.wines + this.houses.cloths
    },

    jvpiterTotal() {
      return this.jvpiterUnit * this.jvpiter.num
    },

    satvrnvsUnit() {
      return this.provinces
    },

    satvrnvsTotal() {
      return this.satvrnvsUnit * this.satvrnvs.num
    },

    mercvrivsUnit() {
      return (this.houses.bricks > 0 ? 2 : 0) +
             (this.houses.foods > 0 ? 2 : 0) +
             (this.houses.tools > 0 ? 2 : 0) +
             (this.houses.wines > 0 ? 2 : 0) +
             (this.houses.cloths > 0 ? 2 : 0)
    },

    mercvrivsTotal() {
      return this.mercvrivsUnit * this.mercvrivs.num
    },

    marsUnit() {
      return this.colonists * 2
    },

    marsTotal() {
      return this.marsUnit * this.mars.num
    },

    minervaTotal() {
      return (this.houses.bricks * (this.minerva.selected.includes('bricks') ? 3 : 0)) +
             (this.houses.foods * (this.minerva.selected.includes('foods') ? 3 : 0)) +
             (this.houses.tools * (this.minerva.selected.includes('tools') ? 3 : 0)) +
             (this.houses.wines * (this.minerva.selected.includes('wines') ? 4 : 0)) +
             (this.houses.cloths * (this.minerva.selected.includes('cloths') ? 5 : 0))
    },

    concordiaTotal() {
      return this.concordia.has ? 7 : 0
    },

    total() {
      return this.vestaTotal + this.jvpiterTotal + this.satvrnvsTotal + this.mercvrivsTotal
                             + this.marsTotal + this.minervaTotal + this.concordiaTotal
    },
  }
}
</script>
