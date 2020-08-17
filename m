Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA596C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFA2A20758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597648472;
	bh=7cQMbEqVP6QsOTdHh8KrYDnrohXVd6eK7Y95/ylle4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WhU6TNLEGV2JQmhhiHcZKnfrOsj1qFxFJ9O5Kafw6CH/vTPTKQy5Ub4Gc2S+JtVac
	 l+Prk9Imz/kENf23/090OS2J+V1DRtOoBCJBoDzEXjBUHILMylj82UO25V7bOnMWve
	 aU/mLsmrdgvlHJQ4CMOpohN1WP7e5PaN+BGxDf68=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgHQHOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:14:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbgHQHL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:11:26 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B584221E2;
        Mon, 17 Aug 2020 07:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597648277;
        bh=7cQMbEqVP6QsOTdHh8KrYDnrohXVd6eK7Y95/ylle4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gla6gAgvv3WE6+mUAioXlcTZO8/v9nqPs4wCu3LpZEEvu+8AEK2aoYK4l4OLqSO9p
         kYmRNOk7FbW4S32yLm+qBEGe+lMO6MFlMgxRd6Pq7ZO7r5tgHm5zx2n4g4YVSnWbvz
         25isBiyvDIaWu5b+iEywDFRcpeD87wj4wT5/VRnM=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k7ZIZ-00Bdk4-LM; Mon, 17 Aug 2020 09:11:15 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH v3 19/44] staging: mfd: hi6421-spmi-pmic: change namespace on its functions
Date:   Mon, 17 Aug 2020 09:10:38 +0200
Message-Id: <bfa8bf33f71612b1511d73269ca242d0d4e70940.1597647359.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597647359.git.mchehab+huawei@kernel.org>
References: <cover.1597647359.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the functions used internally inside the driver in
order for them to follow the driver's name.

While here, get rid of some unused definitions at the
header file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 97 +++++++++++----------
 include/linux/mfd/hi6421-spmi-pmic.h        | 51 ++++-------
 2 files changed, 70 insertions(+), 78 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
index aed2d3ec2227..09cedfa1e4bb 100644
--- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
+++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
@@ -62,7 +62,7 @@ static const struct mfd_cell hi6421v600_devs[] = {
  * Hisilicon SoC use hardware to map PMIC register into SoC mapping.
  * At here, we are accessing SoC register with 32-bit.
  */
-u32 hisi_pmic_read(struct hisi_pmic *pmic, int reg)
+u32 hi6421_spmi_pmic_read(struct hi6421_spmi_pmic *pmic, int reg)
 {
 	u32 ret;
 	u8 read_value = 0;
@@ -82,9 +82,9 @@ u32 hisi_pmic_read(struct hisi_pmic *pmic, int reg)
 	}
 	return (u32)read_value;
 }
-EXPORT_SYMBOL(hisi_pmic_read);
+EXPORT_SYMBOL(hi6421_spmi_pmic_read);
 
-void hisi_pmic_write(struct hisi_pmic *pmic, int reg, u32 val)
+void hi6421_spmi_pmic_write(struct hi6421_spmi_pmic *pmic, int reg, u32 val)
 {
 	u32 ret;
 	struct spmi_device *pdev;
@@ -101,34 +101,36 @@ void hisi_pmic_write(struct hisi_pmic *pmic, int reg, u32 val)
 		return;
 	}
 }
-EXPORT_SYMBOL(hisi_pmic_write);
+EXPORT_SYMBOL(hi6421_spmi_pmic_write);
 
-void hisi_pmic_rmw(struct hisi_pmic *pmic, int reg, u32 mask, u32 bits)
+void hi6421_spmi_pmic_rmw(struct hi6421_spmi_pmic *pmic, int reg,
+			  u32 mask, u32 bits)
 {
 	u32 data;
 	unsigned long flags;
 
 	spin_lock_irqsave(&pmic->lock, flags);
-	data = hisi_pmic_read(pmic, reg) & ~mask;
+	data = hi6421_spmi_pmic_read(pmic, reg) & ~mask;
 	data |= mask & bits;
-	hisi_pmic_write(pmic, reg, data);
+	hi6421_spmi_pmic_write(pmic, reg, data);
 	spin_unlock_irqrestore(&pmic->lock, flags);
 }
-EXPORT_SYMBOL(hisi_pmic_rmw);
+EXPORT_SYMBOL(hi6421_spmi_pmic_rmw);
 
