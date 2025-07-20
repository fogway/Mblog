<template>
  <footer class="footer">
    <div class="container">
      <div class="footer-content">
        <!-- 公司信息 -->
        <div class="footer-section">
          <div class="footer-logo">
            <i class="fas fa-shopping-bag"></i>
            <span>优购商城</span>
          </div>
          <p class="footer-description">
            致力于为客户提供优质的商品和便捷的购物体验。
            我们精选全球好货，确保品质，让您购物无忧。
          </p>
          <div class="social-links">
            <a href="#" class="social-link">
              <i class="fab fa-weixin"></i>
            </a>
            <a href="#" class="social-link">
              <i class="fab fa-weibo"></i>
            </a>
            <a href="#" class="social-link">
              <i class="fab fa-qq"></i>
            </a>
            <a href="#" class="social-link">
              <i class="fab fa-douyin"></i>
            </a>
          </div>
        </div>

        <!-- 购物指南 -->
        <div class="footer-section">
          <h4>购物指南</h4>
          <ul class="footer-links">
            <li><a href="#">购物流程</a></li>
            <li><a href="#">会员介绍</a></li>
            <li><a href="#">生活旅行</a></li>
            <li><a href="#">常见问题</a></li>
            <li><a href="#">大家电</a></li>
            <li><a href="#">联系客服</a></li>
          </ul>
        </div>

        <!-- 配送方式 -->
        <div class="footer-section">
          <h4>配送方式</h4>
          <ul class="footer-links">
            <li><a href="#">免费配送</a></li>
            <li><a href="#">海外配送</a></li>
            <li><a href="#">EMS</a></li>
            <li><a href="#">211限时达</a></li>
            <li><a href="#">配送服务查询</a></li>
            <li><a href="#">配送费收取标准</a></li>
          </ul>
        </div>

        <!-- 支付方式 -->
        <div class="footer-section">
          <h4>支付方式</h4>
          <ul class="footer-links">
            <li><a href="#">货到付款</a></li>
            <li><a href="#">在线支付</a></li>
            <li><a href="#">分期付款</a></li>
            <li><a href="#">邮局汇款</a></li>
            <li><a href="#">公司转账</a></li>
            <li><a href="#">余额支付</a></li>
          </ul>
        </div>

        <!-- 售后服务 -->
        <div class="footer-section">
          <h4>售后服务</h4>
          <ul class="footer-links">
            <li><a href="#">售后政策</a></li>
            <li><a href="#">价格保护</a></li>
            <li><a href="#">退款说明</a></li>
            <li><a href="#">返修/退换货</a></li>
            <li><a href="#">取消订单</a></li>
            <li><a href="#">特色服务</a></li>
          </ul>
        </div>

        <!-- 联系我们 -->
        <div class="footer-section">
          <h4>联系我们</h4>
          <div class="contact-info">
            <div class="contact-item">
              <i class="fas fa-phone"></i>
              <span>400-618-4000</span>
            </div>
            <div class="contact-item">
              <i class="fas fa-envelope"></i>
              <span>service@yougou.com</span>
            </div>
            <div class="contact-item">
              <i class="fas fa-map-marker-alt"></i>
              <span>北京市朝阳区建国路88号</span>
            </div>
            <div class="contact-item">
              <i class="fas fa-clock"></i>
              <span>周一至周日 9:00-22:00</span>
            </div>
          </div>
        </div>
      </div>

      <!-- 信任标识 -->
      <div class="trust-badges">
        <div class="badge-item">
          <i class="fas fa-shield-alt"></i>
          <span>正品保障</span>
        </div>
        <div class="badge-item">
          <i class="fas fa-truck"></i>
          <span>极速物流</span>
        </div>
        <div class="badge-item">
          <i class="fas fa-undo"></i>
          <span>无忧退换</span>
        </div>
        <div class="badge-item">
          <i class="fas fa-headset"></i>
          <span>优质服务</span>
        </div>
        <div class="badge-item">
          <i class="fas fa-certificate"></i>
          <span>品质认证</span>
        </div>
      </div>

      <!-- 版权信息 -->
      <div class="footer-bottom">
        <div class="copyright">
          <p>&copy; 2024 优购商城. 保留所有权利. | 
            <a href="#">隐私政策</a> | 
            <a href="#">服务条款</a> | 
            <a href="#">网站地图</a>
          </p>
          <p>京ICP备00000000号-1 | 京公网安备00000000000000号</p>
        </div>
        
        <div class="payment-methods">
          <span>支持支付方式：</span>
          <div class="payment-icons">
            <i class="fab fa-alipay" title="支付宝"></i>
            <i class="fab fa-weixin" title="微信支付"></i>
            <i class="fab fa-cc-visa" title="Visa"></i>
            <i class="fab fa-cc-mastercard" title="Mastercard"></i>
            <i class="fab fa-cc-paypal" title="PayPal"></i>
          </div>
        </div>
      </div>
    </div>
  </footer>
