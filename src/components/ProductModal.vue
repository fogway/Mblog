<template>
  <div v-if="show" class="modal-overlay" @click="$emit('close')">
    <div class="modal-content" @click.stop>
      <button @click="$emit('close')" class="close-btn">
        <i class="fas fa-times"></i>
      </button>
      
      <div v-if="product" class="product-modal">
        <div class="product-images">
          <div class="main-image">
            <img :src="product.image" :alt="product.name" />
            <div v-if="product.originalPrice && product.originalPrice > product.price" class="discount-badge">
              {{ Math.round((1 - product.price / product.originalPrice) * 100) }}% OFF
            </div>
          </div>
        </div>
        
        <div class="product-details">
          <div class="product-category">{{ product.category }}</div>
          <h2 class="product-title">{{ product.name }}</h2>
          
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
          
          <div class="product-description">
            <h4>商品描述</h4>
            <p>{{ product.description }}</p>
            <div class="features">
              <div class="feature-item">
                <i class="fas fa-check-circle"></i>
                <span>正品保证</span>
              </div>
              <div class="feature-item">
                <i class="fas fa-shipping-fast"></i>
                <span>快速配送</span>
              </div>
              <div class="feature-item">
                <i class="fas fa-undo"></i>
                <span>7天退换</span>
              </div>
              <div class="feature-item">
                <i class="fas fa-shield-alt"></i>
                <span>质量保障</span>
              </div>
            </div>
          </div>
          
          <div class="quantity-selector">
            <label>数量：</label>
            <div class="quantity-controls">
              <button 
                @click="decreaseQuantity"
                :disabled="quantity <= 1"
                class="quantity-btn"
              >
                <i class="fas fa-minus"></i>
              </button>
              <span class="quantity">{{ quantity }}</span>
              <button 
                @click="increaseQuantity"
                class="quantity-btn"
              >
                <i class="fas fa-plus"></i>
              </button>
            </div>
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
            
            <button class="btn btn-secondary buy-now-btn">
              <i class="fas fa-bolt"></i>
              立即购买
            </button>
            
            <button class="btn-icon wishlist-btn" @click="toggleWishlist">
              <i :class="['fas fa-heart', { active: isInWishlist }]"></i>
            </button>
          </div>
          
          <div class="shipping-info">
            <div class="shipping-item">
              <i class="fas fa-truck"></i>
              <div>
                <span class="label">配送</span>
                <span class="value">全国包邮，48小时内发货</span>
              </div>
            </div>
            <div class="shipping-item">
              <i class="fas fa-store"></i>
              <div>
                <span class="label">服务</span>
                <span class="value">由优购商城发货并提供售后服务</span>
              </div>
            </div>
            <div class="shipping-item">
              <i class="fas fa-medal"></i>
              <div>
                <span class="label">保障</span>
                <span class="value">正品保证，假一赔十</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { ref } from 'vue'

export default {
  name: 'ProductModal',
  props: {
    show: {
      type: Boolean,
      default: false
    },
    product: {
      type: Object,
      default: null
    }
  },
  emits: ['close', 'add-to-cart'],
  setup(props, { emit }) {
    const quantity = ref(1)
    const isAddingToCart = ref(false)
    const isInWishlist = ref(false)

    const formatPrice = (price) => {
      return price.toLocaleString()
    }

    const increaseQuantity = () => {
      quantity.value++
    }

    const decreaseQuantity = () => {
      if (quantity.value > 1) {
        quantity.value--
      }
    }

    const addToCart = async () => {
      if (!props.product) return
      
      isAddingToCart.value = true
      
      setTimeout(() => {
        emit('add-to-cart', props.product, quantity.value)
        isAddingToCart.value = false
        emit('close')
      }, 500)
    }

    const toggleWishlist = () => {
      isInWishlist.value = !isInWishlist.value
    }

    return {
      quantity,
      isAddingToCart,
      isInWishlist,
      formatPrice,
      increaseQuantity,
      decreaseQuantity,
      addToCart,
      toggleWishlist
    }
  }
}
</script>

<style scoped>
.modal-overlay {
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
  padding: 20px;
}

.modal-content {
  background: white;
  border-radius: 12px;
  max-width: 900px;
  width: 100%;
  max-height: 90vh;
  overflow-y: auto;
  position: relative;
  animation: modalSlideIn 0.3s ease;
}

@keyframes modalSlideIn {
  from {
    opacity: 0;
    transform: scale(0.9) translateY(-20px);
  }
  to {
    opacity: 1;
    transform: scale(1) translateY(0);
  }
}

.close-btn {
  position: absolute;
  top: 16px;
  right: 16px;
  background: rgba(0, 0, 0, 0.1);
  border: none;
  width: 40px;
  height: 40px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  z-index: 10;
  transition: all 0.3s ease;
  color: #666;
}

