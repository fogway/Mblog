<template>
  <section class="hero-banner">
    <div class="container">
      <div class="hero-content">
        <div class="hero-text">
          <h1 class="hero-title">
            发现精彩
            <span class="highlight">优购商城</span>
          </h1>
          <p class="hero-subtitle">
            精选优质商品，享受便捷购物体验
            <br>
            全网最低价，品质有保障
          </p>
          <div class="hero-features">
            <div class="feature-item">
              <i class="fas fa-shipping-fast"></i>
              <span>极速配送</span>
            </div>
            <div class="feature-item">
              <i class="fas fa-shield-alt"></i>
              <span>品质保证</span>
            </div>
            <div class="feature-item">
              <i class="fas fa-tags"></i>
              <span>优惠价格</span>
            </div>
          </div>
          <div class="hero-actions">
            <a href="#products" class="btn btn-primary btn-large">
              <i class="fas fa-shopping-bag"></i>
              立即购物
            </a>
            <a href="#" class="btn btn-secondary btn-large">
              <i class="fas fa-gift"></i>
              查看优惠
            </a>
          </div>
        </div>
        
        <div class="hero-image">
          <div class="floating-card card-1">
            <i class="fas fa-mobile-alt"></i>
            <span>数码产品</span>
          </div>
          <div class="floating-card card-2">
            <i class="fas fa-tshirt"></i>
            <span>时尚服饰</span>
          </div>
          <div class="floating-card card-3">
            <i class="fas fa-home"></i>
            <span>家居生活</span>
          </div>
          <div class="hero-graphic">
            <div class="circle circle-1"></div>
            <div class="circle circle-2"></div>
            <div class="circle circle-3"></div>
            <div class="shopping-icon">
              <i class="fas fa-shopping-cart"></i>
            </div>
          </div>
        </div>
      </div>
      
      <!-- 促销横幅 -->
      <div class="promo-banner">
        <div class="promo-item">
          <i class="fas fa-percent"></i>
          <span>限时特惠 全场8折起</span>
        </div>
        <div class="promo-item">
          <i class="fas fa-truck"></i>
          <span>满299元免运费</span>
        </div>
        <div class="promo-item">
          <i class="fas fa-undo"></i>
          <span>7天无理由退换</span>
        </div>
        <div class="promo-item">
          <i class="fas fa-headset"></i>
          <span>24小时客服在线</span>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
export default {
  name: 'HeroBanner'
}
</script>

<style scoped>
.hero-banner {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 80px 0 40px;
  position: relative;
  overflow: hidden;
}

.hero-banner::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="25" cy="25" r="1" fill="%23ffffff" opacity="0.1"/><circle cx="75" cy="75" r="1" fill="%23ffffff" opacity="0.1"/><circle cx="50" cy="10" r="0.5" fill="%23ffffff" opacity="0.1"/><circle cx="10" cy="60" r="0.5" fill="%23ffffff" opacity="0.1"/><circle cx="90" cy="40" r="0.5" fill="%23ffffff" opacity="0.1"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
}

.hero-content {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 60px;
  align-items: center;
  position: relative;
  z-index: 2;
}

