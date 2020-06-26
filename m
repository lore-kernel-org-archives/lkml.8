Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF69C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 16:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27B3A207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 16:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgFZQtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 12:49:31 -0400
Received: from out28-125.mail.aliyun.com ([115.124.28.125]:60049 "EHLO
        out28-125.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbgFZQtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 12:49:25 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436325|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.41423-0.00350768-0.582263;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03293;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.HsyHo9F_1593190149;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.HsyHo9F_1593190149)
          by smtp.aliyun-inc.com(10.147.41.137);
          Sat, 27 Jun 2020 00:49:18 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sboyd@kernel.org,
        paul@crapouillou.net, mturquette@baylibre.com,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Subject: [PATCH 2/2] clk: X1000: Add support for calculat REFCLK of USB PHY.
Date:   Sat, 27 Jun 2020 00:48:44 +0800
Message-Id: <20200626164844.25436-3-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200626164844.25436-1-zhouyanjie@wanyeetech.com>
References: <20200626164844.25436-1-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new functions to "x1000_otg_phy_ops" to calculat the rate of REFCLK,
which is needed by USB PHY in the Ingenic X1000 SoC.

Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---
 drivers/clk/ingenic/x1000-cgu.c | 113 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/drivers/clk/ingenic/x1000-cgu.c b/drivers/clk/ingenic/x1000-cgu.c
index 453f3323cb99..a61c16f98a11 100644
--- a/drivers/clk/ingenic/x1000-cgu.c
+++ b/drivers/clk/ingenic/x1000-cgu.c
@@ -48,8 +48,114 @@
 #define USBPCR_SIDDQ		BIT(21)
 #define USBPCR_OTG_DISABLE	BIT(20)
 
+/* bits within the USBPCR1 register */
+#define USBPCR1_REFCLKSEL_SHIFT	26
+#define USBPCR1_REFCLKSEL_MASK	(0x3 << USBPCR1_REFCLKSEL_SHIFT)
+#define USBPCR1_REFCLKSEL_CORE	(0x2 << USBPCR1_REFCLKSEL_SHIFT)
+#define USBPCR1_REFCLKDIV_SHIFT	24
+#define USBPCR1_REFCLKDIV_MASK	(0x3 << USBPCR1_REFCLKDIV_SHIFT)
+#define USBPCR1_REFCLKDIV_48	(0x2 << USBPCR1_REFCLKDIV_SHIFT)
+#define USBPCR1_REFCLKDIV_24	(0x1 << USBPCR1_REFCLKDIV_SHIFT)
+#define USBPCR1_REFCLKDIV_12	(0x0 << USBPCR1_REFCLKDIV_SHIFT)
+
 static struct ingenic_cgu *cgu;
 
+static u8 x1000_otg_phy_get_parent(struct clk_hw *hw)
+{
+	/* we only use CLKCORE, revisit if that ever changes */
+	return 0;
+}
+
+static int x1000_otg_phy_set_parent(struct clk_hw *hw, u8 idx)
+{
+	unsigned long flags;
+	u32 usbpcr1;
+
+	if (idx > 0)
+		return -EINVAL;
+
+	spin_lock_irqsave(&cgu->lock, flags);
+
+	usbpcr1 = readl(cgu->base + CGU_REG_USBPCR1);
+	usbpcr1 &= ~USBPCR1_REFCLKSEL_MASK;
+	/* we only use CLKCORE */
+	usbpcr1 |= USBPCR1_REFCLKSEL_CORE;
+	writel(usbpcr1, cgu->base + CGU_REG_USBPCR1);
+
+	spin_unlock_irqrestore(&cgu->lock, flags);
+	return 0;
+}
+
+static unsigned long x1000_otg_phy_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
+{
+	u32 usbpcr1;
+	unsigned refclk_div;
+
+	usbpcr1 = readl(cgu->base + CGU_REG_USBPCR1);
+	refclk_div = usbpcr1 & USBPCR1_REFCLKDIV_MASK;
+
+	switch (refclk_div) {
+	case USBPCR1_REFCLKDIV_12:
+		return 12000000;
+
+	case USBPCR1_REFCLKDIV_24:
+		return 24000000;
+
+	case USBPCR1_REFCLKDIV_48:
+		return 48000000;
+	}
+
+	BUG();
+	return parent_rate;
+}
+
+static long x1000_otg_phy_round_rate(struct clk_hw *hw, unsigned long req_rate,
+				      unsigned long *parent_rate)
+{
+	if (req_rate < 18000000)
+		return 12000000;
+
+	if (req_rate < 36000000)
+		return 24000000;
+
+	return 48000000;
+}
+
+static int x1000_otg_phy_set_rate(struct clk_hw *hw, unsigned long req_rate,
+				   unsigned long parent_rate)
+{
+	unsigned long flags;
+	u32 usbpcr1, div_bits;
+
+	switch (req_rate) {
+	case 12000000:
+		div_bits = USBPCR1_REFCLKDIV_12;
+		break;
+
+	case 24000000:
+		div_bits = USBPCR1_REFCLKDIV_24;
+		break;
+
+	case 48000000:
+		div_bits = USBPCR1_REFCLKDIV_48;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&cgu->lock, flags);
+
+	usbpcr1 = readl(cgu->base + CGU_REG_USBPCR1);
+	usbpcr1 &= ~USBPCR1_REFCLKDIV_MASK;
+	usbpcr1 |= div_bits;
+	writel(usbpcr1, cgu->base + CGU_REG_USBPCR1);
+
+	spin_unlock_irqrestore(&cgu->lock, flags);
+	return 0;
+}
+
 static int x1000_usb_phy_enable(struct clk_hw *hw)
 {
 	void __iomem *reg_opcr		= cgu->base + CGU_REG_OPCR;
@@ -80,6 +186,13 @@ static int x1000_usb_phy_is_enabled(struct clk_hw *hw)
 }
 
 static const struct clk_ops x1000_otg_phy_ops = {
+	.get_parent = x1000_otg_phy_get_parent,
+	.set_parent = x1000_otg_phy_set_parent,
+
+	.recalc_rate = x1000_otg_phy_recalc_rate,
+	.round_rate = x1000_otg_phy_round_rate,
+	.set_rate = x1000_otg_phy_set_rate,
+
 	.enable		= x1000_usb_phy_enable,
 	.disable	= x1000_usb_phy_disable,
 	.is_enabled	= x1000_usb_phy_is_enabled,
-- 
2.11.0