.close-btn:hover {
  background: rgba(0, 0, 0, 0.2);
  color: #333;
}

.product-modal {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 40px;
  padding: 30px;
}

.product-images {
  position: relative;
}

.main-image {
  position: relative;
  width: 100%;
  aspect-ratio: 1;
  overflow: hidden;
  border-radius: 12px;
  background: #f8f9fa;
}

.main-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.discount-badge {
  position: absolute;
  top: 16px;
  right: 16px;
  background: #ff4757;
  color: white;
  padding: 8px 12px;
  border-radius: 6px;
  font-size: 14px;
  font-weight: bold;
}

.product-details {
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.product-category {
  font-size: 14px;
  color: #666;
  text-transform: uppercase;
  font-weight: 500;
}

.product-title {
  font-size: 28px;
  font-weight: 700;
  color: #333;
  line-height: 1.3;
  margin: 0;
}

.product-rating {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.stars {
  display: flex;
  align-items: center;
  gap: 4px;
}

.stars i {
  font-size: 18px;
  color: #ddd;
  transition: color 0.3s ease;
}

.stars i.active {
  color: #ffd700;
}

.rating-value {
  margin-left: 12px;
  font-size: 16px;
  font-weight: 600;
  color: #333;
}

.reviews-count {
  font-size: 14px;
  color: #666;
}

.product-price {
  display: flex;
  align-items: center;
  gap: 16px;
}

.current-price {
  font-size: 32px;
  font-weight: 700;
  color: #e74c3c;
}

.original-price {
  font-size: 20px;
  color: #999;
  text-decoration: line-through;
}

.product-description h4 {
  font-size: 18px;
  color: #333;
  margin-bottom: 12px;
}

.product-description p {
  color: #666;
  line-height: 1.6;
  margin-bottom: 16px;
}

.features {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 12px;
}

.feature-item {
  display: flex;
  align-items: center;
  gap: 8px;
  color: #666;
  font-size: 14px;
}

.feature-item i {
  color: #28a745;
  font-size: 16px;
}

.quantity-selector {
  display: flex;
  align-items: center;
  gap: 16px;
}

.quantity-selector label {
  font-size: 16px;
  font-weight: 500;
  color: #333;
}

.quantity-controls {
  display: flex;
  align-items: center;
  gap: 12px;
  background: #f8f9fa;
  border-radius: 8px;
  padding: 8px;
}

.quantity-btn {
  width: 36px;
  height: 36px;
  border: none;
  background: white;
  border-radius: 6px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  font-size: 14px;
  color: #666;
  transition: all 0.3s ease;
}

.quantity-btn:hover:not(:disabled) {
  background: #e0e0e0;
  color: #333;
}

.quantity-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.quantity {
  font-size: 18px;
  font-weight: 600;
  min-width: 30px;
  text-align: center;
}

.product-actions {
  display: flex;
  gap: 12px;
  align-items: center;
}

.add-to-cart-btn {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  padding: 16px 24px;
  font-size: 16px;
  font-weight: 600;
}

.buy-now-btn {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  padding: 16px 24px;
  font-size: 16px;
  font-weight: 600;
}

.wishlist-btn {
  width: 56px;
  height: 56px;
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
  font-size: 20px;
  color: #ccc;
  transition: color 0.3s ease;
}

.wishlist-btn i.active {
  color: #e74c3c;
}

.shipping-info {
  background: #f8f9fa;
  border-radius: 8px;
  padding: 20px;
}

.shipping-item {
  display: flex;
  align-items: flex-start;
  gap: 12px;
  margin-bottom: 16px;
}

.shipping-item:last-child {
  margin-bottom: 0;
}

.shipping-item i {
  color: #667eea;
  font-size: 18px;
  margin-top: 2px;
}

.shipping-item .label {
  font-weight: 600;
  color: #333;
  display: block;
  margin-bottom: 4px;
}

.shipping-item .value {
  color: #666;
  font-size: 14px;
  line-height: 1.4;
}

/* 响应式设计 */
@media (max-width: 768px) {
  .modal-overlay {
    padding: 10px;
  }
  
  .product-modal {
    grid-template-columns: 1fr;
    gap: 24px;
    padding: 20px;
  }
  
  .product-title {
    font-size: 24px;
  }
  
  .current-price {
    font-size: 28px;
  }
  
  .original-price {
    font-size: 18px;
  }
  
  .features {
    grid-template-columns: 1fr;
  }
  
  .product-actions {
    flex-direction: column;
  }
  
  .wishlist-btn {
    width: 100%;
  }
}

@media (max-width: 480px) {
  .product-modal {
    padding: 16px;
  }
  
  .close-btn {
    top: 12px;
    right: 12px;
    width: 36px;
    height: 36px;
  }
  
  .quantity-selector {
    flex-direction: column;
    align-items: flex-start;
  }
  
  .shipping-info {
    padding: 16px;
  }
}
</style>