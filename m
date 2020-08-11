Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D802AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A37AE2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597160611;
	bh=gEb1G28gJ+Jg8dFAzG4p9Ce5zgA3XT3ySkFyDjbvEQ4=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=WIl9ZOw3FTEkdo6hHfF9Vll9LZZQyEsjrKa/WcYUCufIm63zIWFhQGGdpBti8gxTj
	 QdoWD3Kw2C5/ac1hm1Zwxv/MO50isxksnXoXBsmbEGfvrQgcte2M2zO8TB6R3PdclG
	 6FmvJ1f8Shn0FQithdIrRJa6/OtckxGFT0NAqhzw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgHKPnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:43:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728994AbgHKPmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:42:07 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A268022BF3;
        Tue, 11 Aug 2020 15:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597160524;
        bh=gEb1G28gJ+Jg8dFAzG4p9Ce5zgA3XT3ySkFyDjbvEQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yGAU4iJptErFmgC+vE3PuaS9PXGYfKu16j8lKznZt75SCKHywea/I4atb1yTQy6L4
         oQXQXzMqk7m9EE8XOjWH0cexfc6UXLJQBUBvCojrEbpkSHCrZWKpkcAzsgM76QrDea
         z1LhIx1ElnTrwbeq1DdJm/9yHZ7a6vFYjJGtSVFc=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5WPZ-004bmo-MQ; Tue, 11 Aug 2020 17:42:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 13/33] mfd, regulator: coding style fixups at the HiSilicon SPMI PMIC code
Date:   Tue, 11 Aug 2020 17:41:39 +0200
Message-Id: <48367e3e7f97147f93f05110039933cf7aac1d31.1597160086.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597160086.git.mchehab+huawei@kernel.org>
References: <cover.1597160086.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several issues on those drivers related to their
coding style. Solve most of them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/mfd/hisi_pmic_spmi.c            | 126 ++++++++++++------------
 drivers/regulator/hisi_regulator_spmi.c | 110 +++++++++++----------
 include/linux/mfd/hisi_pmic.h           |  18 +---
 3 files changed, 120 insertions(+), 134 deletions(-)

diff --git a/drivers/mfd/hisi_pmic_spmi.c b/drivers/mfd/hisi_pmic_spmi.c
index 0986e24ad304..be42fed16bd2 100644
--- a/drivers/mfd/hisi_pmic_spmi.c
+++ b/drivers/mfd/hisi_pmic_spmi.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device driver for regulators in HISI PMIC IC
  *
@@ -76,7 +77,8 @@ u32 hisi_pmic_read(struct hisi_pmic *pmic, int reg)
 		return 0;
 	}
 
-	ret = spmi_ext_register_readl(pdev, reg, (unsigned char*)&read_value, 1);/*lint !e734 !e732 */
+	ret = spmi_ext_register_readl(pdev, reg,
+				      (unsigned char *)&read_value, 1);
 	if (ret) {
 		pr_err("%s: spmi_ext_register_readl failed!\n", __func__);
 		return 0;
@@ -96,7 +98,7 @@ void hisi_pmic_write(struct hisi_pmic *pmic, int reg, u32 val)
 		return;
 	}
 
