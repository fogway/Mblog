<template>
  <header class="header">
    <div class="container">
      <div class="nav-content">
        <!-- Logo -->
        <div class="logo">
          <i class="fas fa-shopping-bag"></i>
          <span>优购商城</span>
        </div>

        <!-- 搜索栏 -->
        <div class="search-bar">
          <div class="search-input-wrapper">
            <i class="fas fa-search search-icon"></i>
            <input
              v-model="searchInput"
              type="text"
              placeholder="搜索商品..."
              @keyup.enter="handleSearch"
              class="search-input"
            />
            <button 
              v-if="searchInput"
              @click="clearSearch"
              class="clear-btn"
            >
              <i class="fas fa-times"></i>
            </button>
          </div>
          <button @click="handleSearch" class="search-btn">
            <i class="fas fa-search"></i>
          </button>
        </div>

        <!-- 导航菜单 -->
        <nav class="nav-menu">
          <a href="#" class="nav-link">
            <i class="fas fa-home"></i>
            <span>首页</span>
          </a>
          <a href="#" class="nav-link">
            <i class="fas fa-list"></i>
            <span>分类</span>
          </a>
          <a href="#" class="nav-link">
            <i class="fas fa-heart"></i>
            <span>收藏</span>
          </a>
          <a href="#" class="nav-link">
            <i class="fas fa-user"></i>
            <span>账户</span>
          </a>
          <button @click="$emit('toggle-cart')" class="cart-btn">
            <i class="fas fa-shopping-cart"></i>
            <span v-if="cartCount > 0" class="cart-badge">{{ cartCount }}</span>
          </button>
        </nav>

        <!-- 移动端菜单按钮 -->
        <button @click="showMobileMenu = !showMobileMenu" class="mobile-menu-btn">
          <i class="fas fa-bars"></i>
        </button>
      </div>

      <!-- 移动端菜单 -->
      <div v-show="showMobileMenu" class="mobile-menu">
        <div class="mobile-search">
          <div class="search-input-wrapper">
            <i class="fas fa-search search-icon"></i>
            <input
              v-model="searchInput"
              type="text"
              placeholder="搜索商品..."
              @keyup.enter="handleSearch"
              class="search-input"
            />
          </div>
          <button @click="handleSearch" class="search-btn">搜索</button>
        </div>
        <div class="mobile-nav-links">
          <a href="#" class="mobile-nav-link">
            <i class="fas fa-home"></i>
            <span>首页</span>
          </a>
          <a href="#" class="mobile-nav-link">
            <i class="fas fa-list"></i>
            <span>分类</span>
          </a>
          <a href="#" class="mobile-nav-link">
            <i class="fas fa-heart"></i>
            <span>收藏</span>
          </a>
          <a href="#" class="mobile-nav-link">
            <i class="fas fa-user"></i>
            <span>账户</span>
          </a>
          <button @click="$emit('toggle-cart')" class="mobile-cart-btn">
            <i class="fas fa-shopping-cart"></i>
            <span>购物车 ({{ cartCount }})</span>
          </button>
        </div>
      </div>
    </div>
  </header>
</template>

<script>
import { ref } from 'vue'

export default {
  name: 'Header',
  props: {
    cartCount: {
      type: Number,
      default: 0
    }
  },
  emits: ['toggle-cart', 'search'],
  setup(props, { emit }) {
    const searchInput = ref('')
    const showMobileMenu = ref(false)

    const handleSearch = () => {
      emit('search', searchInput.value.trim())
      showMobileMenu.value = false
    }

    const clearSearch = () => {
      searchInput.value = ''
      emit('search', '')
    }

    return {
      searchInput,
      showMobileMenu,
      handleSearch,
      clearSearch
    }
  }
}
</script>

<style scoped>
.header {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 16px 0;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
  position: sticky;
  top: 0;
  z-index: 100;
}

.nav-content {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 24px;
}

.logo {
  display: flex;
  align-items: center;
  gap: 12px;
  font-size: 24px;
  font-weight: bold;
  color: white;
  text-decoration: none;
}

.logo i {
  font-size: 28px;
}

.search-bar {
  flex: 1;
  max-width: 500px;
  display: flex;
  gap: 8px;
}

