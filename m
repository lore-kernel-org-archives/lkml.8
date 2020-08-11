Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A72DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3E382076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597160573;
	bh=ooCZufwW5veps1Jt5Q9pKqUxiaGHaUxamRN5FHmdsZE=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=pHJ0+y/lFKHPOodM81Qp1f+ZZtRwUc/poLpkjt3Dtx5ZB5HYu6ZDyvKvh6K1w0fV4
	 O5ObOoabaKCdzJbUyJc0II9+IFuQ623ErNGxlxza6YCgA2rCTM+wyJZJOhdOTuIKos
	 /ONWcbk9ZfFgSiTY+jdbXIYgQ//dCIMaI0zxogFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgHKPmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:42:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729035AbgHKPmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:42:10 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F061822D6D;
        Tue, 11 Aug 2020 15:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597160524;
        bh=ooCZufwW5veps1Jt5Q9pKqUxiaGHaUxamRN5FHmdsZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tEtZsSSijA1ylAPSOghASQhngmTMlxbhuqqn5hJhxYcNkMrXCWJDpw4kErqWbg1/K
         oAMDGTSm9wkvWeVtYMAShCpSiXAAAEFI+Gwh1PJnccvIA/Xz1pEkP+V79mAnU8lCy5
         hnx+b5WFdkXUulz6bAFxC9IxNntWT140ugcWk0U4=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5WPa-004bnL-2B; Tue, 11 Aug 2020 17:42:02 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 24/33] regulator, mfd: change namespace for HiSilicon SPMI PMIC drivers
Date:   Tue, 11 Aug 2020 17:41:50 +0200
Message-Id: <bbb669985f60b12d561643385957eb97a997a70a.1597160086.git.mchehab+huawei@kernel.org>
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

Rename the functions used internally inside the driver in
order for them to follow the driver's name.

While here, get rid of some unused definitions at the
header file.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/mfd/hi6421-spmi-pmic.c           | 97 +++++++++++++-----------
 drivers/regulator/hi6421v600-regulator.c | 94 +++++++++++------------
 include/linux/mfd/hi6421-spmi-pmic.h     | 51 +++++--------
 3 files changed, 117 insertions(+), 125 deletions(-)

diff --git a/drivers/mfd/hi6421-spmi-pmic.c b/drivers/mfd/hi6421-spmi-pmic.c
index aed2d3ec2227..09cedfa1e4bb 100644
--- a/drivers/mfd/hi6421-spmi-pmic.c
+++ b/drivers/mfd/hi6421-spmi-pmic.c
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
diff --git a/drivers/regulator/hi6421v600-regulator.c b/drivers/regulator/hi6421v600-regulator.c
index bde7fa4d7e8f..f77ecea78597 100644
--- a/drivers/regulator/hi6421v600-regulator.c
+++ b/drivers/regulator/hi6421v600-regulator.c
@@ -41,7 +41,7 @@
 
 struct hi6421v600_regulator {
 	struct regulator_desc rdesc;
-	struct hisi_pmic *pmic;
+	struct hi6421_spmi_pmic *pmic;
 	u8 eco_mode_mask;
 	u32 eco_uA;
 };
@@ -52,13 +52,13 @@ static DEFINE_MUTEX(enable_mutex);
  * microseconds after 'since'.
  */
 
