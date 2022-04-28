<template>
  <div>
    <div class="row">
      <div class="col">
        <h4>ウイングスパン</h4>
      </div>
    </div>

    <b-tabs>
      <b-tab title='setup' active>
        <div class="row align-items-center mt-3">
          <div class="col">
            <b-form-checkbox v-model="settings.oceania">大洋の翼</b-form-checkbox>
          </div>
        </div>
      </b-tab>

      <b-tab title='score' active>
        <div class="row align-items-center mt-3">
          <div class="col-3 text-right">
            鳥
          </div>
          <div class="col-7 ml-auto">
            <sum-numbers v-model="birds" placeholder="2,1,3 ..." />
            <small class="form-text text-muted">
              各鳥カードの勝利点をカンマ区切りで入力。
            </small>
          </div>
          <div class="col-2 text-left">
            {{ birds }}
          </div>
        </div>

        <div class="row align-items-center mt-3">
          <div class="col-3 text-right">
            ボーナスカード
          </div>
          <div class="col-7 ml-auto">
            <sum-numbers v-model="bonuses" placeholder="2,1,3 ..." />
            <small class="form-text text-muted">
              達成した各ボーナスカードの勝利点をカンマ区切りで入力。
            </small>
          </div>
          <div class="col-2 text-left">
            {{ bonuses }}
          </div>
        </div>

        <div class="row align-items-center mt-3">
          <div class="col-3 text-right">
            ラウンドごと目標
          </div>
          <div class="col-7 ml-auto">
            <div class="d-flex flex-column">
              <div class="d-flex">
                <div>
                  <b-input-group prepend="R1">
                    <b-form-select v-model="goal.r1">
                      <b-form-select-option :key="1" :value="1">1位</b-form-select-option>
                      <b-form-select-option :key="2" :value="2">2位</b-form-select-option>
                      <b-form-select-option :key="3" :value="3">3位</b-form-select-option>
                      <b-form-select-option :key="0" :value="0">4位以下</b-form-select-option>
                    </b-form-select>
                  </b-input-group>
                </div>
                <div class="col-3 text-right">
                  {{ goal_score.r1[goal.r1] }}
                </div>
              </div>

              <div class="d-flex">
                <div>
                  <b-input-group prepend="R2">
                    <b-form-select v-model="goal.r2">
                      <b-form-select-option :key="1" :value="1">1位</b-form-select-option>
                      <b-form-select-option :key="2" :value="2">2位</b-form-select-option>
                      <b-form-select-option :key="3" :value="3">3位</b-form-select-option>
                      <b-form-select-option :key="0" :value="0">4位以下</b-form-select-option>
                    </b-form-select>
                  </b-input-group>
                </div>
                <div class="col-3 text-right">
                  {{ goal_score.r2[goal.r2] }}
                </div>
              </div>

              <div class="d-flex">
                <div>
                  <b-input-group prepend="R3">
                    <b-form-select v-model="goal.r3">
                      <b-form-select-option :key="1" :value="1">1位</b-form-select-option>
                      <b-form-select-option :key="2" :value="2">2位</b-form-select-option>
                      <b-form-select-option :key="3" :value="3">3位</b-form-select-option>
                      <b-form-select-option :key="0" :value="0">4位以下</b-form-select-option>
                    </b-form-select>
                  </b-input-group>
                </div>
                <div class="col-3 text-right">
                  {{ goal_score.r3[goal.r3] }}
                </div>
              </div>

              <div class="d-flex">
                <div>
                  <b-input-group prepend="R4">
                    <b-form-select v-model="goal.r4">
                      <b-form-select-option :key="1" :value="1">1位</b-form-select-option>
                      <b-form-select-option :key="2" :value="2">2位</b-form-select-option>
                      <b-form-select-option :key="3" :value="3">3位</b-form-select-option>
                      <b-form-select-option :key="0" :value="0">4位以下</b-form-select-option>
                    </b-form-select>
                  </b-input-group>
                </div>
                <div class="col-3 text-right">
                  {{ goal_score.r4[goal.r4] }}
                </div>
              </div>
            </div>
          </div>
          <div class="col-2 text-left">
            {{ goals }}
          </div>
        </div>

        <div class="row align-items-center mt-3">
          <div class="col-3 text-right">
            卵
          </div>
          <div class="col-4 ml-auto">
            <b-form-input v-model="eggs" type="number" :number="true" :min="0" />
          </div>
          <div class="col-2 text-left">
            {{ eggs || 0}}
          </div>
        </div>

        <div class="row align-items-center mt-3">
          <div class="col-3 text-right">
            鳥カード上の餌
          </div>
          <div class="col-4 ml-auto">
            <b-form-input v-model="foods" type="number" :number="true" :min="0" />
          </div>
          <div class="col-2 text-left">
            {{ foods || 0}}
          </div>
        </div>

        <div class="row align-items-center mt-3">
          <div class="col-3 text-right">
            差し込んだ鳥カード
          </div>
          <div class="col-4 ml-auto">
            <b-form-input v-model="tucked_birds" type="number" :number="true" :min="0" />
          </div>
          <div class="col-2 text-left">
            {{ tucked_birds || 0}}
          </div>
        </div>

        <div class="row align-items-center mt-3" v-if="settings.oceania">
          <div class="col-3 text-right">
            花蜜
          </div>
          <div class="col-6 ml-auto">
            <b-input-group prepend="1位">
              <range-select v-model="nectar_1st" :value="0" :min="0" :max="3" />
            </b-input-group>  
            <b-input-group prepend="2位">
              <range-select v-model="nectar_2nd" :value="0" :min="0" :max="3" />
            </b-input-group>  
          </div>
          <div class="col-2 text-left">
            {{ nectar }}
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
      settings: {
        oceania: false
      },

      nectar_1st: 0,
      nectar_2nd: 0,
      greenery: 0,
      cities: 0,
      birds: 0,
      bonuses: 0,
      goal: { r1: 0, r2: 0, r3: 0, r4: 0 },
      goal_score: {
        r1: [0, 4, 1, 0],
        r2: [0, 5, 2, 1],
        r3: [0, 6, 3, 2],
        r4: [0, 7, 4, 3],
      },
      eggs: 0,
      foods: 0,
      tucked_birds: 0,
    }
  },

  computed: {
    goals() {
      return this.goal_score.r1[this.goal.r1] +
             this.goal_score.r2[this.goal.r2] +
             this.goal_score.r3[this.goal.r3] +
             this.goal_score.r4[this.goal.r4]
    },

    nectar() {
      return this.nectar_1st * 5 + this.nectar_2nd * 2
    },

    total() {
      return this.birds + this.bonuses +this.goals
               + (this.eggs || 0) + (this.foods || 0) + (this.tucked_birds || 0)
               + (this.settings.oceania ? this.nectar : 0)
    },
  }
}
</script>
