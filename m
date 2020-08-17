Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0C5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1477720758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597648341;
	bh=pWwLRKmaSeuvsJZG9VfHjZL1DUJC8ibQUv9suo/dpVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZCi5YUsS5pZpW1GUMjfxehZUk3XX3srvNZ7LYLz+LMIjByqmoZ5z8CJ/DslKdt+xg
	 H3laM9/E0I/eBbfdqoFZA91VkVRTpX/1ZgDuIF/9EJgKdW4pUokj98klQLCEu4HiEE
	 WurkQVagwfgTa2lqBsywtgkPKzM3Ui11SwSofXSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgHQHMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:12:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbgHQHLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:11:23 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65B8E22BF5;
        Mon, 17 Aug 2020 07:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597648277;
        bh=pWwLRKmaSeuvsJZG9VfHjZL1DUJC8ibQUv9suo/dpVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qc0pbdFYqIjlYm9eQknKnyUfpNXRuEcbycN+fdJIfX1LaoNua829+rin22r2xiRM3
         no3+L3SNzztxJcAlcU2Hg5GrqSc9X0lMFuRLP9d5d9vv0FldNiADAj9gbA8BLE7n85
         e4CdJKHHeUMPzGvbngk2ojlz0qBQSzmRQ2TT/U+Q=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k7ZIZ-00Bdjz-I6; Mon, 17 Aug 2020 09:11:15 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH v3 17/44] staging: mfd: hi6421-spmi-pmic: get rid of unused OF properties
Date:   Mon, 17 Aug 2020 09:10:36 +0200
Message-Id: <332f96c178b81bf1e9908a1da2127f043909ae0c.1597647359.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597647359.git.mchehab+huawei@kernel.org>
References: <cover.1597647359.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several OF properties that aren't used by Hikey 970,
and some are not even used inside the driver.

So, drop them, as as this makes easier to document what's
actually used.

If latter needed, those could be re-added later.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 145 +-------------------
 include/linux/mfd/hi6421-spmi-pmic.h        |  14 +-
 2 files changed, 7 insertions(+), 152 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
index 939f7bd5d8ba..f523b2d844b9 100644
--- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
+++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
@@ -49,7 +49,6 @@
 /*#define HISI_NR_IRQ			25*/
 #define HISI_MASK_FIELD		0xFF
 #define HISI_BITS			8
-#define PMIC_FPGA_FLAG          1
 
 /*define the first group interrupt register number*/
 #define HISI_PMIC_FIRST_GROUP_INT_NUM        2
@@ -144,24 +143,6 @@ static irqreturn_t hisi_irq_handler(int irq, void *data)
 		}
 	}
 
-	/*Handle the second group irq if analysis the second group irq from dtsi*/
-	if (pmic->g_extinterrupt_flag == 1) {
-		for (i = 0; i < pmic->irqarray1; i++) {
-			pending = hisi_pmic_read(pmic, (i + pmic->irq_addr1.start_addr));
-			pending &= HISI_MASK_FIELD;
-			if (pending != 0)
-				pr_debug("pending[%d]=0x%lx\n\r", i, pending);
-
-			hisi_pmic_write(pmic, (i + pmic->irq_addr1.start_addr), pending);
-
-			if (!pending)
-				continue;
-
-			for_each_set_bit(offset, &pending, HISI_BITS)
-				generic_handle_irq(pmic->irqs[offset + (i + HISI_PMIC_FIRST_GROUP_INT_NUM) * HISI_BITS]);
-		}
-	}
-
 	return IRQ_HANDLED;
 }
 
@@ -172,19 +153,8 @@ static void hisi_irq_mask(struct irq_data *d)
 	unsigned long flags;
 
 	offset = (irqd_to_hwirq(d) >> 3);
-	if (pmic->g_extinterrupt_flag == 1) {
-		if (offset < HISI_PMIC_FIRST_GROUP_INT_NUM) {
-			offset += pmic->irq_mask_addr.start_addr;
-		} else {
-			/*
-			 * Change addr when irq num larger than 16 because
-			 * interrupt addr is nonsequence
-			 */
-			offset = offset + (pmic->irq_mask_addr1.start_addr) - HISI_PMIC_FIRST_GROUP_INT_NUM;
-		}
-	} else {
-		offset += pmic->irq_mask_addr.start_addr;
-	}
+	offset += pmic->irq_mask_addr.start_addr;
+
 	spin_lock_irqsave(&pmic->lock, flags);
 	data = hisi_pmic_read(pmic, offset);
 	data |= (1 << (irqd_to_hwirq(d) & 0x07));
