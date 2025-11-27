<template>
  <div :class="['product-wrapper', sectionClass]">

    <img :src="product.image" class="product-image" />

    <h2 class="product-title">{{ product.title }}</h2>

    <!-- Hanya tampil jika produk valid -->
    <template v-if="!isUnavailable">
      <p class="product-category">{{ product.category }}</p>
      <p class="product-desc">{{ product.description }}</p>
      <p class="product-price">$ {{ product.price }}</p>
    </template>

    <!-- Button section -->
    <div class="button-group">
      <!-- Buy Now hanya muncul jika produk valid -->
      <button v-if="!isUnavailable" class="next-btn">Buy Now</button>

      <!-- Selalu tampil -->
      <button class="next-btn" @click="nextProduct">Next Product</button>
    </div>

  </div>
</template>


<script>
export default {
  name: "ProductDisplay",
  data() {
    return {
      index: 1,
      product: {},
    };
  },

  computed: {
    sectionClass() {
      if (this.product.category === "men's clothing") return "men-section";
      if (this.product.category === "women's clothing") return "women-section";
      return "unavailable-section";
    },
  },

  mounted() {
    this.fetchProduct();
  },

  methods: {
    async fetchProduct() {
  try {
    const res = await fetch(`https://fakestoreapi.com/products/${this.index}`);
    const data = await res.json();

    if (data.category === "men's clothing" || data.category === "women's clothing") {
      this.product = data;
      this.isUnavailable = false;
    } else {
      this.product = {
        title: "This product is unavailable to show",

        description: "this product is unavailable to show",
        image: "/tidaktersedia.png"
      };
      this.isUnavailable = true;
    }
  } catch (e) {
    console.error("Error fetching API:", e);
  }
},


    nextProduct() {
      this.index++;
      if (this.index > 20) this.index = 1;
      this.fetchProduct();
    },
  },
};
</script>

<style scoped>
/* empty – styling already in style.css */
</style>