-	ret = spmi_ext_register_writel(pdev, reg, (unsigned char*)&val, 1);/*lint !e734 !e732 */
+	ret = spmi_ext_register_writel(pdev, reg, (unsigned char *)&val, 1);
 	if (ret) {
 		pr_err("%s: spmi_ext_register_writel failed!\n", __func__);
 		return;
@@ -126,14 +128,13 @@ static irqreturn_t hisi_irq_handler(int irq, void *data)
 	for (i = 0; i < pmic->irqarray; i++) {
 		pending = hisi_pmic_read(pmic, (i + pmic->irq_addr.start_addr));
 		pending &= HISI_MASK_FIELD;
-		if (pending != 0) {
-			pr_info("pending[%d]=0x%lx\n\r", i, pending);
-		}
+		if (pending != 0)
+			pr_debug("pending[%d]=0x%lx\n\r", i, pending);
 
 		hisi_pmic_write(pmic, (i + pmic->irq_addr.start_addr), pending);
 
-		/*solve powerkey order*/
-		if ((HISI_IRQ_KEY_NUM == i) && ((pending & HISI_IRQ_KEY_VALUE) == HISI_IRQ_KEY_VALUE)) {
+		/* solve powerkey order */
+		if ((i == HISI_IRQ_KEY_NUM) && ((pending & HISI_IRQ_KEY_VALUE) == HISI_IRQ_KEY_VALUE)) {
 			generic_handle_irq(pmic->irqs[HISI_IRQ_KEY_DOWN]);
 			generic_handle_irq(pmic->irqs[HISI_IRQ_KEY_UP]);
 			pending &= (~HISI_IRQ_KEY_VALUE);
@@ -141,7 +142,7 @@ static irqreturn_t hisi_irq_handler(int irq, void *data)
 
 		if (pending) {
 			for_each_set_bit(offset, &pending, HISI_BITS)
-				generic_handle_irq(pmic->irqs[offset + i * HISI_BITS]);/*lint !e679 */
+				generic_handle_irq(pmic->irqs[offset + i * HISI_BITS]);
 		}
 	}
 
@@ -150,16 +151,16 @@ static irqreturn_t hisi_irq_handler(int irq, void *data)
 		for (i = 0; i < pmic->irqarray1; i++) {
 			pending = hisi_pmic_read(pmic, (i + pmic->irq_addr1.start_addr));
 			pending &= HISI_MASK_FIELD;
-			if (pending != 0) {
-				pr_info("pending[%d]=0x%lx\n\r", i, pending);
-			}
+			if (pending != 0)
+				pr_debug("pending[%d]=0x%lx\n\r", i, pending);
 
 			hisi_pmic_write(pmic, (i + pmic->irq_addr1.start_addr), pending);
 
-			if (pending) {
-				for_each_set_bit(offset, &pending, HISI_BITS)
-					generic_handle_irq(pmic->irqs[offset + (i+HISI_PMIC_FIRST_GROUP_INT_NUM) * HISI_BITS]);/*lint !e679 */
-			}
+			if (!pending)
+				continue;
+
+			for_each_set_bit(offset, &pending, HISI_BITS)
+				generic_handle_irq(pmic->irqs[offset + (i + HISI_PMIC_FIRST_GROUP_INT_NUM) * HISI_BITS]);
 		}
 	}
 
@@ -174,11 +175,16 @@ static void hisi_irq_mask(struct irq_data *d)
 
 	offset = (irqd_to_hwirq(d) >> 3);
 	if (pmic->g_extinterrupt_flag == 1) {
-		if (offset < HISI_PMIC_FIRST_GROUP_INT_NUM)
+		if (offset < HISI_PMIC_FIRST_GROUP_INT_NUM) {
 			offset += pmic->irq_mask_addr.start_addr;
-		else/*Change addr when irq num larger than 16 because interrupt addr is nonsequence*/
-			offset = offset+(pmic->irq_mask_addr1.start_addr)-HISI_PMIC_FIRST_GROUP_INT_NUM;
-	}else{
+		} else {
+			/*
+			 * Change addr when irq num larger than 16 because
+			 * interrupt addr is nonsequence
+			 */
+			offset = offset + (pmic->irq_mask_addr1.start_addr) - HISI_PMIC_FIRST_GROUP_INT_NUM;
+		}
+	} else {
 		offset += pmic->irq_mask_addr.start_addr;
 	}
 	spin_lock_irqsave(&pmic->lock, flags);
@@ -199,8 +205,8 @@ static void hisi_irq_unmask(struct irq_data *d)
 		if (offset < HISI_PMIC_FIRST_GROUP_INT_NUM)
 			offset += pmic->irq_mask_addr.start_addr;
 		else
-			offset = offset+(pmic->irq_mask_addr1.start_addr)-HISI_PMIC_FIRST_GROUP_INT_NUM;
-	}else{
+			offset = offset + (pmic->irq_mask_addr1.start_addr) - HISI_PMIC_FIRST_GROUP_INT_NUM;
+	} else {
 		offset += pmic->irq_mask_addr.start_addr;
 	}
 	spin_lock_irqsave(&pmic->lock, flags);
@@ -219,7 +225,7 @@ static struct irq_chip hisi_pmu_irqchip = {
 };
 
 static int hisi_irq_map(struct irq_domain *d, unsigned int virq,
-			  irq_hw_number_t hw)
+			irq_hw_number_t hw)
 {
 	struct hisi_pmic *pmic = d->host_data;
 
@@ -231,19 +237,18 @@ static int hisi_irq_map(struct irq_domain *d, unsigned int virq,
 	return 0;
 }
 
-static struct irq_domain_ops hisi_domain_ops = {
+static const struct irq_domain_ops hisi_domain_ops = {
 	.map	= hisi_irq_map,
 	.xlate	= irq_domain_xlate_twocell,
 };
 
-/*lint -e570 -e64*/
 static int get_pmic_device_tree_data(struct device_node *np, struct hisi_pmic *pmic)
 {
 	int ret = 0;
 
 	/*get pmic irq num*/
 	ret = of_property_read_u32_array(np, "hisilicon,hisi-pmic-irq-num",
-						&(pmic->irqnum), 1);
+					 &pmic->irqnum, 1);
 	if (ret) {
 		pr_err("no hisilicon,hisi-pmic-irq-num property set\n");
 		ret = -ENODEV;
@@ -252,7 +257,7 @@ static int get_pmic_device_tree_data(struct device_node *np, struct hisi_pmic *p
 
 	/*get pmic irq array number*/
 	ret = of_property_read_u32_array(np, "hisilicon,hisi-pmic-irq-array",
-						&(pmic->irqarray), 1);
+					 &pmic->irqarray, 1);
 	if (ret) {
 		pr_err("no hisilicon,hisi-pmic-irq-array property set\n");
 		ret = -ENODEV;
@@ -261,7 +266,7 @@ static int get_pmic_device_tree_data(struct device_node *np, struct hisi_pmic *p
 
 	/*SOC_PMIC_IRQ_MASK_0_ADDR*/
 	ret = of_property_read_u32_array(np, "hisilicon,hisi-pmic-irq-mask-addr",
-						(int *)&pmic->irq_mask_addr, 2);
+					 (int *)&pmic->irq_mask_addr, 2);
 	if (ret) {
 		pr_err("no hisilicon,hisi-pmic-irq-mask-addr property set\n");
 		ret = -ENODEV;
@@ -270,7 +275,7 @@ static int get_pmic_device_tree_data(struct device_node *np, struct hisi_pmic *p
 
 	/*SOC_PMIC_IRQ0_ADDR*/
 	ret = of_property_read_u32_array(np, "hisilicon,hisi-pmic-irq-addr",
-						(int *)&pmic->irq_addr, 2);
+					 (int *)&pmic->irq_addr, 2);
 	if (ret) {
 		pr_err("no hisilicon,hisi-pmic-irq-addr property set\n");
 		ret = -ENODEV;
@@ -279,7 +284,7 @@ static int get_pmic_device_tree_data(struct device_node *np, struct hisi_pmic *p
 
 	/*pmic lock*/
 	ret = of_property_read_u32_array(np, "hisilicon,hisi-pmic-lock",
-						(int *)&pmic->normal_lock, 2);
+					 (int *)&pmic->normal_lock, 2);
 	if (ret) {
 		pr_err("no hisilicon,hisi-pmic-lock property set\n");
 		ret = -ENODEV;
@@ -288,7 +293,7 @@ static int get_pmic_device_tree_data(struct device_node *np, struct hisi_pmic *p
 
 	/*pmic debug lock*/
 	ret = of_property_read_u32_array(np, "hisilicon,hisi-pmic-debug-lock",
-						(int *)&pmic->debug_lock, 2);
+					 (int *)&pmic->debug_lock, 2);
 	if (ret) {
 		pr_err("no hisilicon,hisi-pmic-debug-lock property set\n");
 		ret = -ENODEV;
@@ -296,17 +301,15 @@ static int get_pmic_device_tree_data(struct device_node *np, struct hisi_pmic *p
 	}
 
 	return ret;
-}/*lint -restore*/
+}
 
-
-/*lint -e570 -e64*/
 static int get_pmic_device_tree_data1(struct device_node *np, struct hisi_pmic *pmic)
 {
 	int ret = 0;
 
 	/*get pmic irq num*/
 	ret = of_property_read_u32_array(np, "hisilicon,hisi-pmic-irq-num1",
-						&(pmic->irqnum1), 1);
+					 &pmic->irqnum1, 1);
 	if (ret) {
 		pr_err("no hisilicon,hisi-pmic-irq-num1 property set\n");
 		ret = -ENODEV;
@@ -316,7 +319,7 @@ static int get_pmic_device_tree_data1(struct device_node *np, struct hisi_pmic *
 
 	/*get pmic irq array number*/
 	ret = of_property_read_u32_array(np, "hisilicon,hisi-pmic-irq-array1",
-						&(pmic->irqarray1), 1);
+					 &pmic->irqarray1, 1);
 	if (ret) {
 		pr_err("no hisilicon,hisi-pmic-irq-array1 property set\n");
 		ret = -ENODEV;
@@ -325,7 +328,7 @@ static int get_pmic_device_tree_data1(struct device_node *np, struct hisi_pmic *
 
 	/*SOC_PMIC_IRQ_MASK_0_ADDR*/
 	ret = of_property_read_u32_array(np, "hisilicon,hisi-pmic-irq-mask-addr1",
-						(int *)&pmic->irq_mask_addr1, 2);
+					 (int *)&pmic->irq_mask_addr1, 2);
 	if (ret) {
 		pr_err("no hisilicon,hisi-pmic-irq-mask-addr1 property set\n");
 		ret = -ENODEV;
@@ -334,7 +337,7 @@ static int get_pmic_device_tree_data1(struct device_node *np, struct hisi_pmic *
 
 	/*SOC_PMIC_IRQ0_ADDR*/
 	ret = of_property_read_u32_array(np, "hisilicon,hisi-pmic-irq-addr1",
-						(int *)&pmic->irq_addr1, 2);
+					 (int *)&pmic->irq_addr1, 2);
 	if (ret) {
 		pr_err("no hisilicon,hisi-pmic-irq-addr1 property set\n");
 		ret = -ENODEV;
@@ -343,21 +346,22 @@ static int get_pmic_device_tree_data1(struct device_node *np, struct hisi_pmic *
 
 	pmic->g_extinterrupt_flag = 1;
 	return ret;
-}/*lint -restore*/
+}
 
 static void hisi_pmic_irq_prc(struct hisi_pmic *pmic)
 {
 	int i;
-	for (i = 0 ; i < pmic->irq_mask_addr.array; i++) {
+
+	for (i = 0 ; i < pmic->irq_mask_addr.array; i++)
 		hisi_pmic_write(pmic, pmic->irq_mask_addr.start_addr + i, HISI_MASK_STATE);
-	}
 
 	for (i = 0 ; i < pmic->irq_addr.array; i++) {
 		unsigned int pending = hisi_pmic_read(pmic, pmic->irq_addr.start_addr + i);
-		pr_debug("PMU IRQ address value:irq[0x%x] = 0x%x\n", pmic->irq_addr.start_addr + i, pending);
+
+		pr_debug("PMU IRQ address value:irq[0x%x] = 0x%x\n",
+			 pmic->irq_addr.start_addr + i, pending);
 		hisi_pmic_write(pmic, pmic->irq_addr.start_addr + i, HISI_MASK_STATE);
 	}
-
 }
 
 static void hisi_pmic_irq1_prc(struct hisi_pmic *pmic)
@@ -371,7 +375,10 @@ static void hisi_pmic_irq1_prc(struct hisi_pmic *pmic)
 
 		for (i = 0 ; i < pmic->irq_addr1.array; i++) {
 			pending1 = hisi_pmic_read(pmic, pmic->irq_addr1.start_addr + i);
-			pr_debug("PMU IRQ address1 value:irq[0x%x] = 0x%x\n", pmic->irq_addr1.start_addr + i, pending1);
+
+			pr_debug("PMU IRQ address1 value:irq[0x%x] = 0x%x\n",
+				 pmic->irq_addr1.start_addr + i, pending1);
+
 			hisi_pmic_write(pmic, pmic->irq_addr1.start_addr + i, HISI_MASK_STATE);
 		}
 	}
@@ -389,23 +396,20 @@ static int hisi_pmic_probe(struct spmi_device *pdev)
 	unsigned int virq;
 
 	pmic = devm_kzalloc(dev, sizeof(*pmic), GFP_KERNEL);
-	if (!pmic) {
-		dev_err(dev, "cannot allocate hisi_pmic device info\n");
+	if (!pmic)
 		return -ENOMEM;
-	}
 
 	/*TODO: get pmic dts info*/
 	ret = get_pmic_device_tree_data(np, pmic);
 	if (ret) {
-		dev_err(&pdev->dev, "Error reading hisi pmic dts \n");
+		dev_err(&pdev->dev, "Error reading hisi pmic dts\n");
 		return ret;
 	}
 
 	/*get pmic dts the second group irq*/
 	ret = get_pmic_device_tree_data1(np, pmic);
-	if (ret) {
+	if (ret)
 		dev_err(&pdev->dev, "the platform don't support ext-interrupt.\n");
-	}
 
 	/* TODO: get and enable clk request */
 	spin_lock_init(&pmic->lock);
@@ -416,9 +420,8 @@ static int hisi_pmic_probe(struct spmi_device *pdev)
 	if (ret)
 		pr_err("no hisilicon,pmic_fpga_flag property set\n");
 
-	if (PMIC_FPGA_FLAG == fpga_flag) {
+	if (fpga_flag == PMIC_FPGA_FLAG)
 		goto after_irq_register;
-	}
 
 	pmic->gpio = of_get_gpio_flags(np, 0, &flags);
 	if (pmic->gpio < 0)
@@ -442,12 +445,9 @@ static int hisi_pmic_probe(struct spmi_device *pdev)
 
 	pmic->irqnum += pmic->irqnum1;
 
-	pmic->irqs = (unsigned int *)devm_kmalloc(dev, pmic->irqnum * sizeof(int), GFP_KERNEL);
-	if (!pmic->irqs) {
-		pr_err("%s:Failed to alloc memory for pmic irq number!\n", __func__);
+	pmic->irqs = devm_kzalloc(dev, pmic->irqnum * sizeof(int), GFP_KERNEL);
+	if (!pmic->irqs)
 		goto irq_malloc;
-	}
-	memset(pmic->irqs, 0, pmic->irqnum);
 
 	pmic->domain = irq_domain_add_simple(np, pmic->irqnum, 0,
 					     &hisi_domain_ops, pmic);
@@ -469,7 +469,7 @@ static int hisi_pmic_probe(struct spmi_device *pdev)
 	}
 
 	ret = request_threaded_irq(pmic->irq, hisi_irq_handler, NULL,
-				IRQF_TRIGGER_LOW | IRQF_SHARED | IRQF_NO_SUSPEND,
+				   IRQF_TRIGGER_LOW | IRQF_SHARED | IRQF_NO_SUSPEND,
 				   "pmic", pmic);
 	if (ret < 0) {
 		dev_err(dev, "could not claim pmic %d\n", ret);
@@ -480,7 +480,6 @@ static int hisi_pmic_probe(struct spmi_device *pdev)
 after_irq_register:
 	return 0;
 
-
 request_theaded_irq:
 irq_create_mapping:
 irq_domain:
@@ -491,19 +490,18 @@ static int hisi_pmic_probe(struct spmi_device *pdev)
 
 static void hisi_pmic_remove(struct spmi_device *pdev)
 {
-
 	struct hisi_pmic *pmic = dev_get_drvdata(&pdev->dev);
 
 	free_irq(pmic->irq, pmic);
 	gpio_free(pmic->gpio);
 	devm_kfree(&pdev->dev, pmic);
-
 }
+
 static int hisi_pmic_suspend(struct device *dev, pm_message_t state)
 {
 	struct hisi_pmic *pmic = dev_get_drvdata(dev);
 
-	if (NULL == pmic) {
+	if (!pmic) {
 		pr_err("%s:pmic is NULL\n", __func__);
 		return -ENOMEM;
 	}
@@ -512,13 +510,13 @@ static int hisi_pmic_suspend(struct device *dev, pm_message_t state)
 	pr_info("%s:-\n", __func__);
 
 	return 0;
-}/*lint !e715 */
+}
 
 static int hisi_pmic_resume(struct device *dev)
 {
 	struct hisi_pmic *pmic = dev_get_drvdata(dev);
 
-	if (NULL == pmic) {
+	if (!pmic) {
 		pr_err("%s:pmic is NULL\n", __func__);
 		return -ENOMEM;
 	}
@@ -552,10 +550,8 @@ static void __exit hisi_pmic_exit(void)
 	spmi_driver_unregister(&hisi_pmic_driver);
 }
 
-
 subsys_initcall_sync(hisi_pmic_init);
 module_exit(hisi_pmic_exit);
 
 MODULE_DESCRIPTION("PMIC driver");
 MODULE_LICENSE("GPL v2");
-
diff --git a/drivers/regulator/hisi_regulator_spmi.c b/drivers/regulator/hisi_regulator_spmi.c
index 904cb64b1dcd..5f6e4ba4b99e 100644
--- a/drivers/regulator/hisi_regulator_spmi.c
+++ b/drivers/regulator/hisi_regulator_spmi.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Device driver for regulators in Hisi IC
  *
@@ -52,7 +53,7 @@ struct hisi_regulator {
 	u32 off_on_delay;
 	u32 eco_uA;
 	struct regulator_desc rdesc;
-	int (*dt_parse)(struct hisi_regulator *, struct spmi_device *);
+	int (*dt_parse)(struct hisi_regulator *reg, struct spmi_device *spmi);
 };
 
 static DEFINE_MUTEX(enable_mutex);
@@ -77,8 +78,9 @@ static int hisi_regulator_is_enabled(struct regulator_dev *dev)
 	struct hisi_pmic *pmic = rdev_to_pmic(dev);
 
 	reg_val = hisi_pmic_read(pmic, sreg->register_info.ctrl_reg);
-	pr_debug("<[%s]: ctrl_reg=0x%x,enable_state=%d>\n", __func__, sreg->register_info.ctrl_reg,\
-			(reg_val & sreg->register_info.enable_mask));
+	pr_debug("<[%s]: ctrl_reg=0x%x,enable_state=%d>\n",
+		 __func__, sreg->register_info.ctrl_reg,
+		(reg_val & sreg->register_info.enable_mask));
 
 	return ((reg_val & sreg->register_info.enable_mask) != 0);
 }
@@ -98,14 +100,13 @@ static int hisi_regulator_enable(struct regulator_dev *dev)
 	usleep_range(HISI_REGS_ENA_PROTECT_TIME,
 		     HISI_REGS_ENA_PROTECT_TIME + 1000);
 
-
-
 	/* set enable register */
 	hisi_pmic_rmw(pmic, sreg->register_info.ctrl_reg,
-				sreg->register_info.enable_mask,
+		      sreg->register_info.enable_mask,
 				sreg->register_info.enable_mask);
-	pr_debug("<[%s]: ctrl_reg=0x%x,enable_mask=0x%x>\n", __func__, sreg->register_info.ctrl_reg,\
-			sreg->register_info.enable_mask);
+	pr_debug("<[%s]: ctrl_reg=0x%x,enable_mask=0x%x>\n",
+		 __func__, sreg->register_info.ctrl_reg,
+		 sreg->register_info.enable_mask);
 
 	mutex_unlock(&enable_mutex);
 
@@ -119,7 +120,7 @@ static int hisi_regulator_disable(struct regulator_dev *dev)
 
 	/* set enable register to 0 */
 	hisi_pmic_rmw(pmic, sreg->register_info.ctrl_reg,
-				sreg->register_info.enable_mask, 0);
+		      sreg->register_info.enable_mask, 0);
 
 	return 0;
 }
@@ -132,7 +133,8 @@ static int hisi_regulator_get_voltage(struct regulator_dev *dev)
 
 	/* get voltage selector */
 	reg_val = hisi_pmic_read(pmic, sreg->register_info.vset_reg);
-	pr_debug("<[%s]: vset_reg=0x%x>\n", __func__, sreg->register_info.vset_reg);
+	pr_debug("<[%s]: vset_reg=0x%x>\n",
+		 __func__, sreg->register_info.vset_reg);
 
 	selector = (reg_val & sreg->register_info.vset_mask) >>
 				(ffs(sreg->register_info.vset_mask) - 1);
@@ -141,7 +143,7 @@ static int hisi_regulator_get_voltage(struct regulator_dev *dev)
 }
 
 static int hisi_regulator_set_voltage(struct regulator_dev *dev,
-				int min_uV, int max_uV, unsigned *selector)
+				      int min_uV, int max_uV, unsigned int *selector)
 {
 	struct hisi_regulator *sreg = rdev_get_drvdata(dev);
 	struct hisi_pmic *pmic = rdev_to_pmic(dev);
@@ -162,14 +164,14 @@ static int hisi_regulator_set_voltage(struct regulator_dev *dev,
 	*selector = vsel;
 	/* set voltage selector */
 	hisi_pmic_rmw(pmic, sreg->register_info.vset_reg,
-		sreg->register_info.vset_mask,
+		      sreg->register_info.vset_mask,
 		vsel << (ffs(sreg->register_info.vset_mask) - 1));
 
-	pr_debug("<[%s]: vset_reg=0x%x, vset_mask=0x%x, value=0x%x>\n", __func__,\
-			sreg->register_info.vset_reg,\
-			sreg->register_info.vset_mask,\
-			vsel << (ffs(sreg->register_info.vset_mask) - 1)\
-			);
+	pr_debug("<[%s]: vset_reg=0x%x, vset_mask=0x%x, value=0x%x>\n",
+		 __func__,
+		 sreg->register_info.vset_reg,
+		 sreg->register_info.vset_mask,
+		 vsel << (ffs(sreg->register_info.vset_mask) - 1));
 
 	return ret;
 }
@@ -181,10 +183,10 @@ static unsigned int hisi_regulator_get_mode(struct regulator_dev *dev)
 	u32 reg_val;
 
 	reg_val = hisi_pmic_read(pmic, sreg->register_info.ctrl_reg);
-	pr_debug("<[%s]: reg_val=%d, ctrl_reg=0x%x, eco_mode_mask=0x%x>\n", __func__, reg_val,\
-			sreg->register_info.ctrl_reg,\
-			sreg->register_info.eco_mode_mask\
-		   );
+	pr_debug("<[%s]: reg_val=%d, ctrl_reg=0x%x, eco_mode_mask=0x%x>\n",
+		 __func__, reg_val,
+		sreg->register_info.ctrl_reg,
+		sreg->register_info.eco_mode_mask);
 
 	if (reg_val & sreg->register_info.eco_mode_mask)
 		return REGULATOR_MODE_IDLE;
@@ -193,7 +195,7 @@ static unsigned int hisi_regulator_get_mode(struct regulator_dev *dev)
 }
 
 static int hisi_regulator_set_mode(struct regulator_dev *dev,
-						unsigned int mode)
+				   unsigned int mode)
 {
 	struct hisi_regulator *sreg = rdev_get_drvdata(dev);
 	struct hisi_pmic *pmic = rdev_to_pmic(dev);
@@ -212,31 +214,31 @@ static int hisi_regulator_set_mode(struct regulator_dev *dev,
 
 	/* set mode */
 	hisi_pmic_rmw(pmic, sreg->register_info.ctrl_reg,
+		      sreg->register_info.eco_mode_mask,
+		eco_mode << (ffs(sreg->register_info.eco_mode_mask) - 1));
+
+	pr_debug("<[%s]: ctrl_reg=0x%x, eco_mode_mask=0x%x, value=0x%x>\n",
+		 __func__,
+		sreg->register_info.ctrl_reg,
 		sreg->register_info.eco_mode_mask,
 		eco_mode << (ffs(sreg->register_info.eco_mode_mask) - 1));
-
-	pr_debug("<[%s]: ctrl_reg=0x%x, eco_mode_mask=0x%x, value=0x%x>\n", __func__,\
-			sreg->register_info.ctrl_reg,\
-			sreg->register_info.eco_mode_mask,\
-			eco_mode << (ffs(sreg->register_info.eco_mode_mask) - 1)\
-		   );
 	return 0;
 }
 
-
-unsigned int hisi_regulator_get_optimum_mode(struct regulator_dev *dev,
-			int input_uV, int output_uV, int load_uA)
+static unsigned int hisi_regulator_get_optimum_mode(struct regulator_dev *dev,
+						    int input_uV, int output_uV,
+						    int load_uA)
 {
 	struct hisi_regulator *sreg = rdev_get_drvdata(dev);
 
-	if ((load_uA == 0) || ((unsigned int)load_uA > sreg->eco_uA))
+	if (load_uA || ((unsigned int)load_uA > sreg->eco_uA))
 		return REGULATOR_MODE_NORMAL;
 	else
 		return REGULATOR_MODE_IDLE;
 }
 
 static int hisi_dt_parse_common(struct hisi_regulator *sreg,
-					struct spmi_device *pdev)
+				struct spmi_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
@@ -246,7 +248,7 @@ static int hisi_dt_parse_common(struct hisi_regulator *sreg,
 
 	/* parse .register_info.ctrl_reg */
 	ret = of_property_read_u32_array(np, "hisilicon,hisi-ctrl",
-						register_info, 3);
+					 register_info, 3);
 	if (ret) {
 		dev_err(dev, "no hisilicon,hisi-ctrl property set\n");
 		goto dt_parse_common_end;
@@ -257,7 +259,7 @@ static int hisi_dt_parse_common(struct hisi_regulator *sreg,
 
 	/* parse .register_info.vset_reg */
 	ret = of_property_read_u32_array(np, "hisilicon,hisi-vset",
-						register_info, 2);
+					 register_info, 2);
 	if (ret) {
 		dev_err(dev, "no hisilicon,hisi-vset property set\n");
 		goto dt_parse_common_end;
@@ -267,7 +269,7 @@ static int hisi_dt_parse_common(struct hisi_regulator *sreg,
 
 	/* parse .off-on-delay */
 	ret = of_property_read_u32(np, "hisilicon,hisi-off-on-delay-us",
-						&sreg->off_on_delay);
+				   &sreg->off_on_delay);
 	if (ret) {
 		dev_err(dev, "no hisilicon,hisi-off-on-delay-us property set\n");
 		goto dt_parse_common_end;
@@ -294,7 +296,7 @@ static int hisi_dt_parse_common(struct hisi_regulator *sreg,
 }
 
 static int hisi_dt_parse_ldo(struct hisi_regulator *sreg,
-				struct spmi_device *pdev)
+			     struct spmi_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
@@ -312,7 +314,7 @@ static int hisi_dt_parse_ldo(struct hisi_regulator *sreg,
 
 	/* alloc space for .volt_table */
 	v_table = devm_kzalloc(dev, sizeof(unsigned int) * rdesc->n_voltages,
-								GFP_KERNEL);
+			       GFP_KERNEL);
 	if (unlikely(!v_table)) {
 		ret = -ENOMEM;
 		dev_err(dev, "no memory for .volt_table\n");
@@ -320,7 +322,7 @@ static int hisi_dt_parse_ldo(struct hisi_regulator *sreg,
 	}
 
 	ret = of_property_read_u32_array(np, "hisilicon,hisi-vset-table",
-						v_table, rdesc->n_voltages);
+					 v_table, rdesc->n_voltages);
 	if (ret) {
 		dev_err(dev, "no hisilicon,hisi-vset-table property set\n");
 		goto dt_parse_ldo_end1;
@@ -362,7 +364,7 @@ static const struct hisi_regulator hisi_regulator_ldo = {
 	.dt_parse = hisi_dt_parse_ldo,
 };
 
-static struct of_device_id of_hisi_regulator_match_tbl[] = {
+static const struct of_device_id of_hisi_regulator_match_tbl[] = {
 	{
 		.compatible = "hisilicon-hisi-ldo",
 		.data = &hisi_regulator_ldo,
@@ -388,14 +390,14 @@ static int hisi_regulator_probe(struct spmi_device *pdev)
 	int ret = 0;
 	/* to check which type of regulator this is */
 	match = of_match_device(of_hisi_regulator_match_tbl, &pdev->dev);
-	if (NULL == match) {
+	if (!match) {
 		pr_err("get hisi regulator fail!\n\r");
 		return -EINVAL;
 	}
 
 	template = match->data;
 	initdata = of_get_regulator_init_data(dev, np, NULL);
-	if (NULL == initdata) {
+	if (!initdata) {
 		pr_err("get regulator init data error !\n");
 		return -EINVAL;
 	}
@@ -404,14 +406,14 @@ static int hisi_regulator_probe(struct spmi_device *pdev)
 	constraint = &initdata->constraints;
 
 	ret = of_property_read_u32_array(np, "hisilicon,valid-modes-mask",
-						&(constraint->valid_modes_mask), 1);
+					 &constraint->valid_modes_mask, 1);
 	if (ret) {
 		pr_err("no hisilicon,valid-modes-mask property set\n");
 		ret = -ENODEV;
 		return ret;
 	}
 	ret = of_property_read_u32_array(np, "hisilicon,valid-idle-mask",
-						&temp_modes, 1);
+					 &temp_modes, 1);
 	if (ret) {
 		pr_err("no hisilicon,valid-modes-mask property set\n");
 		ret = -ENODEV;
@@ -420,18 +422,16 @@ static int hisi_regulator_probe(struct spmi_device *pdev)
 	constraint->valid_ops_mask |= temp_modes;
 
 	sreg = kmemdup(template, sizeof(*sreg), GFP_KERNEL);
-	if (!sreg) {
-		pr_err("template kememdup is fail. \n");
+	if (!sreg)
 		return -ENOMEM;
-	}
+
 	sreg->name = initdata->constraints.name;
 	rdesc = &sreg->rdesc;
 	rdesc->name = sreg->name;
 	rdesc->min_uV = initdata->constraints.min_uV;
 	supplyname = of_get_property(np, "hisilicon,supply_name", NULL);
-	if (supplyname != NULL) {
+	if (supplyname)
 		initdata->supply_regulator = supplyname;
-	}
 
 	/* to parse device tree data for regulator specific */
 	ret = sreg->dt_parse(sreg, pdev);
@@ -454,8 +454,9 @@ static int hisi_regulator_probe(struct spmi_device *pdev)
 		goto hisi_probe_end;
 	}
 
-	pr_debug("[%s]:valid_modes_mask[0x%x], valid_ops_mask[0x%x]\n", rdesc->name,\
-			constraint->valid_modes_mask, constraint->valid_ops_mask);
+	pr_debug("[%s]:valid_modes_mask[0x%x], valid_ops_mask[0x%x]\n",
+		 rdesc->name,
+		 constraint->valid_modes_mask, constraint->valid_ops_mask);
 
 	dev_set_drvdata(dev, rdev);
 hisi_probe_end:
@@ -477,11 +478,12 @@ static void hisi_regulator_remove(struct spmi_device *pdev)
 
 	kfree(sreg);
 }
+
 static int hisi_regulator_suspend(struct device *dev, pm_message_t state)
 {
 	struct hisi_regulator *hisi_regulator = dev_get_drvdata(dev);
 
-	if (NULL == hisi_regulator) {
+	if (!hisi_regulator) {
 		pr_err("%s:regulator is NULL\n", __func__);
 		return -ENOMEM;
 	}
@@ -490,13 +492,13 @@ static int hisi_regulator_suspend(struct device *dev, pm_message_t state)
 	pr_info("%s:-\n", __func__);
 
 	return 0;
-}/*lint !e715 */
+}
 
 static int hisi_regulator_resume(struct device *dev)
 {
 	struct hisi_regulator *hisi_regulator = dev_get_drvdata(dev);
 
-	if (NULL == hisi_regulator) {
+	if (!hisi_regulator) {
 		pr_err("%s:regulator is NULL\n", __func__);
 		return -ENOMEM;
 	}
diff --git a/include/linux/mfd/hisi_pmic.h b/include/linux/mfd/hisi_pmic.h
index b387575fb43c..1f986dd5f31c 100644
--- a/include/linux/mfd/hisi_pmic.h
+++ b/include/linux/mfd/hisi_pmic.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Header file for device driver Hi6421 PMIC
  *
@@ -5,19 +6,6 @@
  * Copyright (C) 2011 Hisilicon.
  *
  * Guodong Xu <guodong.xu@linaro.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #ifndef	__HISI_PMIC_H
@@ -25,12 +13,12 @@
 
 #include <linux/irqdomain.h>
 
-#define HISI_REGS_ENA_PROTECT_TIME	(0) 	/* in microseconds */
+#define HISI_REGS_ENA_PROTECT_TIME	(0)	/* in microseconds */
 #define HISI_ECO_MODE_ENABLE		(1)
 #define HISI_ECO_MODE_DISABLE		(0)
 
 typedef int (*pmic_ocp_callback)(char *);
-extern int hisi_pmic_special_ocp_register(char *power_name, pmic_ocp_callback handler);
+int hisi_pmic_special_ocp_register(char *power_name, pmic_ocp_callback handler);
 
 struct irq_mask_info {
 	int start_addr;
-- 
2.26.2