@@ -199,14 +169,8 @@ static void hisi_irq_unmask(struct irq_data *d)
 	unsigned long flags;
 
 	offset = (irqd_to_hwirq(d) >> 3);
-	if (pmic->g_extinterrupt_flag == 1) {
-		if (offset < HISI_PMIC_FIRST_GROUP_INT_NUM)
-			offset += pmic->irq_mask_addr.start_addr;
-		else
-			offset = offset + (pmic->irq_mask_addr1.start_addr) - HISI_PMIC_FIRST_GROUP_INT_NUM;
-	} else {
-		offset += pmic->irq_mask_addr.start_addr;
-	}
+	offset += pmic->irq_mask_addr.start_addr;
+
 	spin_lock_irqsave(&pmic->lock, flags);
 	data = hisi_pmic_read(pmic, offset);
 	data &= ~(1 << (irqd_to_hwirq(d) & 0x07));
@@ -280,69 +244,6 @@ static int get_pmic_device_tree_data(struct device_node *np, struct hisi_pmic *p
 		return ret;
 	}
 
-	/*pmic lock*/
-	ret = of_property_read_u32_array(np, "hisilicon,hisi-pmic-lock",
-					 (int *)&pmic->normal_lock, 2);
-	if (ret) {
-		pr_err("no hisilicon,hisi-pmic-lock property set\n");
-		ret = -ENODEV;
-		return ret;
-	}
-
-	/*pmic debug lock*/
-	ret = of_property_read_u32_array(np, "hisilicon,hisi-pmic-debug-lock",
-					 (int *)&pmic->debug_lock, 2);
-	if (ret) {
-		pr_err("no hisilicon,hisi-pmic-debug-lock property set\n");
-		ret = -ENODEV;
-		return ret;
-	}
-
-	return ret;
-}
-
-static int get_pmic_device_tree_data1(struct device_node *np, struct hisi_pmic *pmic)
-{
-	int ret = 0;
-
-	/*get pmic irq num*/
-	ret = of_property_read_u32_array(np, "hisilicon,hisi-pmic-irq-num1",
-					 &pmic->irqnum1, 1);
-	if (ret) {
-		pr_err("no hisilicon,hisi-pmic-irq-num1 property set\n");
-		ret = -ENODEV;
-		pmic->irqnum1 = 0;
-		return ret;
-	}
-
-	/*get pmic irq array number*/
-	ret = of_property_read_u32_array(np, "hisilicon,hisi-pmic-irq-array1",
-					 &pmic->irqarray1, 1);
-	if (ret) {
-		pr_err("no hisilicon,hisi-pmic-irq-array1 property set\n");
-		ret = -ENODEV;
-		return ret;
-	}
-
-	/*SOC_PMIC_IRQ_MASK_0_ADDR*/
-	ret = of_property_read_u32_array(np, "hisilicon,hisi-pmic-irq-mask-addr1",
-					 (int *)&pmic->irq_mask_addr1, 2);
-	if (ret) {
-		pr_err("no hisilicon,hisi-pmic-irq-mask-addr1 property set\n");
-		ret = -ENODEV;
-		return ret;
-	}
-
-	/*SOC_PMIC_IRQ0_ADDR*/
-	ret = of_property_read_u32_array(np, "hisilicon,hisi-pmic-irq-addr1",
-					 (int *)&pmic->irq_addr1, 2);
-	if (ret) {
-		pr_err("no hisilicon,hisi-pmic-irq-addr1 property set\n");
-		ret = -ENODEV;
-		return ret;
-	}
-
-	pmic->g_extinterrupt_flag = 1;
 	return ret;
 }
 
@@ -362,26 +263,6 @@ static void hisi_pmic_irq_prc(struct hisi_pmic *pmic)
 	}
 }
 
