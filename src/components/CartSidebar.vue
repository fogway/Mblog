<template>
  <div class="cart-sidebar-overlay" v-show="show" @click="$emit('close')">
    <div class="cart-sidebar" @click.stop>
      <div class="cart-header">
        <h3>
          <i class="fas fa-shopping-cart"></i>
          购物车 ({{ items.length }})
        </h3>
        <button @click="$emit('close')" class="close-btn">
          <i class="fas fa-times"></i>
        </button>
      </div>

      <div v-if="items.length === 0" class="empty-cart">
        <i class="fas fa-shopping-cart empty-icon"></i>
        <h4>购物车是空的</h4>
        <p>快去添加一些商品吧！</p>
        <button @click="$emit('close')" class="btn btn-primary">继续购物</button>
      </div>

      <div v-else class="cart-content">
        <div class="cart-items">
          <div 
            v-for="item in items" 
            :key="item.id"
            class="cart-item"
          >
            <div class="item-image">
              <img :src="item.image" :alt="item.name" />
            </div>
            
            <div class="item-details">
              <h4 class="item-name">{{ item.name }}</h4>
              <p class="item-category">{{ item.category }}</p>
              <div class="item-price">
                <span class="current-price">¥{{ formatPrice(item.price) }}</span>
                <span 
                  v-if="item.originalPrice && item.originalPrice > item.price"
                  class="original-price"
                >
                  ¥{{ formatPrice(item.originalPrice) }}
                </span>
              </div>
            </div>
            
            <div class="item-controls">
              <div class="quantity-controls">
                <button 
                  @click="updateQuantity(item.id, item.quantity - 1)"
                  :disabled="item.quantity <= 1"
                  class="quantity-btn"
                >
                  <i class="fas fa-minus"></i>
                </button>
                <span class="quantity">{{ item.quantity }}</span>
                <button 
                  @click="updateQuantity(item.id, item.quantity + 1)"
                  class="quantity-btn"
                >
                  <i class="fas fa-plus"></i>
                </button>
              </div>
              
              <button 
                @click="$emit('remove-item', item.id)"
                class="remove-btn"
                title="删除商品"
              >
                <i class="fas fa-trash"></i>
              </button>
            </div>
          </div>
        </div>

        <div class="cart-summary">
          <div class="summary-row">
            <span>商品总数：</span>
            <span>{{ totalItems }}件</span>
          </div>
          
          <div class="summary-row">
            <span>商品金额：</span>
            <span>¥{{ formatPrice(subtotal) }}</span>
          </div>
          
          <div class="summary-row" v-if="shipping > 0">
            <span>运费：</span>
            <span>¥{{ formatPrice(shipping) }}</span>
          </div>
          
          <div class="summary-row" v-else>
            <span>运费：</span>
            <span class="free-shipping">免费</span>
          </div>
          
          <div class="summary-row discount-row" v-if="discount > 0">
            <span>优惠金额：</span>
            <span class="discount-amount">-¥{{ formatPrice(discount) }}</span>
          </div>
          
          <hr class="summary-divider">
          
          <div class="summary-row total-row">
            <span>合计：</span>
            <span class="total-amount">¥{{ formatPrice(total) }}</span>
          </div>
          
          <div class="free-shipping-notice" v-if="subtotal < 299 && subtotal > 0">
            <i class="fas fa-truck"></i>
            <span>再购买 ¥{{ formatPrice(299 - subtotal) }} 即可免运费</span>
          </div>
        </div>

        <div class="cart-actions">
          <button 
            @click="$emit('checkout')"
            class="btn btn-primary checkout-btn"
            :disabled="items.length === 0"
          >
            <i class="fas fa-credit-card"></i>
            立即结账
          </button>
          
          <button 
            @click="$emit('close')"
            class="btn btn-secondary continue-shopping-btn"
          >
            <i class="fas fa-arrow-left"></i>
            继续购物
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { computed } from 'vue'

export default {
  name: 'CartSidebar',
  props: {
    show: {
      type: Boolean,
      default: false
    },
    items: {
      type: Array,
      default: () => []
    }
  },
  emits: ['close', 'update-quantity', 'remove-item', 'checkout'],
  setup(props, { emit }) {
    const formatPrice = (price) => {
      return price.toLocaleString()
    }

    const updateQuantity = (itemId, newQuantity) => {
      if (newQuantity > 0) {
        emit('update-quantity', itemId, newQuantity)
      }
    }

    const totalItems = computed(() => {
      return props.items.reduce((total, item) => total + item.quantity, 0)
    })

    const subtotal = computed(() => {
      return props.items.reduce((total, item) => total + (item.price * item.quantity), 0)
    })

    const shipping = computed(() => {
      return subtotal.value < 299 && subtotal.value > 0 ? 20 : 0
    })

    const discount = computed(() => {
      // 简单的折扣计算示例
      if (subtotal.value > 1000) {
        return Math.floor(subtotal.value * 0.05) // 5% 折扣
      }
      return 0
    })

    const total = computed(() => {
      return subtotal.value + shipping.value - discount.value
    })

    return {
      formatPrice,
      updateQuantity,
      totalItems,
      subtotal,
      shipping,
      discount,
      total
    }
  }
}
</script>

