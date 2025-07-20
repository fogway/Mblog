<template>
  <div id="app">
    <!-- 导航栏 -->
    <Header 
      :cart-count="cartItems.length"
      @toggle-cart="showCart = !showCart"
      @search="handleSearch"
    />

    <!-- 主要内容区域 -->
    <main>
      <!-- 英雄横幅 -->
      <HeroBanner v-if="!searchQuery" />

      <!-- 商品展示区域 -->
      <section class="products-section">
        <div class="container">
          <div v-if="searchQuery" class="search-results">
            <h2>搜索结果: "{{ searchQuery }}"</h2>
            <p>找到 {{ filteredProducts.length }} 个商品</p>
          </div>

          <div v-if="!searchQuery" class="categories-filter">
            <button 
              v-for="category in categories" 
              :key="category"
              :class="['btn', 'filter-btn', { active: selectedCategory === category }]"
              @click="selectedCategory = category"
            >
              {{ category }}
            </button>
          </div>

          <div v-if="loading" class="loading">
            <div class="spinner"></div>
          </div>

          <div v-else class="grid grid-cols-4 products-grid">
            <ProductCard
              v-for="product in displayProducts"
              :key="product.id"
              :product="product"
              @add-to-cart="addToCart"
              @view-details="viewProductDetails"
            />
          </div>

          <div v-if="displayProducts.length === 0 && !loading" class="no-products">
            <i class="fas fa-search" style="font-size: 48px; color: #ccc; margin-bottom: 16px;"></i>
            <h3>没有找到相关商品</h3>
            <p>请尝试其他搜索关键词</p>
          </div>
        </div>
      </section>
    </main>

    <!-- 购物车侧栏 -->
    <CartSidebar
      :show="showCart"
      :items="cartItems"
      @close="showCart = false"
      @update-quantity="updateCartQuantity"
      @remove-item="removeFromCart"
      @checkout="handleCheckout"
    />

    <!-- 商品详情模态框 -->
    <ProductModal
      :show="showProductModal"
      :product="selectedProduct"
      @close="showProductModal = false"
      @add-to-cart="addToCart"
    />

    <!-- 结账成功提示 -->
    <div v-if="showCheckoutSuccess" class="checkout-success-overlay" @click="showCheckoutSuccess = false">
      <div class="checkout-success-modal" @click.stop>
        <i class="fas fa-check-circle" style="font-size: 64px; color: #28a745; margin-bottom: 16px;"></i>
        <h2>订单提交成功！</h2>
        <p>您的订单已成功提交，我们会尽快为您处理。</p>
        <button class="btn btn-primary" @click="showCheckoutSuccess = false">继续购物</button>
      </div>
    </div>

    <!-- 页脚 -->
    <Footer />
  </div>
</template>

<script>
import { ref, computed, onMounted } from 'vue'
import Header from './components/Header.vue'
import HeroBanner from './components/HeroBanner.vue'
import ProductCard from './components/ProductCard.vue'
import CartSidebar from './components/CartSidebar.vue'
import ProductModal from './components/ProductModal.vue'
import Footer from './components/Footer.vue'