.hero-title {
  font-size: 3.5rem;
  font-weight: 800;
  line-height: 1.2;
  margin-bottom: 24px;
  background: linear-gradient(45deg, #fff, #f8f9ff);
  background-clip: text;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.highlight {
  background: linear-gradient(45deg, #ffd700, #ffed4e);
  background-clip: text;
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}

.hero-subtitle {
  font-size: 1.25rem;
  line-height: 1.6;
  margin-bottom: 32px;
  opacity: 0.9;
}

.hero-features {
  display: flex;
  gap: 32px;
  margin-bottom: 40px;
}

.feature-item {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 16px;
  font-weight: 500;
}

.feature-item i {
  font-size: 20px;
  color: #ffd700;
}

.hero-actions {
  display: flex;
  gap: 16px;
}

.btn-large {
  padding: 16px 32px;
  font-size: 18px;
  font-weight: 600;
}

.hero-image {
  position: relative;
  display: flex;
  justify-content: center;
  align-items: center;
  height: 400px;
}

.hero-graphic {
  position: relative;
  width: 200px;
  height: 200px;
  display: flex;
  justify-content: center;
  align-items: center;
}

.circle {
  position: absolute;
  border-radius: 50%;
  animation: float 6s ease-in-out infinite;
}

.circle-1 {
  width: 80px;
  height: 80px;
  background: rgba(255, 255, 255, 0.1);
  top: 20px;
  left: 20px;
  animation-delay: 0s;
}

.circle-2 {
  width: 60px;
  height: 60px;
  background: rgba(255, 215, 0, 0.3);
  bottom: 30px;
  right: 30px;
  animation-delay: 2s;
}

.circle-3 {
  width: 100px;
  height: 100px;
  background: rgba(255, 255, 255, 0.05);
  top: 10px;
  right: 10px;
  animation-delay: 4s;
}

.shopping-icon {
  background: rgba(255, 255, 255, 0.15);
  backdrop-filter: blur(10px);
  width: 80px;
  height: 80px;
  border-radius: 50%;
  display: flex;
  justify-content: center;
  align-items: center;
  font-size: 32px;
  border: 2px solid rgba(255, 255, 255, 0.2);
  animation: pulse 2s ease-in-out infinite;
}

.floating-card {
  position: absolute;
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(10px);
  padding: 16px 20px;
  border-radius: 12px;
  border: 1px solid rgba(255, 255, 255, 0.2);
  display: flex;
  align-items: center;
  gap: 8px;
  font-weight: 500;
  animation: float 4s ease-in-out infinite;
}

.card-1 {
  top: 50px;
  left: -20px;
  animation-delay: 0s;
}

.card-2 {
  top: 150px;
  right: -30px;
  animation-delay: 1.5s;
}

.card-3 {
  bottom: 80px;
  left: 30px;
  animation-delay: 3s;
}

.floating-card i {
  font-size: 20px;
  color: #ffd700;
}

.promo-banner {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 24px;
  margin-top: 60px;
  padding-top: 40px;
  border-top: 1px solid rgba(255, 255, 255, 0.2);
}

.promo-item {
  display: flex;
  align-items: center;
  gap: 12px;
  font-weight: 500;
  opacity: 0.9;
}

.promo-item i {
  font-size: 24px;
  color: #ffd700;
}

@keyframes float {
  0%, 100% {
    transform: translateY(0px);
  }
  50% {
    transform: translateY(-20px);
  }
}

@keyframes pulse {
  0%, 100% {
    transform: scale(1);
  }
  50% {
    transform: scale(1.1);
  }
}

/* 响应式设计 */
@media (max-width: 1024px) {
  .hero-content {
    gap: 40px;
  }
  
  .hero-title {
    font-size: 3rem;
  }
}

@media (max-width: 768px) {
  .hero-banner {
    padding: 60px 0 40px;
  }
  
  .hero-content {
    grid-template-columns: 1fr;
    gap: 40px;
    text-align: center;
  }
  
  .hero-title {
    font-size: 2.5rem;
  }
  
  .hero-features {
    justify-content: center;
    flex-wrap: wrap;
    gap: 20px;
  }
  
  .hero-actions {
    justify-content: center;
    flex-wrap: wrap;
  }
  
  .promo-banner {
    grid-template-columns: repeat(2, 1fr);
    gap: 20px;
    margin-top: 40px;
  }
  
  .floating-card {
    display: none;
  }
}

@media (max-width: 480px) {
  .hero-banner {
    padding: 40px 0;
  }
  
  .hero-title {
    font-size: 2rem;
  }
  
  .hero-subtitle {
    font-size: 1.1rem;
  }
  
  .hero-features {
    flex-direction: column;
    gap: 16px;
  }
  
  .btn-large {
    padding: 14px 24px;
    font-size: 16px;
  }
  
  .promo-banner {
    grid-template-columns: 1fr;
    gap: 16px;
  }
  
  .promo-item {
    justify-content: center;
  }
}
</style>