-static int hisi_regulator_is_enabled(struct regulator_dev *rdev)
+static int hi6421_spmi_regulator_is_enabled(struct regulator_dev *rdev)
 {
 	u32 reg_val;
 	struct hi6421v600_regulator *sreg = rdev_get_drvdata(rdev);
-	struct hisi_pmic *pmic = sreg->pmic;
+	struct hi6421_spmi_pmic *pmic = sreg->pmic;
 
-	reg_val = hisi_pmic_read(pmic, rdev->desc->enable_reg);
+	reg_val = hi6421_spmi_pmic_read(pmic, rdev->desc->enable_reg);
 
 	dev_dbg(&rdev->dev,
 		"%s: enable_reg=0x%x, val= 0x%x, enable_state=%d\n",
@@ -68,10 +68,10 @@ static int hisi_regulator_is_enabled(struct regulator_dev *rdev)
 	return ((reg_val & rdev->desc->enable_mask) != 0);
 }
 
-static int hisi_regulator_enable(struct regulator_dev *rdev)
+static int hi6421_spmi_regulator_enable(struct regulator_dev *rdev)
 {
 	struct hi6421v600_regulator *sreg = rdev_get_drvdata(rdev);
-	struct hisi_pmic *pmic = sreg->pmic;
+	struct hi6421_spmi_pmic *pmic = sreg->pmic;
 
 	/* keep a distance of off_on_delay from last time disabled */
 	usleep_range(rdev->desc->off_on_delay, rdev->desc->off_on_delay + 1000);
@@ -85,7 +85,7 @@ static int hisi_regulator_enable(struct regulator_dev *rdev)
 		     HISI_REGS_ENA_PROTECT_TIME + 1000);
 
 	/* set enable register */
-	hisi_pmic_rmw(pmic, rdev->desc->enable_reg,
+	hi6421_spmi_pmic_rmw(pmic, rdev->desc->enable_reg,
 		      rdev->desc->enable_mask,
 				rdev->desc->enable_mask);
 	dev_dbg(&rdev->dev, "%s: enable_reg=0x%x, enable_mask=0x%x\n",
@@ -97,27 +97,27 @@ static int hisi_regulator_enable(struct regulator_dev *rdev)
 	return 0;
 }
 
-static int hisi_regulator_disable(struct regulator_dev *rdev)
+static int hi6421_spmi_regulator_disable(struct regulator_dev *rdev)
 {
 	struct hi6421v600_regulator *sreg = rdev_get_drvdata(rdev);
-	struct hisi_pmic *pmic = sreg->pmic;
+	struct hi6421_spmi_pmic *pmic = sreg->pmic;
 
 	/* set enable register to 0 */
-	hisi_pmic_rmw(pmic, rdev->desc->enable_reg,
+	hi6421_spmi_pmic_rmw(pmic, rdev->desc->enable_reg,
 		      rdev->desc->enable_mask, 0);
 
 	return 0;
 }
 
-static int hisi_regulator_get_voltage(struct regulator_dev *rdev)
+static int hi6421_spmi_regulator_get_voltage(struct regulator_dev *rdev)
 {
 	struct hi6421v600_regulator *sreg = rdev_get_drvdata(rdev);
-	struct hisi_pmic *pmic = sreg->pmic;
+	struct hi6421_spmi_pmic *pmic = sreg->pmic;
 	u32 reg_val, selector;
 	int vol;
 
 	/* get voltage selector */
-	reg_val = hisi_pmic_read(pmic, rdev->desc->vsel_reg);
+	reg_val = hi6421_spmi_pmic_read(pmic, rdev->desc->vsel_reg);
 	selector = (reg_val & rdev->desc->vsel_mask) >>
 				(ffs(rdev->desc->vsel_mask) - 1);
 
@@ -130,11 +130,11 @@ static int hisi_regulator_get_voltage(struct regulator_dev *rdev)
 	return vol;
 }
 
-static int hisi_regulator_set_voltage(struct regulator_dev *rdev,
+static int hi6421_spmi_regulator_set_voltage(struct regulator_dev *rdev,
 				      int min_uV, int max_uV, unsigned int *selector)
 {
 	struct hi6421v600_regulator *sreg = rdev_get_drvdata(rdev);
-	struct hisi_pmic *pmic = sreg->pmic;
+	struct hi6421_spmi_pmic *pmic = sreg->pmic;
 	u32 vsel;
 	int uV, ret = 0;
 
@@ -155,7 +155,7 @@ static int hisi_regulator_set_voltage(struct regulator_dev *rdev,
 
 	*selector = vsel;
 	/* set voltage selector */
-	hisi_pmic_rmw(pmic, rdev->desc->vsel_reg,
+	hi6421_spmi_pmic_rmw(pmic, rdev->desc->vsel_reg,
 		      rdev->desc->vsel_mask,
 		      vsel << (ffs(rdev->desc->vsel_mask) - 1));
 
@@ -169,14 +169,14 @@ static int hisi_regulator_set_voltage(struct regulator_dev *rdev,
 	return ret;
 }
 
-static unsigned int hisi_regulator_get_mode(struct regulator_dev *rdev)
+static unsigned int hi6421_spmi_regulator_get_mode(struct regulator_dev *rdev)
 {
 	struct hi6421v600_regulator *sreg = rdev_get_drvdata(rdev);
-	struct hisi_pmic *pmic = sreg->pmic;
+	struct hi6421_spmi_pmic *pmic = sreg->pmic;
 	u32 reg_val;
 	unsigned int mode;
 
-	reg_val = hisi_pmic_read(pmic, rdev->desc->enable_reg);
+	reg_val = hi6421_spmi_pmic_read(pmic, rdev->desc->enable_reg);
 
 	if (reg_val & sreg->eco_mode_mask)
 		mode = REGULATOR_MODE_IDLE;
@@ -191,11 +191,11 @@ static unsigned int hisi_regulator_get_mode(struct regulator_dev *rdev)
 	return mode;
 }
 
-static int hisi_regulator_set_mode(struct regulator_dev *rdev,
+static int hi6421_spmi_regulator_set_mode(struct regulator_dev *rdev,
 				   unsigned int mode)
 {
 	struct hi6421v600_regulator *sreg = rdev_get_drvdata(rdev);
-	struct hisi_pmic *pmic = sreg->pmic;
+	struct hi6421_spmi_pmic *pmic = sreg->pmic;
 	u32 val;
 
 	switch (mode) {
@@ -210,8 +210,8 @@ static int hisi_regulator_set_mode(struct regulator_dev *rdev,
 	}
 
 	/* set mode */
-	hisi_pmic_rmw(pmic, rdev->desc->enable_reg,
-		      sreg->eco_mode_mask, val);
+	hi6421_spmi_pmic_rmw(pmic, rdev->desc->enable_reg,
+			     sreg->eco_mode_mask, val);
 
 	dev_dbg(&rdev->dev,
 		"%s: enable_reg=0x%x, eco_mode_mask=0x%x, value=0x%x\n",
@@ -220,7 +220,7 @@ static int hisi_regulator_set_mode(struct regulator_dev *rdev,
 	return 0;
 }
 
-static unsigned int hisi_regulator_get_optimum_mode(struct regulator_dev *rdev,
+static unsigned int hi6421_spmi_regulator_get_optimum_mode(struct regulator_dev *rdev,
 						    int input_uV, int output_uV,
 						    int load_uA)
 {
@@ -235,7 +235,7 @@ static unsigned int hisi_regulator_get_optimum_mode(struct regulator_dev *rdev,
 	}
 }
 
-static int hisi_dt_parse(struct platform_device *pdev,
+static int hi6421_spmi_dt_parse(struct platform_device *pdev,
 			 struct hi6421v600_regulator *sreg,
 			 struct regulator_desc *rdesc)
 {
@@ -310,25 +310,25 @@ static int hisi_dt_parse(struct platform_device *pdev,
 	return 0;
 }
 
-static struct regulator_ops hisi_ldo_rops = {
-	.is_enabled = hisi_regulator_is_enabled,
-	.enable = hisi_regulator_enable,
-	.disable = hisi_regulator_disable,
+static struct regulator_ops hi6421_spmi_ldo_rops = {
+	.is_enabled = hi6421_spmi_regulator_is_enabled,
+	.enable = hi6421_spmi_regulator_enable,
+	.disable = hi6421_spmi_regulator_disable,
 	.list_voltage = regulator_list_voltage_table,
-	.get_voltage = hisi_regulator_get_voltage,
-	.set_voltage = hisi_regulator_set_voltage,
-	.get_mode = hisi_regulator_get_mode,
-	.set_mode = hisi_regulator_set_mode,
-	.get_optimum_mode = hisi_regulator_get_optimum_mode,
+	.get_voltage = hi6421_spmi_regulator_get_voltage,
+	.set_voltage = hi6421_spmi_regulator_set_voltage,
+	.get_mode = hi6421_spmi_regulator_get_mode,
+	.set_mode = hi6421_spmi_regulator_set_mode,
+	.get_optimum_mode = hi6421_spmi_regulator_get_optimum_mode,
 };
 
 /*
  * Used only for parsing the DT properties
  */
 
-static int hisi_regulator_probe_ldo(struct platform_device *pdev,
+static int hi6421_spmi_regulator_probe_ldo(struct platform_device *pdev,
 				    struct device_node *np,
-				    struct hisi_pmic *pmic)
+				    struct hi6421_spmi_pmic *pmic)
 {
 	struct device *dev = &pdev->dev;
 	struct regulator_desc *rdesc;
@@ -354,7 +354,7 @@ static int hisi_regulator_probe_ldo(struct platform_device *pdev,
 	rdesc = &sreg->rdesc;
 
 	rdesc->name = initdata->constraints.name;
-	rdesc->ops = &hisi_ldo_rops;
+	rdesc->ops = &hi6421_spmi_ldo_rops;
 	rdesc->type = REGULATOR_VOLTAGE;
 	rdesc->min_uV = initdata->constraints.min_uV;
 
@@ -363,9 +363,9 @@ static int hisi_regulator_probe_ldo(struct platform_device *pdev,
 		initdata->supply_regulator = supplyname;
 
 	/* parse device tree data for regulator specific */
-	ret = hisi_dt_parse(pdev, sreg, rdesc);
+	ret = hi6421_spmi_dt_parse(pdev, sreg, rdesc);
 	if (ret)
-		goto hisi_probe_end;
+		goto probe_end;
 
 	/* hisi regulator supports two modes */
 	constraint = &initdata->constraints;
@@ -387,27 +387,27 @@ static int hisi_regulator_probe_ldo(struct platform_device *pdev,
 		dev_err(dev, "failed to register %s\n",
 			rdesc->name);
 		ret = PTR_ERR(rdev);
-		goto hisi_probe_end;
+		goto probe_end;
 	}
 
 	dev_dbg(dev, "valid_modes_mask: 0x%x, valid_ops_mask: 0x%x\n",
 		 constraint->valid_modes_mask, constraint->valid_ops_mask);
 
 	dev_set_drvdata(dev, rdev);
-hisi_probe_end:
+probe_end:
 	if (ret)
 		kfree(sreg);
 	return ret;
 }
 
 
-static int hisi_regulator_probe(struct platform_device *pdev)
+static int hi6421_spmi_regulator_probe(struct platform_device *pdev)
 {
 	struct device *pmic_dev = pdev->dev.parent;
 	struct device_node *np = pmic_dev->of_node;
 	struct device_node *regulators, *child;
 	struct platform_device *new_pdev;
-	struct hisi_pmic *pmic;
+	struct hi6421_spmi_pmic *pmic;
 	int ret;
 
 	dev_dbg(&pdev->dev, "probing hi6421v600 regulator\n");
@@ -442,7 +442,7 @@ static int hisi_regulator_probe(struct platform_device *pdev)
 			continue;
 		}
 
-		ret = hisi_regulator_probe_ldo(new_pdev, child, pmic);
+		ret = hi6421_spmi_regulator_probe_ldo(new_pdev, child, pmic);
 		if (ret < 0)
 			platform_device_put(new_pdev);
 	}
@@ -452,7 +452,7 @@ static int hisi_regulator_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int hisi_regulator_remove(struct platform_device *pdev)
+static int hi6421_spmi_regulator_remove(struct platform_device *pdev)
 {
 	struct regulator_dev *rdev = dev_get_drvdata(&pdev->dev);
 	struct hi6421v600_regulator *sreg = rdev_get_drvdata(rdev);
@@ -479,8 +479,8 @@ static struct platform_driver hi6421v600_regulator_driver = {
 	.driver = {
 		.name	= "hi6421v600-regulator",
 	},
-	.probe	= hisi_regulator_probe,
-	.remove	= hisi_regulator_remove,
+	.probe	= hi6421_spmi_regulator_probe,
+	.remove	= hi6421_spmi_regulator_remove,
 };
 module_platform_driver(hi6421v600_regulator_driver);
 
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