export default {
  name: 'App',
  components: {
    Header,
    HeroBanner,
    ProductCard,
    CartSidebar,
    ProductModal,
    Footer
  },
  setup() {
    // 响应式数据
    const products = ref([])
    const cartItems = ref([])
    const showCart = ref(false)
    const showProductModal = ref(false)
    const showCheckoutSuccess = ref(false)
    const selectedProduct = ref(null)
    const selectedCategory = ref('全部')
    const searchQuery = ref('')
    const loading = ref(true)

    // 商品分类
    const categories = ref(['全部', '手机数码', '服装配饰', '家居生活', '运动户外', '美妆护肤'])

    // 模拟商品数据
    const mockProducts = [
      {
        id: 1,
        name: 'iPhone 15 Pro',
        price: 7999,
        originalPrice: 8999,
        image: 'https://images.unsplash.com/photo-1592899677977-9c10ca588bbd?w=400',
        category: '手机数码',
        rating: 4.8,
        reviews: 1256,
        description: '最新款iPhone，搭载A17仿生芯片，钛金属机身，支持USB-C接口。'
      },
      {
        id: 2,
        name: 'MacBook Air M2',
        price: 8999,
        originalPrice: 9999,
        image: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400',
        category: '手机数码',
        rating: 4.9,
        reviews: 892,
        description: '轻薄便携的笔记本电脑，搭载M2芯片，续航长达18小时。'
      },
      {
        id: 3,
        name: '时尚连衣裙',
        price: 299,
        originalPrice: 399,
        image: 'https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?w=400',
        category: '服装配饰',
        rating: 4.6,
        reviews: 234,
        description: '优雅时尚的连衣裙，适合多种场合穿着。'
      },
      {
        id: 4,
        name: '无线蓝牙耳机',
        price: 199,
        originalPrice: 299,
        image: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400',
        category: '手机数码',
        rating: 4.5,
        reviews: 567,
        description: '高品质音质，长续航，舒适佩戴。'
      },
      {
        id: 5,
        name: '智能手表',
        price: 1299,
        originalPrice: 1599,
        image: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400',
        category: '手机数码',
        rating: 4.7,
        reviews: 445,
        description: '多功能智能手表，健康监测，运动追踪。'
      },
      {
        id: 6,
        name: '舒适沙发',
        price: 2999,
        originalPrice: 3999,
        image: 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=400',
        category: '家居生活',
        rating: 4.8,
        reviews: 167,
        description: '现代简约风格沙发，舒适耐用，提升家居品质。'
      },
      {
        id: 7,
        name: '运动鞋',
        price: 599,
        originalPrice: 799,
        image: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400',
        category: '运动户外',
        rating: 4.6,
        reviews: 789,
        description: '专业运动鞋，透气舒适，适合各种运动场景。'
      },
      {
        id: 8,
        name: '护肤套装',
        price: 399,
        originalPrice: 499,
        image: 'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=400',
        category: '美妆护肤',
        rating: 4.7,
        reviews: 342,
        description: '天然成分护肤套装，深层滋养，呵护肌肤。'
      }
    ]

    // 计算属性
    const filteredProducts = computed(() => {
      let filtered = products.value

      if (selectedCategory.value !== '全部') {
        filtered = filtered.filter(product => product.category === selectedCategory.value)
      }

      if (searchQuery.value) {
        filtered = filtered.filter(product =>
          product.name.toLowerCase().includes(searchQuery.value.toLowerCase()) ||
          product.description.toLowerCase().includes(searchQuery.value.toLowerCase())
        )
      }

      return filtered
    })

    const displayProducts = computed(() => {
      return filteredProducts.value
    })

    // 方法
    const addToCart = (product, quantity = 1) => {
      const existingItem = cartItems.value.find(item => item.id === product.id)
      
      if (existingItem) {
        existingItem.quantity += quantity
      } else {
        cartItems.value.push({
          ...product,
          quantity
        })
      }
    }

    const updateCartQuantity = (productId, quantity) => {
      const item = cartItems.value.find(item => item.id === productId)
      if (item) {
        item.quantity = quantity
      }
    }

    const removeFromCart = (productId) => {
      const index = cartItems.value.findIndex(item => item.id === productId)
      if (index > -1) {
        cartItems.value.splice(index, 1)
      }
    }

    const viewProductDetails = (product) => {
      selectedProduct.value = product
      showProductModal.value = true
    }

    const handleSearch = (query) => {
      searchQuery.value = query
      selectedCategory.value = '全部'
    }

    const handleCheckout = () => {
      showCart.value = false
      showCheckoutSuccess.value = true
      cartItems.value = []
    }

    // 初始化数据
    onMounted(() => {
      setTimeout(() => {
        products.value = mockProducts
        loading.value = false
      }, 1000)
    })

    return {
      products,
      cartItems,
      showCart,
      showProductModal,
      showCheckoutSuccess,
      selectedProduct,
      selectedCategory,
      searchQuery,
      loading,
      categories,
      filteredProducts,
      displayProducts,
      addToCart,
      updateCartQuantity,
      removeFromCart,
      viewProductDetails,
      handleSearch,
      handleCheckout
    }
  }
}
</script>

<style scoped>
.products-section {
  padding: 40px 0;
  min-height: 60vh;
}

.search-results {
  margin-bottom: 32px;
  text-align: center;
}

.search-results h2 {
  color: #333;
  margin-bottom: 8px;
}

.search-results p {
  color: #666;
}

.categories-filter {
  display: flex;
  justify-content: center;
  margin-bottom: 40px;
  flex-wrap: wrap;
  gap: 12px;
}

.filter-btn {
  background: white;
  color: #666;
  border: 2px solid #e0e0e0;
  padding: 8px 16px;
  border-radius: 25px;
  font-size: 14px;
  transition: all 0.3s ease;
}

.filter-btn:hover {
  border-color: #667eea;
  color: #667eea;
  transform: none;
}

.filter-btn.active {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  border-color: #667eea;
}

.products-grid {
  margin-bottom: 40px;
}

.no-products {
  text-align: center;
  padding: 80px 20px;
  color: #666;
}

.checkout-success-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 1000;
}

.checkout-success-modal {
  background: white;
  padding: 40px;
  border-radius: 12px;
  text-align: center;
  max-width: 400px;
  margin: 20px;
}

.checkout-success-modal h2 {
  margin-bottom: 16px;
  color: #333;
}

.checkout-success-modal p {
  color: #666;
  margin-bottom: 24px;
}

@media (max-width: 768px) {
  .categories-filter {
    justify-content: flex-start;
    overflow-x: auto;
    padding-bottom: 8px;
  }
  
  .filter-btn {
    white-space: nowrap;
    flex-shrink: 0;
  }
}
</style>