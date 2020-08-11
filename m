Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDEAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0D532076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597160665;
	bh=DlT77wYfZEkXCpEo/mV39sgZ0LMRE12RPy9nq0tRl58=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=OQ+8QoPtw7ETNpQ7+5PueLNGbjDdbu4pAXqoDmBW3BHiXYMOVhzfAkk5xKKHqDLMV
	 MQvuBYKYabATEZ8pNGsitB7kFPECOa39AzQvb2WRsk9vblG1VaMwlob9MdDrqPsh7A
	 iyftKewCb9vNKPV68yr5Yd7Znw9IZyuy+ekYybT8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbgHKPoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:44:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728911AbgHKPmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:42:04 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58D5D208B3;
        Tue, 11 Aug 2020 15:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597160523;
        bh=DlT77wYfZEkXCpEo/mV39sgZ0LMRE12RPy9nq0tRl58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J5jbBzy3gc2gaIsTT/Xse2T4GLE4o9AHMEqRUTekXMMSjdZgCHybW8Q8XuNxBO2Rp
         bFy6rbzOIyJn8O0LQPe8P4aF8BKo/xHn2qRznMsH0wn/QUxDYIRr7NAsSszhsuQoWd
         foqhxKiyQjMXRMyEyxaJ4gToI/CgAP1UFdxoIPCw=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5WPZ-004bmV-Gr; Tue, 11 Aug 2020 17:42:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 07/33] mfd: hisi_pmic_spmi: get rid of the static vars
Date:   Tue, 11 Aug 2020 17:41:33 +0200
Message-Id: <e0be37a457f17504b9362f52dbb9e83786b5ee32.1597160086.git.mchehab+huawei@kernel.org>
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

There are several static vars inside this driver.

Get rid of them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/mfd/hisi_pmic_spmi.c  | 100 +++++++++++-----------------------
 include/linux/mfd/hisi_pmic.h |   2 +
 2 files changed, 34 insertions(+), 68 deletions(-)

diff --git a/drivers/mfd/hisi_pmic_spmi.c b/drivers/mfd/hisi_pmic_spmi.c
index 8b87d48b88b5..0986e24ad304 100644
--- a/drivers/mfd/hisi_pmic_spmi.c
+++ b/drivers/mfd/hisi_pmic_spmi.c
@@ -52,10 +52,7 @@
 /*define the first group interrupt register number*/
 #define HISI_PMIC_FIRST_GROUP_INT_NUM        2
 