-static void hisi_pmic_irq1_prc(struct hisi_pmic *pmic)
-{
-	int i;
-	unsigned int pending1;
-
-	if (pmic->g_extinterrupt_flag == 1) {
-		for (i = 0 ; i < pmic->irq_mask_addr1.array; i++)
-			hisi_pmic_write(pmic, pmic->irq_mask_addr1.start_addr + i, HISI_MASK_STATE);
-
-		for (i = 0 ; i < pmic->irq_addr1.array; i++) {
-			pending1 = hisi_pmic_read(pmic, pmic->irq_addr1.start_addr + i);
-
-			pr_debug("PMU IRQ address1 value:irq[0x%x] = 0x%x\n",
-				 pmic->irq_addr1.start_addr + i, pending1);
-
-			hisi_pmic_write(pmic, pmic->irq_addr1.start_addr + i, HISI_MASK_STATE);
-		}
-	}
-}
-
 static int hisi_pmic_probe(struct spmi_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -390,7 +271,6 @@ static int hisi_pmic_probe(struct spmi_device *pdev)
 	enum of_gpio_flags flags;
 	int ret = 0;
 	int i;
-	unsigned int fpga_flag = 0;
 	unsigned int virq;
 
 	pmic = devm_kzalloc(dev, sizeof(*pmic), GFP_KERNEL);
@@ -404,22 +284,10 @@ static int hisi_pmic_probe(struct spmi_device *pdev)
 		return ret;
 	}
 
-	/*get pmic dts the second group irq*/
-	ret = get_pmic_device_tree_data1(np, pmic);
-	if (ret)
-		dev_err(&pdev->dev, "the platform don't support ext-interrupt.\n");
-
 	/* TODO: get and enable clk request */
 	spin_lock_init(&pmic->lock);
 
 	pmic->dev = dev;
-	ret = of_property_read_u32_array(np, "hisilicon,pmic_fpga_flag",
-					 &fpga_flag, 1);
-	if (ret)
-		pr_err("no hisilicon,pmic_fpga_flag property set\n");
-
-	if (fpga_flag == PMIC_FPGA_FLAG)
-		goto after_irq_register;
 
 	pmic->gpio = of_get_gpio_flags(np, 0, &flags);
 	if (pmic->gpio < 0)
@@ -438,10 +306,6 @@ static int hisi_pmic_probe(struct spmi_device *pdev)
 
 	/* mask && clear IRQ status */
 	hisi_pmic_irq_prc(pmic);
-	/*clear && mask the new adding irq*/
-	hisi_pmic_irq1_prc(pmic);
-
-	pmic->irqnum += pmic->irqnum1;
 
 	pmic->irqs = devm_kzalloc(dev, pmic->irqnum * sizeof(int), GFP_KERNEL);
 	if (!pmic->irqs)
@@ -491,7 +355,6 @@ static int hisi_pmic_probe(struct spmi_device *pdev)
 		return ret;
 	}
 
-after_irq_register:
 	return 0;
 
 request_theaded_irq:
diff --git a/include/linux/mfd/hi6421-spmi-pmic.h b/include/linux/mfd/hi6421-spmi-pmic.h
index 1f986dd5f31c..41b61de48259 100644
--- a/include/linux/mfd/hi6421-spmi-pmic.h
+++ b/include/linux/mfd/hi6421-spmi-pmic.h
@@ -48,19 +48,11 @@ struct hisi_pmic {
 	struct irq_domain	*domain;
 	int			irq;
 	int			gpio;
-	unsigned int	*irqs;
+	unsigned int		*irqs;
 	int			irqnum;
 	int			irqarray;
-	struct irq_mask_info irq_mask_addr;
-	struct irq_info irq_addr;
-	int			irqnum1;
-	int			irqarray1;
-	struct irq_mask_info irq_mask_addr1;
-	struct irq_info irq_addr1;
-	struct write_lock normal_lock;
-	struct write_lock debug_lock;
-
-	unsigned int g_extinterrupt_flag;
+	struct irq_mask_info 	irq_mask_addr;
+	struct irq_info		irq_addr;
 };
 
 u32 hisi_pmic_read(struct hisi_pmic *pmic, int reg);
-- 
2.26.2