<style scoped>
.cart-sidebar-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.5);
  z-index: 1000;
  display: flex;
  justify-content: flex-end;
}

.cart-sidebar {
  width: 400px;
  background: white;
  height: 100vh;
  display: flex;
  flex-direction: column;
  animation: slideIn 0.3s ease;
}

@keyframes slideIn {
  from {
    transform: translateX(100%);
  }
  to {
    transform: translateX(0);
  }
}

.cart-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px;
  border-bottom: 1px solid #e0e0e0;
  background: #f8f9fa;
}

.cart-header h3 {
  margin: 0;
  font-size: 20px;
  color: #333;
  display: flex;
  align-items: center;
  gap: 8px;
}

.close-btn {
  background: none;
  border: none;
  font-size: 20px;
  color: #666;
  cursor: pointer;
  padding: 8px;
  border-radius: 50%;
  transition: all 0.3s ease;
}

.close-btn:hover {
  background: #e0e0e0;
  color: #333;
}

.empty-cart {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  padding: 40px 20px;
  text-align: center;
}

.empty-icon {
  font-size: 64px;
  color: #ccc;
  margin-bottom: 20px;
}

.empty-cart h4 {
  margin-bottom: 8px;
  color: #333;
}

.empty-cart p {
  color: #666;
  margin-bottom: 24px;
}

.cart-content {
  flex: 1;
  display: flex;
  flex-direction: column;
}

.cart-items {
  flex: 1;
  overflow-y: auto;
  padding: 16px;
}

.cart-item {
  display: flex;
  gap: 12px;
  padding: 16px 0;
  border-bottom: 1px solid #f0f0f0;
}

.cart-item:last-child {
  border-bottom: none;
}

.item-image {
  width: 60px;
  height: 60px;
  flex-shrink: 0;
}

.item-image img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  border-radius: 8px;
}

.item-details {
  flex: 1;
  min-width: 0;
}

.item-name {
  font-size: 14px;
  font-weight: 600;
  color: #333;
  margin-bottom: 4px;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.item-category {
  font-size: 12px;
  color: #666;
  margin-bottom: 8px;
}

.item-price {
  display: flex;
  align-items: center;
  gap: 8px;
}

.current-price {
  font-size: 16px;
  font-weight: 600;
  color: #e74c3c;
}

.original-price {
  font-size: 12px;
  color: #999;
  text-decoration: line-through;
}

.item-controls {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
}

.quantity-controls {
  display: flex;
  align-items: center;
  gap: 8px;
  background: #f8f9fa;
  border-radius: 8px;
  padding: 4px;
}

.quantity-btn {
  width: 28px;
  height: 28px;
  border: none;
  background: white;
  border-radius: 4px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  font-size: 12px;
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
  font-size: 14px;
  font-weight: 500;
  min-width: 20px;
  text-align: center;
}

.remove-btn {
  background: none;
  border: none;
  color: #dc3545;
  cursor: pointer;
  padding: 4px;
  border-radius: 4px;
  transition: all 0.3s ease;
  font-size: 14px;
}

.remove-btn:hover {
  background: #f8d7da;
}

.cart-summary {
  padding: 20px;
  background: #f8f9fa;
  border-top: 1px solid #e0e0e0;
}

.summary-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 8px;
  font-size: 14px;
}

.discount-row {
  color: #28a745;
}

.discount-amount {
  font-weight: 600;
}

.free-shipping {
  color: #28a745;
  font-weight: 500;
}

.summary-divider {
  border: none;
  border-top: 1px solid #e0e0e0;
  margin: 12px 0;
}

.total-row {
  font-size: 18px;
  font-weight: 600;
  color: #333;
}

.total-amount {
  color: #e74c3c;
}

.free-shipping-notice {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-top: 12px;
  padding: 8px 12px;
  background: #fff3cd;
  border: 1px solid #ffeaa7;
  border-radius: 6px;
  font-size: 12px;
  color: #856404;
}

.cart-actions {
  padding: 20px;
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.checkout-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  font-weight: 600;
}

.continue-shopping-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
}

/* 响应式设计 */
@media (max-width: 480px) {
  .cart-sidebar {
    width: 100vw;
  }
  
  .cart-header {
    padding: 16px;
  }
  
  .cart-items {
    padding: 12px;
  }
  
  .cart-item {
    padding: 12px 0;
  }
  
  .item-details {
    margin-right: 8px;
  }
  
  .cart-summary {
    padding: 16px;
  }
  
  .cart-actions {
    padding: 16px;
  }
}
</style>