-static struct bit_info g_pmic_vbus = {0};
-static struct hisi_pmic *g_pmic;
-static unsigned int g_extinterrupt_flag  = 0;
-static struct of_device_id of_hisi_pmic_match_tbl[] = {
+static const struct of_device_id of_hisi_pmic_match_tbl[] = {
 	{
 		.compatible = "hisilicon-hisi-pmic-spmi",
 	},
@@ -73,12 +70,7 @@ u32 hisi_pmic_read(struct hisi_pmic *pmic, int reg)
 	u8 read_value = 0;
 	struct spmi_device *pdev;
 
-	if (!g_pmic) {
-		pr_err("%s: g_pmic is NULL\n", __func__);
-		return 0;
-	}
-
-	pdev = to_spmi_device(g_pmic->dev);
+	pdev = to_spmi_device(pmic->dev);
 	if (!pdev) {
 		pr_err("%s: pdev get failed!\n", __func__);
 		return 0;
@@ -98,12 +90,7 @@ void hisi_pmic_write(struct hisi_pmic *pmic, int reg, u32 val)
 	u32 ret;
 	struct spmi_device *pdev;
 
-	if (!g_pmic) {
-		pr_err("%s: g_pmic is NULL\n", __func__);
-		return;
-	}
-
-	pdev = to_spmi_device(g_pmic->dev);
+	pdev = to_spmi_device(pmic->dev);
 	if (!pdev) {
 		pr_err("%s: pdev get failed!\n", __func__);
 		return;
@@ -122,16 +109,11 @@ void hisi_pmic_rmw(struct hisi_pmic *pmic, int reg, u32 mask, u32 bits)
 	u32 data;
 	unsigned long flags;
 
-	if (!g_pmic) {
-		pr_err("%s: g_pmic is NULL\n", __func__);
-		return;
-	}
-
-	spin_lock_irqsave(&g_pmic->lock, flags);
+	spin_lock_irqsave(&pmic->lock, flags);
 	data = hisi_pmic_read(pmic, reg) & ~mask;
 	data |= mask & bits;
 	hisi_pmic_write(pmic, reg, data);
-	spin_unlock_irqrestore(&g_pmic->lock, flags);
+	spin_unlock_irqrestore(&pmic->lock, flags);
 }
 EXPORT_SYMBOL(hisi_pmic_rmw);
 
@@ -142,13 +124,13 @@ static irqreturn_t hisi_irq_handler(int irq, void *data)
 	int i, offset;
 
 	for (i = 0; i < pmic->irqarray; i++) {
-		pending = hisi_pmic_read(g_pmic, (i + pmic->irq_addr.start_addr));
+		pending = hisi_pmic_read(pmic, (i + pmic->irq_addr.start_addr));
 		pending &= HISI_MASK_FIELD;
 		if (pending != 0) {
 			pr_info("pending[%d]=0x%lx\n\r", i, pending);
 		}
 
-		hisi_pmic_write(g_pmic, (i + pmic->irq_addr.start_addr), pending);
+		hisi_pmic_write(pmic, (i + pmic->irq_addr.start_addr), pending);
 
 		/*solve powerkey order*/
 		if ((HISI_IRQ_KEY_NUM == i) && ((pending & HISI_IRQ_KEY_VALUE) == HISI_IRQ_KEY_VALUE)) {
@@ -164,15 +146,15 @@ static irqreturn_t hisi_irq_handler(int irq, void *data)
 	}
 
 	/*Handle the second group irq if analysis the second group irq from dtsi*/
-	if (1 == g_extinterrupt_flag){
+	if (pmic->g_extinterrupt_flag == 1) {
 		for (i = 0; i < pmic->irqarray1; i++) {
-			pending = hisi_pmic_read(g_pmic, (i + pmic->irq_addr1.start_addr));
+			pending = hisi_pmic_read(pmic, (i + pmic->irq_addr1.start_addr));
 			pending &= HISI_MASK_FIELD;
 			if (pending != 0) {
 				pr_info("pending[%d]=0x%lx\n\r", i, pending);
 			}
 
-			hisi_pmic_write(g_pmic, (i + pmic->irq_addr1.start_addr), pending);
+			hisi_pmic_write(pmic, (i + pmic->irq_addr1.start_addr), pending);
 
 			if (pending) {
 				for_each_set_bit(offset, &pending, HISI_BITS)
@@ -190,25 +172,20 @@ static void hisi_irq_mask(struct irq_data *d)
 	u32 data, offset;
 	unsigned long flags;
 
-	if (NULL == g_pmic) {
-		pr_err(" g_pmic  is NULL\n");
-		return;
-	}
-
 	offset = (irqd_to_hwirq(d) >> 3);
-	if (1==g_extinterrupt_flag){
-		if ( offset < HISI_PMIC_FIRST_GROUP_INT_NUM)
+	if (pmic->g_extinterrupt_flag == 1) {
+		if (offset < HISI_PMIC_FIRST_GROUP_INT_NUM)
 			offset += pmic->irq_mask_addr.start_addr;
 		else/*Change addr when irq num larger than 16 because interrupt addr is nonsequence*/
 			offset = offset+(pmic->irq_mask_addr1.start_addr)-HISI_PMIC_FIRST_GROUP_INT_NUM;
 	}else{
 		offset += pmic->irq_mask_addr.start_addr;
 	}
-	spin_lock_irqsave(&g_pmic->lock, flags);
-	data = hisi_pmic_read(g_pmic, offset);
+	spin_lock_irqsave(&pmic->lock, flags);
+	data = hisi_pmic_read(pmic, offset);
 	data |= (1 << (irqd_to_hwirq(d) & 0x07));
-	hisi_pmic_write(g_pmic, offset, data);
-	spin_unlock_irqrestore(&g_pmic->lock, flags);
+	hisi_pmic_write(pmic, offset, data);
+	spin_unlock_irqrestore(&pmic->lock, flags);
 }
 
 static void hisi_irq_unmask(struct irq_data *d)
@@ -217,25 +194,20 @@ static void hisi_irq_unmask(struct irq_data *d)
 	u32 data, offset;
 	unsigned long flags;
 
-	if (NULL == g_pmic) {
-		pr_err(" g_pmic  is NULL\n");
-		return;
-	}
-
 	offset = (irqd_to_hwirq(d) >> 3);
-	if (1==g_extinterrupt_flag){
-		if ( offset < HISI_PMIC_FIRST_GROUP_INT_NUM)
+	if (pmic->g_extinterrupt_flag == 1) {
+		if (offset < HISI_PMIC_FIRST_GROUP_INT_NUM)
 			offset += pmic->irq_mask_addr.start_addr;
 		else
 			offset = offset+(pmic->irq_mask_addr1.start_addr)-HISI_PMIC_FIRST_GROUP_INT_NUM;
 	}else{
 		offset += pmic->irq_mask_addr.start_addr;
 	}
-	spin_lock_irqsave(&g_pmic->lock, flags);
-	data = hisi_pmic_read(g_pmic, offset);
+	spin_lock_irqsave(&pmic->lock, flags);
+	data = hisi_pmic_read(pmic, offset);
 	data &= ~(1 << (irqd_to_hwirq(d) & 0x07));
-	hisi_pmic_write(g_pmic, offset, data);
-	spin_unlock_irqrestore(&g_pmic->lock, flags);
+	hisi_pmic_write(pmic, offset, data);
+	spin_unlock_irqrestore(&pmic->lock, flags);
 }
 
 static struct irq_chip hisi_pmu_irqchip = {
@@ -305,14 +277,6 @@ static int get_pmic_device_tree_data(struct device_node *np, struct hisi_pmic *p
 		return ret;
 	}
 
-	ret = of_property_read_u32_array(np, "hisilicon,hisi-pmic-vbus",
-						(u32 *)&g_pmic_vbus, 2);
-	if (ret) {
-		pr_err("no hisilicon,hisi-pmic-vbus property\n");
-		ret = -ENODEV;
-		return ret;
-	}
-
 	/*pmic lock*/
 	ret = of_property_read_u32_array(np, "hisilicon,hisi-pmic-lock",
 						(int *)&pmic->normal_lock, 2);
@@ -377,7 +341,7 @@ static int get_pmic_device_tree_data1(struct device_node *np, struct hisi_pmic *
 		return ret;
 	}
 
-	g_extinterrupt_flag = 1;
+	pmic->g_extinterrupt_flag = 1;
 	return ret;
 }/*lint -restore*/
 
@@ -399,13 +363,14 @@ static void hisi_pmic_irq_prc(struct hisi_pmic *pmic)
 static void hisi_pmic_irq1_prc(struct hisi_pmic *pmic)
 {
 	int i;
-	if(1 == g_extinterrupt_flag){
-		for (i = 0 ; i < pmic->irq_mask_addr1.array; i++) {
+	unsigned int pending1;
+
+	if (pmic->g_extinterrupt_flag == 1) {
+		for (i = 0 ; i < pmic->irq_mask_addr1.array; i++)
 			hisi_pmic_write(pmic, pmic->irq_mask_addr1.start_addr + i, HISI_MASK_STATE);
-		}
 
 		for (i = 0 ; i < pmic->irq_addr1.array; i++) {
-			unsigned int pending1 = hisi_pmic_read(pmic, pmic->irq_addr1.start_addr + i);
+			pending1 = hisi_pmic_read(pmic, pmic->irq_addr1.start_addr + i);
 			pr_debug("PMU IRQ address1 value:irq[0x%x] = 0x%x\n", pmic->irq_addr1.start_addr + i, pending1);
 			hisi_pmic_write(pmic, pmic->irq_addr1.start_addr + i, HISI_MASK_STATE);
 		}
@@ -446,11 +411,11 @@ static int hisi_pmic_probe(struct spmi_device *pdev)
 	spin_lock_init(&pmic->lock);
 
 	pmic->dev = dev;
-	g_pmic = pmic;
-	ret = of_property_read_u32_array(np, "hisilicon,pmic_fpga_flag", &fpga_flag, 1);
-	if (ret) {
+	ret = of_property_read_u32_array(np, "hisilicon,pmic_fpga_flag",
+					 &fpga_flag, 1);
+	if (ret)
 		pr_err("no hisilicon,pmic_fpga_flag property set\n");
-	}
+
 	if (PMIC_FPGA_FLAG == fpga_flag) {
 		goto after_irq_register;
 	}
@@ -521,7 +486,6 @@ static int hisi_pmic_probe(struct spmi_device *pdev)
 irq_domain:
 irq_malloc:
 	gpio_free(pmic->gpio);
-	g_pmic = NULL;
 	return ret;
 }
 
diff --git a/include/linux/mfd/hisi_pmic.h b/include/linux/mfd/hisi_pmic.h
index c3f6e59e2b7d..b387575fb43c 100644
--- a/include/linux/mfd/hisi_pmic.h
+++ b/include/linux/mfd/hisi_pmic.h
@@ -71,6 +71,8 @@ struct hisi_pmic {
 	struct irq_info irq_addr1;
 	struct write_lock normal_lock;
 	struct write_lock debug_lock;
+
+	unsigned int g_extinterrupt_flag;
 };
 
 u32 hisi_pmic_read(struct hisi_pmic *pmic, int reg);
-- 
2.26.2