</template>

<script>
export default {
  name: 'Footer'
}
</script>

<style scoped>
.footer {
  background: #2c3e50;
  color: #ecf0f1;
  padding: 60px 0 20px;
  margin-top: 60px;
}

.footer-content {
  display: grid;
  grid-template-columns: 2fr repeat(5, 1fr);
  gap: 40px;
  margin-bottom: 40px;
}

.footer-section h4 {
  font-size: 18px;
  font-weight: 600;
  margin-bottom: 20px;
  color: #ecf0f1;
}

.footer-logo {
  display: flex;
  align-items: center;
  gap: 12px;
  font-size: 24px;
  font-weight: bold;
  margin-bottom: 16px;
  color: #3498db;
}

.footer-logo i {
  font-size: 28px;
}

.footer-description {
  line-height: 1.6;
  margin-bottom: 24px;
  color: #bdc3c7;
}

.social-links {
  display: flex;
  gap: 12px;
}

.social-link {
  width: 40px;
  height: 40px;
  background: rgba(255, 255, 255, 0.1);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #ecf0f1;
  text-decoration: none;
  transition: all 0.3s ease;
  font-size: 18px;
}

.social-link:hover {
  background: #3498db;
  transform: translateY(-2px);
}

.footer-links {
  list-style: none;
  padding: 0;
  margin: 0;
}

.footer-links li {
  margin-bottom: 12px;
}

.footer-links a {
  color: #bdc3c7;
  text-decoration: none;
  transition: color 0.3s ease;
  font-size: 14px;
}

.footer-links a:hover {
  color: #3498db;
}

.contact-info {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.contact-item {
  display: flex;
  align-items: center;
  gap: 12px;
  color: #bdc3c7;
  font-size: 14px;
}

.contact-item i {
  color: #3498db;
  font-size: 16px;
  width: 20px;
}

.trust-badges {
  display: flex;
  justify-content: center;
  gap: 40px;
  padding: 30px 0;
  border-top: 1px solid rgba(255, 255, 255, 0.1);
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
  margin-bottom: 30px;
}

.badge-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  color: #bdc3c7;
}

.badge-item i {
  font-size: 24px;
  color: #3498db;
}

.badge-item span {
  font-size: 14px;
  font-weight: 500;
}

.footer-bottom {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-top: 20px;
  border-top: 1px solid rgba(255, 255, 255, 0.1);
}

.copyright {
  color: #95a5a6;
  font-size: 14px;
}

.copyright p {
  margin-bottom: 8px;
}

.copyright a {
  color: #95a5a6;
  text-decoration: none;
  transition: color 0.3s ease;
}

.copyright a:hover {
  color: #3498db;
}

.payment-methods {
  display: flex;
  align-items: center;
  gap: 12px;
  color: #95a5a6;
  font-size: 14px;
}

.payment-icons {
  display: flex;
  gap: 8px;
}

.payment-icons i {
  font-size: 24px;
  color: #bdc3c7;
  transition: color 0.3s ease;
}

.payment-icons i:hover {
  color: #3498db;
}

/* 响应式设计 */
@media (max-width: 1024px) {
  .footer-content {
    grid-template-columns: repeat(3, 1fr);
    gap: 30px;
  }
  
  .trust-badges {
    gap: 24px;
  }
}

@media (max-width: 768px) {
  .footer {
    padding: 40px 0 20px;
  }
  
  .footer-content {
    grid-template-columns: repeat(2, 1fr);
    gap: 30px;
  }
  
  .trust-badges {
    flex-wrap: wrap;
    gap: 20px;
  }
  
  .footer-bottom {
    flex-direction: column;
    gap: 20px;
    text-align: center;
  }
  
  .payment-methods {
    flex-direction: column;
    gap: 8px;
  }
}

@media (max-width: 480px) {
  .footer {
    padding: 30px 0 15px;
  }
  
  .footer-content {
    grid-template-columns: 1fr;
    gap: 30px;
  }
  
  .footer-section:first-child {
    text-align: center;
  }
  
  .social-links {
    justify-content: center;
  }
  
  .trust-badges {
    grid-template-columns: repeat(2, 1fr);
    gap: 16px;
  }
  
  .badge-item {
    padding: 16px;
    background: rgba(255, 255, 255, 0.05);
    border-radius: 8px;
  }
}
</style>