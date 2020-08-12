Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE7FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 207B6207F7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597247853;
	bh=sXcVriL7fW7V08fbpJ7Tb00ur8KSstDBRfxmfz6gqL0=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=mxy+HAl1Oc59Q8z040dOmn8330D7R/xpGUwxlHVzINwBjfvhnd8yAKy5KxhMyLByg
	 bzHscN2EjV9NRctaHu0sVs+I1f1IdkHJ6e7RfVfWPbUZM9LrbQpibTgzQAQ4UVNqNH
	 75FeHQXNcNzsE+hrPzPJ0BHVWMhq2htQMlJ91CZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgHLP53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:57:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbgHLP5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:57:07 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9133122BED;
        Wed, 12 Aug 2020 15:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597247821;
        bh=sXcVriL7fW7V08fbpJ7Tb00ur8KSstDBRfxmfz6gqL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d0dHZFTT9680+4uj9117Spi7g6KXrMh/kMF23zEh3NzPRsEGIg7TcEkV5+qEn2dB4
         6Twozk5VMKujpszsxkAd3XywBxQAeWGtJdE9mZNIjjfHnhH3Fp/mhChRCDq3rCqpr3
         cqGJqyfP8yWBUpf1M/+9xW8PkSDXHcVTGrlq6G08=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5t7a-005t6Z-GD; Wed, 12 Aug 2020 17:56:58 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH 22/44] staging: mfd: hi6421-spmi-pmic: cleanup the code
Date:   Wed, 12 Aug 2020 17:56:32 +0200
Message-Id: <53538fea80c07c4fe4d9ba158d5e2df2e1201bc8.1597247164.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597247164.git.mchehab+huawei@kernel.org>
References: <cover.1597247164.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several small cleanups that can be done in order to
make the code more prepared to be upstreamed.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 146 +++++++++-----------
 include/linux/mfd/hi6421-spmi-pmic.h        |  13 +-
 2 files changed, 71 insertions(+), 88 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
index d8b84d64041e..76766e7b8bf9 100644
--- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
+++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
@@ -17,26 +17,23 @@
  *
  */
 
-#include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/device.h>
-#include <linux/module.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/irq.h>
 #include <linux/mfd/core.h>
-#include <linux/platform_device.h>
-#include <linux/of.h>
+#include <linux/mfd/hi6421-spmi-pmic.h>
+#include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
+#include <linux/of.h>
 #include <linux/of_irq.h>
-#include <linux/mfd/hi6421-spmi-pmic.h>
-#include <linux/irq.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
 #include <linux/spmi.h>
-#ifndef NO_IRQ
-#define NO_IRQ       0
-#endif
 
 /* 8-bit register offset in PMIC */
 #define HISI_MASK_STATE			0xff
@@ -46,12 +43,11 @@
 #define HISI_IRQ_KEY_DOWN		7
 #define HISI_IRQ_KEY_UP			6
 
-/*#define HISI_NR_IRQ			25*/
-#define HISI_MASK_FIELD		0xFF
+#define HISI_MASK_FIELD			0xFF
 #define HISI_BITS			8
 
 /*define the first group interrupt register number*/
