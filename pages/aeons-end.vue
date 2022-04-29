<template>
  <div>
    <div class="row">
      <div class="col">
        <h4>イーオンズ・エンド</h4>
      </div>
    </div>

    <b-tabs>
      <b-tab title="setup" active>
        <div class="row align-items-center mt-3">
          <div class="col">
            <b-form-checkbox v-model="settings.war_eternal">終わりなき戦い</b-form-checkbox>
          </div>
        </div>
      
        <div class="row align-items-center mt-3">
          <div class="col">
            プレイヤー数
          </div>
          <div class="col">
            <b-form-select v-model="settings.players">
              <b-form-select-option :key="1" :value="1">1</b-form-select-option>    
              <b-form-select-option :key="2" :value="2">2</b-form-select-option>    
              <b-form-select-option :key="3" :value="3">3</b-form-select-option>    
              <b-form-select-option :key="4" :value="4">4</b-form-select-option>    
            </b-form-select>
          </div>
        </div>

        <div class="row align-items-center">
          <table class="col table">
            <tr v-for="(character, index) in selectedCharacters">
              <th class="col-4">プレイヤー{{ index + 1}}</th>
              <td>{{ character.name }}</td>
            </tr>
          </table>
        </div>

        <div class="row align-items-center mt-3">
          <h5 class="col">メネシスデッキ</h5>
        </div>
        <div class="row align-items-center">
          <table class="col table">
            <tr>
              <th class="col-4">階層1</th>
              <td>{{ nemesis_deck[settings.players].tier1 }}枚</td>
            </tr>
            <tr>
              <th class="col-4">階層2</th>
              <td>{{ nemesis_deck[settings.players].tier2 }}枚</td>
            </tr>
            <tr>
              <th class="col-4">階層3</th>
              <td>{{ nemesis_deck[settings.players].tier3 }}枚</td>
            </tr>
          </table>
        </div>

        <div class="row align-items-center mt-3">
          <h5 class="col">難易度</h5>
          <div class="col">
            <b-form-select v-model="settings.difficulty">
              <b-form-select-option :key="1" :value="1">初心者</b-form-select-option>    
              <b-form-select-option :key="2" :value="2">通常</b-form-select-option>    
              <b-form-select-option :key="3" :value="3">熟練者</b-form-select-option>    
              <b-form-select-option :key="4" :value="4">自殺志願</b-form-select-option>    
            </b-form-select>
          </div>
        </div>

        <div class="row align-items-center">
          <table class="col table">
            <tr>
              <th class="col-4">プレイヤー体力</th>
              <td>{{ difficulty[settings.difficulty].player_life }}</td>
            </tr>
            <tr>
              <th class="col-4">グレイヴホールド体力</th>
              <td>{{ difficulty[settings.difficulty].gravehold_life }}</td>
            </tr>
            <tr>
              <th class="col-4">ネメシス体力</th>
              <td>{{ difficulty[settings.difficulty].nemesis_life }}</td>
            </tr>
            <tr>
              <th class="col-4">難化ルール</th>
              <td>{{ difficulty[settings.difficulty].difficulty_rule }}</td>
            </tr>
          </table>
        </div>

        <div class="row align-items-center mt-3">
          <h5 class="col">サプライ</h5>
          <div class="col">
            <b-form-select v-model="settings.supply">
              <b-form-select-option key="p1" value="p1">デッキ圧縮</b-form-select-option>
              <b-form-select-option key="p2" value="p2">チャージし放題！</b-form-select-option>
              <b-form-select-option key="p3" value="p3" v-if="settings.war_eternal">デッキ圧縮（終わりなき戦い）</b-form-select-option>
              <b-form-select-option key="p4" value="p4" v-if="settings.war_eternal">呪文リサイクル</b-form-select-option>
              <b-form-select-option key="r1" value="r1">ランダム1 （宝: 3, 遺: 2, 呪: 4）</b-form-select-option>
              <b-form-select-option key="r2" value="r2">ランダム2 （宝: 3, 遺: 2, 呪: 4）</b-form-select-option>
              <b-form-select-option key="r3" value="r3">ランダム3 （宝: 3, 遺: 1, 呪: 5）</b-form-select-option>
              <b-form-select-option key="r4" value="r4">ランダム4 （宝: 3, 遺: 3, 呪: 3）</b-form-select-option>
              <b-form-select-option key="r5" value="r5">ランダム5 （宝: 4, 遺: 1, 呪: 4）</b-form-select-option>
              <b-form-select-option key="r6" value="r6">ランダム5 （宝: 2, 遺: 3, 呪: 4）</b-form-select-option>
            </b-form-select>
          </div>
        </div>

        <div class="row align-items-center">
          <table class="col table">
            <tr v-for="card in supplyCards" :key="card.name">
              <td class="col-3">
                <span v-if="card.type == 'gem'">宝石 (コスト {{ card.cost }})</span>
                <span v-if="card.type == 'relic'">遺物 (コスト {{ card.cost }})</span>
                <span v-if="card.type == 'spell'">呪文 (コスト {{ card.cost }})</span>
              </td>
              <td class="col-9">{{ card.name }}</td>
            </tr>
          </table>
        </div>
      </b-tab>

      <b-tab title='turn'>
        <div class="row align-items-center mt-3" v-if="round == 0">
          <div class="col">
            <b-button variant="primary" @click="reset">Start</b-button>
          </div>
        </div>

        <div v-else>
          <div class="row align-items-center mt-3">
            <div class="col-3 text-right font-weight-bold h3">
              Round {{ round }}
            </div>
            <div class="col">
              <b-button variant="outline-primary" @click="showNextOrder">Next Player</b-button>
            </div>
          </div>

          <div class="row align-items-center mt-3">
            <div class="col">
              <b-card v-for="(player, index) in orders_in_round" :key="index" class="text-center">
                <div class="bg-secondary text-light" v-if="index_in_round < index">
                  ???
                </div>
                <div class="bg-primary text-light" v-if="index_in_round == index">
                  {{ player }}
                </div>
                <div v-if="index_in_round > index">
                  {{ player }}
                </div>
              </b-card>
            </div>
          </div>

          <div class="row align-items-center mt-3">
            <div class="col">
              <b-button variant="outline-danger" @click="reset">Reset</b-button>
            </div>
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
      settings: { war_eternal: false, players: 1, difficulty: 2, supply: 'p1' },

      characters: [
       { name: 'ジアン', set: 'base' },
       { name: 'ミスト（ダガーキャプテン）', set: 'base' },
       { name: 'ブラマ', set: 'base' },
       { name: 'アーデルハイム', set: 'base' },
       { name: 'カディア', set: 'base' },
       { name: 'ザクソス', set: 'base' },
       { name: 'ラッシュ', set: 'base' },
       { name: 'フェドラクサ', set: 'base' },

       { name: 'デズモディア', set: 'war_eternal' },
       { name: 'ヤン・マグダ', set: 'war_eternal' },
       { name: 'ゲクス', set: 'war_eternal' },
       { name: 'マザヘドロン', set: 'war_eternal' },
       { name: 'ウルギモール', set: 'war_eternal' },
       { name: 'キリウス', set: 'war_eternal' },
       { name: 'ガル', set: 'war_eternal' },
       { name: 'ミスト（空虚を渡る者）', set: 'war_eternal' },
      ],

      nemesis_deck: {
        1: { tier1: 1, tier2: 3, tier3: 7 },
        2: { tier1: 3, tier2: 5, tier3: 7 },
        3: { tier1: 5, tier2: 6, tier3: 7 },
        4: { tier1: 8, tier2: 7, tier3: 7 },
      },

      difficulty: {
        1: { player_life: '12', gravehold_life: '35', nemesis_life: '-10', difficulty_rule: '使用しない' },
        2: { player_life: '10', gravehold_life: '30', nemesis_life: '増減なし', difficulty_rule: '使用しない' },
        3: { player_life: '10', gravehold_life: '30', nemesis_life: '増減なし', difficulty_rule: '使用' },
        4: { player_life: '8', gravehold_life: '25', nemesis_life: '+10', difficulty_rule: '使用' },
      },

      cards: [
        { name: '翡翠', type: 'gem', cost: 2, set: 'base' },
        { name: '凍結マグマイト', type: 'gem', cost: 3, set: 'war_eternal' },
        { name: '忌まわしきダイヤモンド', type: 'gem', cost: 3, set: 'war_eternal' },
        { name: '火山性ガラス', type: 'gem', cost: 3, set: 'war_eternal' },
        { name: 'ヴリスウッドの琥珀', type: 'gem', cost: 3, set: 'base' },
        { name: '変化の真珠', type: 'gem', cost: 3, set: 'base' },
        { name: '赤熱ルビー', type: 'gem', cost: 4, set: 'base' },
        { name: '火山岩滓', type: 'gem', cost: 4, set: 'war_eternal' },
        { name: '群生ダイヤモンド', type: 'gem', cost: 4, set: 'base' },
        { name: '破孔石', type: 'gem', cost: 4, set: 'war_eternal' },
        { name: '燃えるオパール', type: 'gem', cost: 5, set: 'base' },
        { name: '異常鋳塊', type: 'gem', cost: 5, set: 'war_eternal' },
        { name: '雲色サファイア', type: 'gem', cost: 6, set: 'base' },
        { name: 'ブラッドストーン魂', type: 'gem', cost: 6, set: 'war_eternal' },

        { name: '屈曲ダガー', type: 'relic', cost: 2, set: 'base' },
        { name: '魔術師の象徴物', type: 'relic', cost: 2, set: 'war_eternal' },
        { name: 'コンクラーベのスクロール', type: 'relic', cost: 3, set: 'war_eternal' },
        { name: '魔物捕獲器', type: 'relic', cost: 3, set: 'war_eternal' },
        { name: 'ゆらめくプリズム', type: 'relic', cost: 3, set: 'base' },
        { name: '瓶詰の渦動', type: 'relic', cost: 3, set: 'base' },
        { name: '強化オーブ', type: 'relic', cost: 4, set: 'base' },
        { name: '強撃杖', type: 'relic', cost: 4, set: 'base' },
        { name: '原始的呪物', type: 'relic', cost: 4, set: 'war_eternal' },
        { name: '石塚の羅針盤', type: 'relic', cost: 4, set: 'war_eternal' },
        { name: '魔術師の護符', type: 'relic', cost: 5, set: 'base' },
        { name: '渦動ガントレット', type: 'relic', cost: 6, set: 'war_eternal' },

        { name: 'スペクトル残響', type: 'spell', cost: 3, set: 'base' },
        { name: '不死鳥炎', type: 'spell', cost: 3, set: 'base' },
        { name: '思念体の使い魔', type: 'spell', cost: 3, set: 'war_eternal' },
        { name: 'ヴィジョン増幅', type: 'spell', cost: 4, set: 'base' },
        { name: '炎上', type: 'spell', cost: 4, set: 'base' },
        { name: '熔岩触肢', type: 'spell', cost: 4, set: 'base' },
        { name: '炭素化', type: 'spell', cost: 4, set: 'war_eternal' },
        { name: '着火', type: 'spell', cost: 4, set: 'war_eternal' },
        { name: '鋸歯雷', type: 'spell', cost: 4, set: 'war_eternal' },
        { name: '火工波動', type: 'spell', cost: 4, set: 'war_eternal' },
        { name: '闇色炎', type: 'spell', cost: 5, set: 'base' },
        { name: 'エッセンス強奪', type: 'spell', cost: 5, set: 'base' },
        { name: '凶雷', type: 'spell', cost: 5, set: 'base' },
        { name: '膨らむ忘却', type: 'spell', cost: 5, set: 'base' },
        { name: '燃え盛る奔流', type: 'spell', cost: 5, set: 'war_eternal' },
        { name: 'オーロラ', type: 'spell', cost: 5, set: 'war_eternal' },
        { name: '対流フィールド', type: 'spell', cost: 5, set: 'war_eternal' },
        { name: '天界への尖塔', type: 'spell', cost: 5, set: 'war_eternal' },
        { name: 'カオス・アーク', type: 'spell', cost: 6, set: 'base' },
        { name: '熾火の鞭', type: 'spell', cost: 6, set: 'base' },
        { name: '空間洞察', type: 'spell', cost: 6, set: 'base' },
        { name: '新星鍛造', type: 'spell', cost: 6, set: 'war_eternal' },
        { name: '失われし者の召喚', type: 'spell', cost: 6, set: 'war_eternal' },
        { name: '魔力結節', type: 'spell', cost: 7, set: 'base' },
        { name: '飲み込む虚無', type: 'spell', cost: 7, set: 'base' },
        { name: '均衡', type: 'spell', cost: 7, set: 'war_eternal' },
        { name: '灰燼と帰せ', type: 'spell', cost: 7, set: 'war_eternal' },
        { name: '結晶化', type: 'spell', cost: 8, set: 'war_eternal' },
      ],

      card_sets: {
        p1: ['翡翠', '赤熱ルビー', '燃えるオパール', '屈曲ダガー', '瓶詰の渦動', 'ヴィジョン増幅', 'エッセンス強奪', '空間洞察', '飲み込む虚無'],
        p2: ['翡翠', 'ヴリスウッドの琥珀', '群生ダイヤモンド', 'ゆらめくプリズム', '魔術師の護符', 'スペクトル残響', '炎上', '凶雷', '熾火の鞭'],
        p3: ['凍結マグマイト', '火山岩滓', '異常鋳塊', '魔術師の象徴物', '原始的呪物', '鋸歯雷', '燃え盛る奔流', '失われし者の召喚', '灰燼と帰せ'],
        p4: ['火山性ガラス', '破孔石', 'ブラッドストーン魂', '石塚の羅針盤', '渦動ガントレット', '思念体の使い魔', '着火', '新星鍛造', '結晶化'],
        r1: [
          {type: 'gem', costs: [2, 3]},
          {type: 'gem', costs: [4]},
          {type: 'gem', costs: [2, 3, 4, 5, 6, 7, 8]},
          {type: 'relic', costs: [2, 3, 4, 5, 6, 7, 8]},
          {type: 'relic', costs: [2, 3, 4, 5, 6, 7, 8]},
          {type: 'spell', costs: [2, 3, 4]},
          {type: 'spell', costs: [2, 3, 4]},
          {type: 'spell', costs: [6, 7, 8]},
          {type: 'spell', costs: [6, 7, 8]},
        ],
        r2: [
          {type: 'gem', costs: [4, 5, 6, 7, 8]},
          {type: 'gem', costs: [4, 5, 6, 7, 8]},
          {type: 'gem', costs: [4, 5, 6, 7, 8]},
          {type: 'relic', costs: [5, 6, 7, 8]},
          {type: 'relic', costs: [2, 3, 4, 5, 6, 7, 8]},
          {type: 'spell', costs: [2, 3, 4, 5]},
          {type: 'spell', costs: [2, 3, 4, 5]},
          {type: 'spell', costs: [2, 3, 4, 5]},
          {type: 'spell', costs: [7, 8]},
        ],
        r3: [
          {type: 'gem', costs: [2, 3]},
          {type: 'gem', costs: [4, 5]},
          {type: 'gem', costs: [4, 5]},
          {type: 'relic', costs: [2, 3, 4, 5, 6, 7, 8]},
          {type: 'spell', costs: [3]},
          {type: 'spell', costs: [4]},
          {type: 'spell', costs: [6, 7, 8]},
          {type: 'spell', costs: [6, 7, 8]},
          {type: 'spell', costs: [6, 7, 8]},
        ],
        r4: [
          {type: 'gem', costs: [5, 6, 7, 8]},
          {type: 'gem', costs: [2, 3, 4, 5, 6, 7, 8]},
          {type: 'gem', costs: [2, 3, 4, 5, 6, 7, 8]},
          {type: 'relic', costs: [2, 3]},
          {type: 'relic', costs: [5, 6, 7, 8]},
          {type: 'relic', costs: [2, 3, 4, 5, 6, 7, 8]},
          {type: 'spell', costs: [2, 3, 4]},
          {type: 'spell', costs: [6, 7, 8]},
          {type: 'spell', costs: [2, 3, 4, 5, 6, 7, 8]},
        ],
        r5: [
          {type: 'gem', costs: [2]},
          {type: 'gem', costs: [3]},
          {type: 'gem', costs: [4]},
          {type: 'gem', costs: [5]},
          {type: 'relic', costs: [2, 3, 4, 5, 6, 7, 8]},
          {type: 'spell', costs: [4]},
          {type: 'spell', costs: [5]},
          {type: 'spell', costs: [6]},
          {type: 'spell', costs: [7, 8]},
        ],
        r6: [
          {type: 'gem', costs: [3]},
          {type: 'gem', costs: [4]},
          {type: 'relic', costs: [2, 3]},
          {type: 'relic', costs: [5, 6, 7, 8]},
          {type: 'relic', costs: [2, 3, 4, 5, 6, 7, 8]},
          {type: 'spell', costs: [3, 4]},
          {type: 'spell', costs: [5, 6]},
          {type: 'spell', costs: [5, 6]},
          {type: 'spell', costs: [7, 8]},
        ],
      },

      orders: {
        1: ['1', '1', '1', 'ネメシス', 'ネメシス'],
        2: ['1', '1', '2', '2', 'ネメシス', 'ネメシス'],
        3: ['1', '2', '3', 'ワイルド', 'ネメシス', 'ネメシス'],
        4: ['1', '2', '3', '4', 'ネメシス', 'ネメシス'],
      },

      orders_in_round: [],
      index_in_round: 0,
      round: 0
    }
  },

  computed: {
    selectedCharacters() {
      const characters = this.characters.filter(c => this.settings.war_eternal ? true : c.set == 'base')
                                        .sort(()=> Math.random() - 0.5)
      return characters.splice(0, this.settings.players)
    },

    supplyCards() {
      if(this.settings.supply.match(/^p/)){
        return this.card_sets[this.settings.supply].map(name => {
          return this.cards.find(c => c.name == name)
        })
      } else {
        const cards = this.cards.filter(c => this.settings.war_eternal ? true : c.set == 'base')
                                .sort(()=> Math.random() - 0.5)
        const selected = []
        this.card_sets[this.settings.supply].forEach(target => {
          const card = cards.filter(c => !selected.map(s => s.name).includes(c.name))
                            .find(c => target.type == c.type && target.costs.includes(c.cost))
          selected.push(card)
        })

        return selected
      }
    },
  },

  methods: {
    showNextOrder() {
      this.index_in_round++
      if(!this.orders_in_round[this.index_in_round]) {
        this.orders_in_round = this.orders[this.settings.players].sort(()=> Math.random() - 0.5)
        this.index_in_round = 0
        this.round++
      }
    },

    reset() {
      this.round = 1
      this.orders_in_round = this.orders[this.settings.players].sort(()=> Math.random() - 0.5)
      this.index_in_round = 0
    }
  }
}
</script>