-static irqreturn_t hisi_irq_handler(int irq, void *data)
+static irqreturn_t hi6421_spmi_irq_handler(int irq, void *data)
 {
-	struct hisi_pmic *pmic = (struct hisi_pmic *)data;
+	struct hi6421_spmi_pmic *pmic = (struct hi6421_spmi_pmic *)data;
 	unsigned long pending;
 	int i, offset;
 
 	for (i = 0; i < pmic->irqarray; i++) {
-		pending = hisi_pmic_read(pmic, (i + pmic->irq_addr.start_addr));
+		pending = hi6421_spmi_pmic_read(pmic, (i + pmic->irq_addr.start_addr));
 		pending &= HISI_MASK_FIELD;
 		if (pending != 0)
 			pr_debug("pending[%d]=0x%lx\n\r", i, pending);
 
-		hisi_pmic_write(pmic, (i + pmic->irq_addr.start_addr), pending);
+		hi6421_spmi_pmic_write(pmic, (i + pmic->irq_addr.start_addr),
+				       pending);
 
 		/* solve powerkey order */
 		if ((i == HISI_IRQ_KEY_NUM) && ((pending & HISI_IRQ_KEY_VALUE) == HISI_IRQ_KEY_VALUE)) {
@@ -146,9 +148,9 @@ static irqreturn_t hisi_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void hisi_irq_mask(struct irq_data *d)
+static void hi6421_spmi_irq_mask(struct irq_data *d)
 {
-	struct hisi_pmic *pmic = irq_data_get_irq_chip_data(d);
+	struct hi6421_spmi_pmic *pmic = irq_data_get_irq_chip_data(d);
 	u32 data, offset;
 	unsigned long flags;
 
@@ -156,15 +158,15 @@ static void hisi_irq_mask(struct irq_data *d)
 	offset += pmic->irq_mask_addr.start_addr;
 
 	spin_lock_irqsave(&pmic->lock, flags);
-	data = hisi_pmic_read(pmic, offset);
+	data = hi6421_spmi_pmic_read(pmic, offset);
 	data |= (1 << (irqd_to_hwirq(d) & 0x07));
-	hisi_pmic_write(pmic, offset, data);
+	hi6421_spmi_pmic_write(pmic, offset, data);
 	spin_unlock_irqrestore(&pmic->lock, flags);
 }
 
-static void hisi_irq_unmask(struct irq_data *d)
+static void hi6421_spmi_irq_unmask(struct irq_data *d)
 {
-	struct hisi_pmic *pmic = irq_data_get_irq_chip_data(d);
+	struct hi6421_spmi_pmic *pmic = irq_data_get_irq_chip_data(d);
 	u32 data, offset;
 	unsigned long flags;
 
@@ -172,26 +174,26 @@ static void hisi_irq_unmask(struct irq_data *d)
 	offset += pmic->irq_mask_addr.start_addr;
 
 	spin_lock_irqsave(&pmic->lock, flags);
-	data = hisi_pmic_read(pmic, offset);
+	data = hi6421_spmi_pmic_read(pmic, offset);
 	data &= ~(1 << (irqd_to_hwirq(d) & 0x07));
-	hisi_pmic_write(pmic, offset, data);
+	hi6421_spmi_pmic_write(pmic, offset, data);
 	spin_unlock_irqrestore(&pmic->lock, flags);
 }
 
-static struct irq_chip hisi_pmu_irqchip = {
+static struct irq_chip hi6421_spmi_pmu_irqchip = {
 	.name		= "hisi-irq",
-	.irq_mask	= hisi_irq_mask,
-	.irq_unmask	= hisi_irq_unmask,
-	.irq_disable	= hisi_irq_mask,
-	.irq_enable	= hisi_irq_unmask,
+	.irq_mask	= hi6421_spmi_irq_mask,
+	.irq_unmask	= hi6421_spmi_irq_unmask,
+	.irq_disable	= hi6421_spmi_irq_mask,
+	.irq_enable	= hi6421_spmi_irq_unmask,
 };
 
-static int hisi_irq_map(struct irq_domain *d, unsigned int virq,
+static int hi6421_spmi_irq_map(struct irq_domain *d, unsigned int virq,
 			irq_hw_number_t hw)
 {
-	struct hisi_pmic *pmic = d->host_data;
+	struct hi6421_spmi_pmic *pmic = d->host_data;
 
-	irq_set_chip_and_handler_name(virq, &hisi_pmu_irqchip,
+	irq_set_chip_and_handler_name(virq, &hi6421_spmi_pmu_irqchip,
 				      handle_simple_irq, "hisi");
 	irq_set_chip_data(virq, pmic);
 	irq_set_irq_type(virq, IRQ_TYPE_NONE);
@@ -199,12 +201,13 @@ static int hisi_irq_map(struct irq_domain *d, unsigned int virq,
 	return 0;
 }
 
-static const struct irq_domain_ops hisi_domain_ops = {
-	.map	= hisi_irq_map,
+static const struct irq_domain_ops hi6421_spmi_domain_ops = {
+	.map	= hi6421_spmi_irq_map,
 	.xlate	= irq_domain_xlate_twocell,
 };
 
-static int get_pmic_device_tree_data(struct device_node *np, struct hisi_pmic *pmic)
+static int get_pmic_device_tree_data(struct device_node *np,
+				     struct hi6421_spmi_pmic *pmic)
 {
 	int ret = 0;
 
@@ -247,27 +250,29 @@ static int get_pmic_device_tree_data(struct device_node *np, struct hisi_pmic *p
 	return ret;
 }
 
-static void hisi_pmic_irq_prc(struct hisi_pmic *pmic)
+static void hi6421_spmi_pmic_irq_prc(struct hi6421_spmi_pmic *pmic)
 {
 	int i;
 
 	for (i = 0 ; i < pmic->irq_mask_addr.array; i++)
-		hisi_pmic_write(pmic, pmic->irq_mask_addr.start_addr + i, HISI_MASK_STATE);
+		hi6421_spmi_pmic_write(pmic, pmic->irq_mask_addr.start_addr + i,
+				       HISI_MASK_STATE);
 
 	for (i = 0 ; i < pmic->irq_addr.array; i++) {
-		unsigned int pending = hisi_pmic_read(pmic, pmic->irq_addr.start_addr + i);
+		unsigned int pending = hi6421_spmi_pmic_read(pmic, pmic->irq_addr.start_addr + i);
 
 		pr_debug("PMU IRQ address value:irq[0x%x] = 0x%x\n",
 			 pmic->irq_addr.start_addr + i, pending);
-		hisi_pmic_write(pmic, pmic->irq_addr.start_addr + i, HISI_MASK_STATE);
+		hi6421_spmi_pmic_write(pmic, pmic->irq_addr.start_addr + i,
+				       HISI_MASK_STATE);
 	}
 }
 
-static int hisi_pmic_probe(struct spmi_device *pdev)
+static int hi6421_spmi_pmic_probe(struct spmi_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	struct hisi_pmic *pmic = NULL;
+	struct hi6421_spmi_pmic *pmic = NULL;
 	enum of_gpio_flags flags;
 	int ret = 0;
 	int i;
@@ -305,14 +310,14 @@ static int hisi_pmic_probe(struct spmi_device *pdev)
 	pmic->irq = gpio_to_irq(pmic->gpio);
 
 	/* mask && clear IRQ status */
-	hisi_pmic_irq_prc(pmic);
+	hi6421_spmi_pmic_irq_prc(pmic);
 
 	pmic->irqs = devm_kzalloc(dev, pmic->irqnum * sizeof(int), GFP_KERNEL);
 	if (!pmic->irqs)
 		goto irq_malloc;
 
 	pmic->domain = irq_domain_add_simple(np, pmic->irqnum, 0,
-					     &hisi_domain_ops, pmic);
+					     &hi6421_spmi_domain_ops, pmic);
 	if (!pmic->domain) {
 		dev_err(dev, "failed irq domain add simple!\n");
 		ret = -ENODEV;
@@ -330,7 +335,7 @@ static int hisi_pmic_probe(struct spmi_device *pdev)
 		pr_info("[%s]. pmic->irqs[%d] = %d\n", __func__, i, pmic->irqs[i]);
 	}
 
-	ret = request_threaded_irq(pmic->irq, hisi_irq_handler, NULL,
+	ret = request_threaded_irq(pmic->irq, hi6421_spmi_irq_handler, NULL,
 				   IRQF_TRIGGER_LOW | IRQF_SHARED | IRQF_NO_SUSPEND,
 				   "pmic", pmic);
 	if (ret < 0) {
@@ -365,9 +370,9 @@ static int hisi_pmic_probe(struct spmi_device *pdev)
 	return ret;
 }
 
-static void hisi_pmic_remove(struct spmi_device *pdev)
+static void hi6421_spmi_pmic_remove(struct spmi_device *pdev)
 {
-	struct hisi_pmic *pmic = dev_get_drvdata(&pdev->dev);
+	struct hi6421_spmi_pmic *pmic = dev_get_drvdata(&pdev->dev);
 
 	free_irq(pmic->irq, pmic);
 	gpio_free(pmic->gpio);
@@ -380,15 +385,15 @@ static const struct of_device_id pmic_spmi_id_table[] = {
 };
 MODULE_DEVICE_TABLE(of, pmic_spmi_id_table);
 
-static struct spmi_driver hisi_pmic_driver = {
+static struct spmi_driver hi6421_spmi_pmic_driver = {
 	.driver = {
 		.name	= "hi6421-spmi-pmic",
 		.of_match_table = pmic_spmi_id_table,
 	},
-	.probe	= hisi_pmic_probe,
-	.remove	= hisi_pmic_remove,
+	.probe	= hi6421_spmi_pmic_probe,
+	.remove	= hi6421_spmi_pmic_remove,
 };
-module_spmi_driver(hisi_pmic_driver);
+module_spmi_driver(hi6421_spmi_pmic_driver);
 
 MODULE_DESCRIPTION("HiSilicon Hi6421v600 SPMI PMIC driver");
 MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/hi6421-spmi-pmic.h b/include/linux/mfd/hi6421-spmi-pmic.h
index 41b61de48259..d12ad7484018 100644
--- a/include/linux/mfd/hi6421-spmi-pmic.h
+++ b/include/linux/mfd/hi6421-spmi-pmic.h
@@ -17,49 +17,36 @@
 #define HISI_ECO_MODE_ENABLE		(1)
 #define HISI_ECO_MODE_DISABLE		(0)
 
-typedef int (*pmic_ocp_callback)(char *);
-int hisi_pmic_special_ocp_register(char *power_name, pmic_ocp_callback handler);
-
-struct irq_mask_info {
+struct hi6421_spmi_irq_mask_info {
 	int start_addr;
 	int array;
 };
 
-struct irq_info {
+struct hi6421_spmi_irq_info {
 	int start_addr;
 	int array;
 };
 
-struct bit_info {
-	int addr;
-	int bit;
-};
-
-struct write_lock {
-	int addr;
-	int val;
-};
-
-struct hisi_pmic {
-	struct resource		*res;
-	struct device		*dev;
-	void __iomem		*regs;
-	spinlock_t		lock;
-	struct irq_domain	*domain;
-	int			irq;
-	int			gpio;
-	unsigned int		*irqs;
-	int			irqnum;
-	int			irqarray;
-	struct irq_mask_info 	irq_mask_addr;
-	struct irq_info		irq_addr;
+struct hi6421_spmi_pmic {
+	struct resource				*res;
+	struct device				*dev;
+	void __iomem				*regs;
+	spinlock_t				lock;
+	struct irq_domain			*domain;
+	int					irq;
+	int					gpio;
+	unsigned int				*irqs;
+	int					irqnum;
+	int					irqarray;
+	struct hi6421_spmi_irq_mask_info 	irq_mask_addr;
+	struct hi6421_spmi_irq_info		irq_addr;
 };
 
-u32 hisi_pmic_read(struct hisi_pmic *pmic, int reg);
-void hisi_pmic_write(struct hisi_pmic *pmic, int reg, u32 val);
-void hisi_pmic_rmw(struct hisi_pmic *pmic, int reg, u32 mask, u32 bits);
+u32 hi6421_spmi_pmic_read(struct hi6421_spmi_pmic *pmic, int reg);
+void hi6421_spmi_pmic_write(struct hi6421_spmi_pmic *pmic, int reg, u32 val);
+void hi6421_spmi_pmic_rmw(struct hi6421_spmi_pmic *pmic, int reg, u32 mask, u32 bits);
 
-enum pmic_irq_list {
+enum hi6421_spmi_pmic_irq_list {
 	OTMP = 0,
 	VBUS_CONNECT,
 	VBUS_DISCONNECT,
-- 
2.26.2