-#define HISI_PMIC_FIRST_GROUP_INT_NUM        2
+#define HISI_PMIC_FIRST_GROUP_INT_NUM	2
 
 static const struct mfd_cell hi6421v600_devs[] = {
 	{ .name = "hi6421v600-regulator", },
@@ -62,58 +58,60 @@ static const struct mfd_cell hi6421v600_devs[] = {
  * Hisilicon SoC use hardware to map PMIC register into SoC mapping.
  * At here, we are accessing SoC register with 32-bit.
  */
-u32 hi6421_spmi_pmic_read(struct hi6421_spmi_pmic *pmic, int reg)
+int hi6421_spmi_pmic_read(struct hi6421_spmi_pmic *pmic, int reg)
 {
-	u32 ret;
+	struct spmi_device *pdev;
 	u8 read_value = 0;
-	struct spmi_device *pdev;
+	u32 ret;
 
 	pdev = to_spmi_device(pmic->dev);
 	if (!pdev) {
 		pr_err("%s: pdev get failed!\n", __func__);
-		return 0;
+		return -ENODEV;
 	}
 
-	ret = spmi_ext_register_readl(pdev, reg,
-				      (unsigned char *)&read_value, 1);
+	ret = spmi_ext_register_readl(pdev, reg, &read_value, 1);
 	if (ret) {
 		pr_err("%s: spmi_ext_register_readl failed!\n", __func__);
-		return 0;
+		return ret;
 	}
-	return (u32)read_value;
+	return read_value;
 }
 EXPORT_SYMBOL(hi6421_spmi_pmic_read);
 
-void hi6421_spmi_pmic_write(struct hi6421_spmi_pmic *pmic, int reg, u32 val)
+int hi6421_spmi_pmic_write(struct hi6421_spmi_pmic *pmic, int reg, u32 val)
 {
-	u32 ret;
 	struct spmi_device *pdev;
+	u32 ret;
 
 	pdev = to_spmi_device(pmic->dev);
 	if (!pdev) {
 		pr_err("%s: pdev get failed!\n", __func__);
-		return;
+		return -ENODEV;
 	}
 
 	ret = spmi_ext_register_writel(pdev, reg, (unsigned char *)&val, 1);
-	if (ret) {
+	if (ret)
 		pr_err("%s: spmi_ext_register_writel failed!\n", __func__);
-		return;
-	}
+
+	return ret;
 }
 EXPORT_SYMBOL(hi6421_spmi_pmic_write);
 
-void hi6421_spmi_pmic_rmw(struct hi6421_spmi_pmic *pmic, int reg,
+int hi6421_spmi_pmic_rmw(struct hi6421_spmi_pmic *pmic, int reg,
 			  u32 mask, u32 bits)
 {
+	unsigned long flags;
 	u32 data;
-	unsigned long flags;
+	int ret;
 
 	spin_lock_irqsave(&pmic->lock, flags);
 	data = hi6421_spmi_pmic_read(pmic, reg) & ~mask;
 	data |= mask & bits;
-	hi6421_spmi_pmic_write(pmic, reg, data);
+	ret = hi6421_spmi_pmic_write(pmic, reg, data);
 	spin_unlock_irqrestore(&pmic->lock, flags);
+
+	return ret;
 }
 EXPORT_SYMBOL(hi6421_spmi_pmic_rmw);
 
@@ -124,13 +122,12 @@ static irqreturn_t hi6421_spmi_irq_handler(int irq, void *data)
 	int i, offset;
 
 	for (i = 0; i < pmic->irqarray; i++) {
-		pending = hi6421_spmi_pmic_read(pmic, (i + pmic->irq_addr.start_addr));
+		pending = hi6421_spmi_pmic_read(pmic, (i + pmic->irq_addr));
 		pending &= HISI_MASK_FIELD;
 		if (pending != 0)
 			pr_debug("pending[%d]=0x%lx\n\r", i, pending);
 
-		hi6421_spmi_pmic_write(pmic, (i + pmic->irq_addr.start_addr),
-				       pending);
+		hi6421_spmi_pmic_write(pmic, (i + pmic->irq_addr), pending);
 
 		/* solve powerkey order */
 		if ((i == HISI_IRQ_KEY_NUM) && ((pending & HISI_IRQ_KEY_VALUE) == HISI_IRQ_KEY_VALUE)) {
@@ -155,7 +152,7 @@ static void hi6421_spmi_irq_mask(struct irq_data *d)
 	unsigned long flags;
 
 	offset = (irqd_to_hwirq(d) >> 3);
-	offset += pmic->irq_mask_addr.start_addr;
+	offset += pmic->irq_mask_addr;
 
 	spin_lock_irqsave(&pmic->lock, flags);
 	data = hi6421_spmi_pmic_read(pmic, offset);
@@ -171,7 +168,7 @@ static void hi6421_spmi_irq_unmask(struct irq_data *d)
 	unsigned long flags;
 
 	offset = (irqd_to_hwirq(d) >> 3);
-	offset += pmic->irq_mask_addr.start_addr;
+	offset += pmic->irq_mask_addr;
 
 	spin_lock_irqsave(&pmic->lock, flags);
 	data = hi6421_spmi_pmic_read(pmic, offset);
@@ -211,36 +208,32 @@ static int get_pmic_device_tree_data(struct device_node *np,
 {
 	int ret = 0;
 
-	/*get pmic irq num*/
-	ret = of_property_read_u32_array(np, "irq-num",
-					 &pmic->irqnum, 1);
+	/* IRQ number */
+	ret = of_property_read_u32(np, "irq-num", &pmic->irqnum);
 	if (ret) {
 		pr_err("no irq-num property set\n");
 		ret = -ENODEV;
 		return ret;
 	}
 
-	/*get pmic irq array number*/
-	ret = of_property_read_u32_array(np, "irq-array",
-					 &pmic->irqarray, 1);
+	/* Size of IRQ array */
+	ret = of_property_read_u32(np, "irq-array", &pmic->irqarray);
 	if (ret) {
 		pr_err("no irq-array property set\n");
 		ret = -ENODEV;
 		return ret;
 	}
 
-	/*SOC_PMIC_IRQ_MASK_0_ADDR*/
-	ret = of_property_read_u32_array(np, "irq-mask-addr",
-					 (int *)&pmic->irq_mask_addr, 2);
+	/* SOC_PMIC_IRQ_MASK_0_ADDR */
+	ret = of_property_read_u32(np, "irq-mask-addr", &pmic->irq_mask_addr);
 	if (ret) {
 		pr_err("no irq-mask-addr property set\n");
 		ret = -ENODEV;
 		return ret;
 	}
 
-	/*SOC_PMIC_IRQ0_ADDR*/
-	ret = of_property_read_u32_array(np, "irq-addr",
-					 (int *)&pmic->irq_addr, 2);
+	/* SOC_PMIC_IRQ0_ADDR */
+	ret = of_property_read_u32(np, "irq-addr", &pmic->irq_addr);
 	if (ret) {
 		pr_err("no irq-addr property set\n");
 		ret = -ENODEV;
@@ -252,18 +245,18 @@ static int get_pmic_device_tree_data(struct device_node *np,
 
 static void hi6421_spmi_pmic_irq_prc(struct hi6421_spmi_pmic *pmic)
 {
-	int i;
+	int i, pending;
 
-	for (i = 0 ; i < pmic->irq_mask_addr.array; i++)
-		hi6421_spmi_pmic_write(pmic, pmic->irq_mask_addr.start_addr + i,
+	for (i = 0 ; i < pmic->irqarray; i++)
+		hi6421_spmi_pmic_write(pmic, pmic->irq_mask_addr + i,
 				       HISI_MASK_STATE);
 
-	for (i = 0 ; i < pmic->irq_addr.array; i++) {
-		unsigned int pending = hi6421_spmi_pmic_read(pmic, pmic->irq_addr.start_addr + i);
+	for (i = 0 ; i < pmic->irqarray; i++) {
+		pending = hi6421_spmi_pmic_read(pmic, pmic->irq_addr + i);
 
 		pr_debug("PMU IRQ address value:irq[0x%x] = 0x%x\n",
-			 pmic->irq_addr.start_addr + i, pending);
-		hi6421_spmi_pmic_write(pmic, pmic->irq_addr.start_addr + i,
+			 pmic->irq_addr + i, pending);
+		hi6421_spmi_pmic_write(pmic, pmic->irq_addr + i,
 				       HISI_MASK_STATE);
 	}
 }
@@ -272,36 +265,32 @@ static int hi6421_spmi_pmic_probe(struct spmi_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	struct hi6421_spmi_pmic *pmic = NULL;
-	enum of_gpio_flags flags;
-	int ret = 0;
-	int i;
+	struct hi6421_spmi_pmic *pmic;
 	unsigned int virq;
+	int ret, i;
 
 	pmic = devm_kzalloc(dev, sizeof(*pmic), GFP_KERNEL);
 	if (!pmic)
 		return -ENOMEM;
 
-	/*TODO: get pmic dts info*/
 	ret = get_pmic_device_tree_data(np, pmic);
 	if (ret) {
-		dev_err(&pdev->dev, "Error reading hisi pmic dts\n");
+		dev_err(dev, "Error reading hisi pmic dts\n");
 		return ret;
 	}
 
-	/* TODO: get and enable clk request */
 	spin_lock_init(&pmic->lock);
 
 	pmic->dev = dev;
 
-	pmic->gpio = of_get_gpio_flags(np, 0, &flags);
+	pmic->gpio = of_get_gpio(np, 0);
 	if (pmic->gpio < 0)
 		return pmic->gpio;
 
 	if (!gpio_is_valid(pmic->gpio))
 		return -EINVAL;
 
-	ret = gpio_request_one(pmic->gpio, GPIOF_IN, "pmic");
+	ret = devm_gpio_request_one(dev, pmic->gpio, GPIOF_IN, "pmic");
 	if (ret < 0) {
 		dev_err(dev, "failed to request gpio%d\n", pmic->gpio);
 		return ret;
@@ -309,7 +298,6 @@ static int hi6421_spmi_pmic_probe(struct spmi_device *pdev)
 
 	pmic->irq = gpio_to_irq(pmic->gpio);
 
-	/* mask && clear IRQ status */
 	hi6421_spmi_pmic_irq_prc(pmic);
 
 	pmic->irqs = devm_kzalloc(dev, pmic->irqnum * sizeof(int), GFP_KERNEL);
@@ -321,27 +309,27 @@ static int hi6421_spmi_pmic_probe(struct spmi_device *pdev)
 	if (!pmic->domain) {
 		dev_err(dev, "failed irq domain add simple!\n");
 		ret = -ENODEV;
-		goto irq_domain;
+		goto irq_malloc;
 	}
 
 	for (i = 0; i < pmic->irqnum; i++) {
 		virq = irq_create_mapping(pmic->domain, i);
-		if (virq == NO_IRQ) {
-			pr_debug("Failed mapping hwirq\n");
+		if (!virq) {
+			dev_err(dev, "Failed mapping hwirq\n");
 			ret = -ENOSPC;
-			goto irq_create_mapping;
+			goto irq_malloc;
 		}
 		pmic->irqs[i] = virq;
-		pr_info("[%s]. pmic->irqs[%d] = %d\n", __func__, i, pmic->irqs[i]);
+		dev_dbg(dev, "%s: pmic->irqs[%d] = %d\n",
+			__func__, i, pmic->irqs[i]);
 	}
 
 	ret = request_threaded_irq(pmic->irq, hi6421_spmi_irq_handler, NULL,
 				   IRQF_TRIGGER_LOW | IRQF_SHARED | IRQF_NO_SUSPEND,
 				   "pmic", pmic);
 	if (ret < 0) {
-		dev_err(dev, "could not claim pmic %d\n", ret);
-		ret = -ENODEV;
-		goto request_theaded_irq;
+		dev_err(dev, "could not claim pmic IRQ: error %d\n", ret);
+		goto irq_malloc;
 	}
 
 	dev_set_drvdata(&pdev->dev, pmic);
@@ -355,18 +343,14 @@ static int hi6421_spmi_pmic_probe(struct spmi_device *pdev)
 	ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE,
 				   hi6421v600_devs, ARRAY_SIZE(hi6421v600_devs),
 				   NULL, 0, NULL);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to add child devices: %d\n", ret);
-		return ret;
-	}
+	if (!ret)
+		return 0;
 
-	return 0;
+	dev_err(dev, "Failed to add child devices: %d\n", ret);
 
-request_theaded_irq:
-irq_create_mapping:
-irq_domain:
 irq_malloc:
-	gpio_free(pmic->gpio);
+	free_irq(pmic->irq, pmic);
+
 	return ret;
 }
 
@@ -375,8 +359,6 @@ static void hi6421_spmi_pmic_remove(struct spmi_device *pdev)
 	struct hi6421_spmi_pmic *pmic = dev_get_drvdata(&pdev->dev);
 
 	free_irq(pmic->irq, pmic);
-	gpio_free(pmic->gpio);
-	devm_kfree(&pdev->dev, pmic);
 }
 
 static const struct of_device_id pmic_spmi_id_table[] = {
diff --git a/include/linux/mfd/hi6421-spmi-pmic.h b/include/linux/mfd/hi6421-spmi-pmic.h
index aeff96c4a37e..ff3adfa7b3ec 100644
--- a/include/linux/mfd/hi6421-spmi-pmic.h
+++ b/include/linux/mfd/hi6421-spmi-pmic.h
@@ -36,16 +36,17 @@ struct hi6421_spmi_pmic {
 	int					irq;
 	int					gpio;
 	unsigned int				*irqs;
+
 	int					irqnum;
 	int					irqarray;
-
-	struct hi6421_spmi_irq_mask_info	irq_mask_addr;
-	struct hi6421_spmi_irq_info		irq_addr;
+	int					irq_mask_addr;
+	int					irq_addr;
 };
 
-u32 hi6421_spmi_pmic_read(struct hi6421_spmi_pmic *pmic, int reg);
-void hi6421_spmi_pmic_write(struct hi6421_spmi_pmic *pmic, int reg, u32 val);
-void hi6421_spmi_pmic_rmw(struct hi6421_spmi_pmic *pmic, int reg, u32 mask, u32 bits);
+int hi6421_spmi_pmic_read(struct hi6421_spmi_pmic *pmic, int reg);
+int hi6421_spmi_pmic_write(struct hi6421_spmi_pmic *pmic, int reg, u32 val);
+int hi6421_spmi_pmic_rmw(struct hi6421_spmi_pmic *pmic, int reg,
+			 u32 mask, u32 bits);
 
 enum hi6421_spmi_pmic_irq_list {
 	OTMP = 0,
-- 
2.26.2

