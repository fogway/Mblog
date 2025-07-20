<template>
  <div class="product-card card">
    <div class="product-image-container">
      <img 
        :src="product.image" 
        :alt="product.name"
        class="product-image"
        @error="handleImageError"
      />
      <div class="product-overlay">
        <button 
          @click="$emit('view-details', product)"
          class="btn btn-secondary quick-view-btn"
        >
          <i class="fas fa-eye"></i>
          快速查看
        </button>
      </div>
      <div v-if="product.originalPrice && product.originalPrice > product.price" class="discount-badge">
        {{ Math.round((1 - product.price / product.originalPrice) * 100) }}% OFF
      </div>
    </div>
    
    <div class="product-info">
      <div class="product-category">{{ product.category }}</div>
      <h3 class="product-name" :title="product.name">{{ product.name }}</h3>
      <p class="product-description">{{ product.description }}</p>
      
      <div class="product-rating">
        <div class="stars">
          <i 
            v-for="i in 5" 
            :key="i"
            :class="['fas fa-star', { active: i <= Math.floor(product.rating) }]"
          ></i>
          <span class="rating-value">{{ product.rating }}</span>
        </div>
        <span class="reviews-count">({{ product.reviews }}条评价)</span>
      </div>
      
      <div class="product-price">
        <span class="current-price">¥{{ formatPrice(product.price) }}</span>
        <span 
          v-if="product.originalPrice && product.originalPrice > product.price"
          class="original-price"
        >
          ¥{{ formatPrice(product.originalPrice) }}
        </span>
      </div>
      
      <div class="product-actions">
        <button 
          @click="addToCart"
          class="btn btn-primary add-to-cart-btn"
          :disabled="isAddingToCart"
        >
          <i class="fas fa-shopping-cart"></i>
          <span v-if="!isAddingToCart">加入购物车</span>
          <span v-else>添加中...</span>
        </button>
        <button class="btn-icon wishlist-btn" @click="toggleWishlist">
          <i :class="['fas fa-heart', { active: isInWishlist }]"></i>
        </button>
      </div>
    </div>
  </div>
</template>

<script>
import { ref } from 'vue'

export default {
  name: 'ProductCard',
  props: {
    product: {
      type: Object,
      required: true
    }
  },
  emits: ['add-to-cart', 'view-details'],
  setup(props, { emit }) {
    const isAddingToCart = ref(false)
    const isInWishlist = ref(false)

    const formatPrice = (price) => {
      return price.toLocaleString()
    }

    const addToCart = async () => {
      isAddingToCart.value = true
      
      // 模拟添加到购物车的延迟
      setTimeout(() => {
        emit('add-to-cart', props.product)
        isAddingToCart.value = false
      }, 500)
    }

    const toggleWishlist = () => {
      isInWishlist.value = !isInWishlist.value
    }

    const handleImageError = (event) => {
      event.target.src = 'https://via.placeholder.com/400x300?text=图片加载失败'
    }

    return {
      isAddingToCart,
      isInWishlist,
      formatPrice,
      addToCart,
      toggleWishlist,
      handleImageError
    }
  }
}
</script>

<style scoped>
.product-card {
  overflow: hidden;
  transition: all 0.3s ease;
  cursor: pointer;
}

.product-image-container {
  position: relative;
  overflow: hidden;
  aspect-ratio: 4/3;
  background: #f8f9fa;
}

.product-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.3s ease;
}

.product-card:hover .product-image {
  transform: scale(1.05);
}

.product-overlay {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
  opacity: 0;
  transition: opacity 0.3s ease;
}

.product-card:hover .product-overlay {
  opacity: 1;
}

.quick-view-btn {
  transform: translateY(20px);
  transition: transform 0.3s ease;
}

.product-card:hover .quick-view-btn {
  transform: translateY(0);
}

.discount-badge {
  position: absolute;
  top: 12px;
  right: 12px;
  background: #ff4757;
  color: white;
  padding: 4px 8px;
  border-radius: 4px;
  font-size: 12px;
  font-weight: bold;
}

.product-info {
  padding: 20px;
}

.product-category {
  font-size: 12px;
  color: #666;
  text-transform: uppercase;
  font-weight: 500;
  margin-bottom: 8px;
}

.product-name {
  font-size: 18px;
  font-weight: 600;
  color: #333;
  margin-bottom: 8px;
  line-height: 1.3;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.product-description {
  font-size: 14px;
  color: #666;
  line-height: 1.4;
  margin-bottom: 12px;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.product-rating {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 16px;
}

.stars {
  display: flex;
  align-items: center;
  gap: 2px;
}

.stars i {
  font-size: 14px;
  color: #ddd;
  transition: color 0.3s ease;
}

.stars i.active {
  color: #ffd700;
}

.rating-value {
  margin-left: 8px;
  font-size: 14px;
  font-weight: 500;
  color: #333;
}

.reviews-count {
  font-size: 12px;
  color: #666;
}

.product-price {
  margin-bottom: 16px;
}

.current-price {
  font-size: 24px;
  font-weight: 700;
  color: #e74c3c;
}

.original-price {
  font-size: 16px;
  color: #999;
  text-decoration: line-through;
  margin-left: 8px;
}

.product-actions {
  display: flex;
  gap: 8px;
  align-items: center;
}

.add-to-cart-btn {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  transition: all 0.3s ease;
}

.add-to-cart-btn:disabled {
  opacity: 0.7;
  cursor: not-allowed;
  transform: none;
}

.btn-icon {
  width: 48px;
  height: 48px;
  border: 2px solid #e0e0e0;
  background: white;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s ease;
}

.wishlist-btn:hover {
  border-color: #e74c3c;
  background: #fff5f5;
}

.wishlist-btn i {
  font-size: 18px;
  color: #ccc;
  transition: color 0.3s ease;
}

.wishlist-btn i.active {
  color: #e74c3c;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .product-info {
    padding: 16px;
  }
  
  .product-name {
    font-size: 16px;
  }
  
  .current-price {
    font-size: 20px;
  }
  
  .original-price {
    font-size: 14px;
  }
  
  .add-to-cart-btn {
    font-size: 14px;
    padding: 10px 16px;
  }
  
  .btn-icon {
    width: 44px;
    height: 44px;
  }
}

@media (max-width: 480px) {
  .product-rating {
    flex-direction: column;
    align-items: flex-start;
    gap: 4px;
  }
  
  .product-actions {
    flex-direction: column;
  }
  
  .btn-icon {
    width: 100%;
  }
}
</style>