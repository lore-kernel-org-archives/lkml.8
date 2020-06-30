Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DDEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1511520723
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732662AbgF3Qjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 12:39:43 -0400
Received: from out28-100.mail.aliyun.com ([115.124.28.100]:41313 "EHLO
        out28-100.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732049AbgF3Qjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 12:39:37 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436311|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.480657-0.00508796-0.514255;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03275;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.HvJGFHX_1593535155;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.HvJGFHX_1593535155)
          by smtp.aliyun-inc.com(10.147.43.230);
          Wed, 01 Jul 2020 00:39:28 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sboyd@kernel.org,
        paul@crapouillou.net, mturquette@baylibre.com,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Subject: [PATCH v3 1/3] clk: JZ4780: Add functions for enable and disable USB PHY.
Date:   Wed,  1 Jul 2020 00:38:50 +0800
Message-Id: <20200630163852.47267-2-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200630163852.47267-1-zhouyanjie@wanyeetech.com>
References: <20200630163852.47267-1-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new functions to "jz4780_otg_phy_ops" to enable or disable the
USB PHY in the JZ4780 SoC.

Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---

Notes:
    v1->v2:
    1.Use "WARN()" instead "BUG()".
    2.Move the reformat part ot the new patch.
    3.Remove unnecessary get_parent/set_parent functions.
    
    v2->v3:
    1.Remove the wrong "WARN()".
    2.Remove extra blank line.

 drivers/clk/ingenic/jz4780-cgu.c | 65 +++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 30 deletions(-)

diff --git a/drivers/clk/ingenic/jz4780-cgu.c b/drivers/clk/ingenic/jz4780-cgu.c
index 6c5b8029cc8a..cf3f7f87e7a6 100644
--- a/drivers/clk/ingenic/jz4780-cgu.c
+++ b/drivers/clk/ingenic/jz4780-cgu.c
@@ -4,6 +4,7 @@
  *
  * Copyright (c) 2013-2015 Imagination Technologies
  * Author: Paul Burton <paul.burton@mips.com>
+ * Copyright (c) 2020 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
  */
 
 #include <linux/clk-provider.h>
@@ -59,6 +60,7 @@
 #define USBPCR_VBUSVLDEXT	BIT(24)
 #define USBPCR_VBUSVLDEXTSEL	BIT(23)
 #define USBPCR_POR		BIT(22)
+#define USBPCR_SIDDQ		BIT(21)
 #define USBPCR_OTG_DISABLE	BIT(20)
 #define USBPCR_COMPDISTUNE_MASK	(0x7 << 17)
 #define USBPCR_OTGTUNE_MASK	(0x7 << 14)
@@ -100,32 +102,6 @@
 
 static struct ingenic_cgu *cgu;
 
-static u8 jz4780_otg_phy_get_parent(struct clk_hw *hw)
-{
-	/* we only use CLKCORE, revisit if that ever changes */
-	return 0;
-}
-
-static int jz4780_otg_phy_set_parent(struct clk_hw *hw, u8 idx)
-{
-	unsigned long flags;
-	u32 usbpcr1;
-
-	if (idx > 0)
-		return -EINVAL;
-
-	spin_lock_irqsave(&cgu->lock, flags);
-
-	usbpcr1 = readl(cgu->base + CGU_REG_USBPCR1);
-	usbpcr1 &= ~USBPCR1_REFCLKSEL_MASK;
-	/* we only use CLKCORE */
-	usbpcr1 |= USBPCR1_REFCLKSEL_CORE;
-	writel(usbpcr1, cgu->base + CGU_REG_USBPCR1);
-
-	spin_unlock_irqrestore(&cgu->lock, flags);
-	return 0;
-}
-
 static unsigned long jz4780_otg_phy_recalc_rate(struct clk_hw *hw,
 						unsigned long parent_rate)
 {
@@ -149,7 +125,6 @@ static unsigned long jz4780_otg_phy_recalc_rate(struct clk_hw *hw,
 		return 19200000;
 	}
 
-	BUG();
 	return parent_rate;
 }
 
@@ -206,13 +181,43 @@ static int jz4780_otg_phy_set_rate(struct clk_hw *hw, unsigned long req_rate,
 	return 0;
 }
 
-static const struct clk_ops jz4780_otg_phy_ops = {
-	.get_parent = jz4780_otg_phy_get_parent,
-	.set_parent = jz4780_otg_phy_set_parent,
+static int jz4780_otg_phy_enable(struct clk_hw *hw)
+{
+	void __iomem *reg_opcr		= cgu->base + CGU_REG_OPCR;
+	void __iomem *reg_usbpcr	= cgu->base + CGU_REG_USBPCR;
+
+	writel(readl(reg_opcr) | OPCR_SPENDN0, reg_opcr);
+	writel(readl(reg_usbpcr) & ~USBPCR_OTG_DISABLE & ~USBPCR_SIDDQ, reg_usbpcr);
+	return 0;
+}
+
+static void jz4780_otg_phy_disable(struct clk_hw *hw)
+{
+	void __iomem *reg_opcr		= cgu->base + CGU_REG_OPCR;
+	void __iomem *reg_usbpcr	= cgu->base + CGU_REG_USBPCR;
 
+	writel(readl(reg_opcr) & ~OPCR_SPENDN0, reg_opcr);
+	writel(readl(reg_usbpcr) | USBPCR_OTG_DISABLE | USBPCR_SIDDQ, reg_usbpcr);
+}
+
+static int jz4780_otg_phy_is_enabled(struct clk_hw *hw)
+{
+	void __iomem *reg_opcr		= cgu->base + CGU_REG_OPCR;
+	void __iomem *reg_usbpcr	= cgu->base + CGU_REG_USBPCR;
+
+	return (readl(reg_opcr) & OPCR_SPENDN0) &&
+		!(readl(reg_usbpcr) & USBPCR_SIDDQ) &&
+		!(readl(reg_usbpcr) & USBPCR_OTG_DISABLE);
+}
+
+static const struct clk_ops jz4780_otg_phy_ops = {
 	.recalc_rate = jz4780_otg_phy_recalc_rate,
 	.round_rate = jz4780_otg_phy_round_rate,
 	.set_rate = jz4780_otg_phy_set_rate,
+
+	.enable		= jz4780_otg_phy_enable,
+	.disable	= jz4780_otg_phy_disable,
+	.is_enabled	= jz4780_otg_phy_is_enabled,
 };
 
 static int jz4780_core1_enable(struct clk_hw *hw)
-- 
2.11.0