.search-input-wrapper {
  position: relative;
  flex: 1;
}

.search-input {
  width: 100%;
  padding: 12px 16px 12px 44px;
  border: none;
  border-radius: 8px;
  font-size: 16px;
  background: rgba(255, 255, 255, 0.95);
  color: #333;
  outline: none;
  transition: all 0.3s ease;
}

.search-input:focus {
  background: white;
  box-shadow: 0 0 0 3px rgba(255, 255, 255, 0.3);
}

.search-icon {
  position: absolute;
  left: 16px;
  top: 50%;
  transform: translateY(-50%);
  color: #666;
}

.clear-btn {
  position: absolute;
  right: 16px;
  top: 50%;
  transform: translateY(-50%);
  background: none;
  border: none;
  color: #666;
  cursor: pointer;
  padding: 4px;
  border-radius: 50%;
  transition: all 0.3s ease;
}

.clear-btn:hover {
  background: #f0f0f0;
}

.search-btn {
  background: rgba(255, 255, 255, 0.2);
  border: 2px solid rgba(255, 255, 255, 0.3);
  color: white;
  padding: 12px 20px;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.3s ease;
  white-space: nowrap;
}

.search-btn:hover {
  background: rgba(255, 255, 255, 0.3);
  border-color: rgba(255, 255, 255, 0.5);
}

.nav-menu {
  display: flex;
  align-items: center;
  gap: 24px;
}

.nav-link {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 4px;
  color: white;
  text-decoration: none;
  font-size: 14px;
  transition: all 0.3s ease;
  padding: 8px;
  border-radius: 8px;
}

.nav-link:hover {
  background: rgba(255, 255, 255, 0.1);
  transform: translateY(-2px);
}

.nav-link i {
  font-size: 18px;
}

.cart-btn {
  position: relative;
  background: rgba(255, 255, 255, 0.2);
  border: 2px solid rgba(255, 255, 255, 0.3);
  color: white;
  padding: 12px;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.cart-btn:hover {
  background: rgba(255, 255, 255, 0.3);
  transform: translateY(-2px);
}

.cart-btn i {
  font-size: 20px;
}

.cart-badge {
  position: absolute;
  top: -8px;
  right: -8px;
  background: #ff4757;
  color: white;
  border-radius: 50%;
  width: 24px;
  height: 24px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 12px;
  font-weight: bold;
}

.mobile-menu-btn {
  display: none;
  background: none;
  border: none;
  color: white;
  font-size: 24px;
  cursor: pointer;
  padding: 8px;
  border-radius: 8px;
  transition: all 0.3s ease;
}

.mobile-menu-btn:hover {
  background: rgba(255, 255, 255, 0.1);
}

.mobile-menu {
  margin-top: 16px;
  padding: 20px;
  background: rgba(0, 0, 0, 0.1);
  border-radius: 12px;
}

.mobile-search {
  display: flex;
  gap: 8px;
  margin-bottom: 20px;
}

.mobile-nav-links {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.mobile-nav-link,
.mobile-cart-btn {
  display: flex;
  align-items: center;
  gap: 12px;
  color: white;
  text-decoration: none;
  padding: 12px 16px;
  border-radius: 8px;
  transition: all 0.3s ease;
  background: none;
  border: none;
  font-size: 16px;
  cursor: pointer;
  text-align: left;
  width: 100%;
}

.mobile-nav-link:hover,
.mobile-cart-btn:hover {
  background: rgba(255, 255, 255, 0.1);
}

.mobile-cart-btn {
  border: 2px solid rgba(255, 255, 255, 0.3);
  margin-top: 8px;
}

@media (max-width: 768px) {
  .search-bar {
    display: none;
  }
  
  .nav-menu {
    display: none;
  }
  
  .mobile-menu-btn {
    display: block;
  }
  
  .nav-content {
    gap: 16px;
  }
  
  .logo {
    font-size: 20px;
  }
  
  .logo i {
    font-size: 24px;
  }
}

@media (max-width: 480px) {
  .header {
    padding: 12px 0;
  }
  
  .logo span {
    display: none;
  }
  
  .mobile-search {
    flex-direction: column;
  }
  
  .search-btn {
    padding: 8px 16px;
  }
}
</style>