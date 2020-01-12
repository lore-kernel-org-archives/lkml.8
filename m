Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B95C33CA7
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 01:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B400E20866
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 01:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731964AbgALBzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 20:55:25 -0500
Received: from foss.arm.com ([217.140.110.172]:57804 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731946AbgALBzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 20:55:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26025328;
        Sat, 11 Jan 2020 17:55:22 -0800 (PST)
Received: from DESKTOP-VLO843J.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 43DF43F6C4;
        Sat, 11 Jan 2020 17:55:21 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, heiko@sntech.de,
        linux-rockchip@lists.infradead.org, smoch@web.de
Subject: [PATCH v2 4/5] mfd: rk808: Reduce shutdown duplication
Date:   Sun, 12 Jan 2020 01:55:03 +0000
Message-Id: <c6d320601104ab6502123a8db947c02801de69ea.1578789410.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578789410.git.robin.murphy@arm.com>
References: <cover.1578789410.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than having 3 almost-identical functions plus the machinery to
keep track of them, it's far simpler to just dynamically select the
appropriate register field per variant.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/mfd/rk808.c       | 61 +++++++++++++--------------------------
 include/linux/mfd/rk808.h |  1 -
 2 files changed, 20 insertions(+), 42 deletions(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index 8116ed6cf2e7..b2265c6e94ae 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -448,21 +448,6 @@ static const struct regmap_irq_chip rk818_irq_chip = {
 
 static struct i2c_client *rk808_i2c_client;
 
-static void rk805_device_shutdown(void)
-{
-	int ret;
-	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
-
-	if (!rk808)
-		return;
-
-	ret = regmap_update_bits(rk808->regmap,
-				 RK805_DEV_CTRL_REG,
-				 DEV_OFF, DEV_OFF);
-	if (ret)
-		dev_err(&rk808_i2c_client->dev, "Failed to shutdown device!\n");
-}
-
 static void rk805_device_shutdown_prepare(void)
 {
 	int ret;
@@ -478,32 +463,29 @@ static void rk805_device_shutdown_prepare(void)
 		dev_err(&rk808_i2c_client->dev, "Failed to shutdown device!\n");
 }
 
-static void rk808_device_shutdown(void)
+static void rk808_pm_power_off(void)
 {
 	int ret;
+	unsigned int reg, bit;
 	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
 
-	if (!rk808)
+	switch (rk808->variant) {
+	case RK805_ID:
+		reg = RK805_DEV_CTRL_REG;
+		bit = DEV_OFF;
+		break;
+	case RK808_ID:
+		reg = RK808_DEVCTRL_REG,
+		bit = DEV_OFF_RST;
+		break;
+	case RK818_ID:
+		reg = RK818_DEVCTRL_REG;
+		bit = DEV_OFF;
+		break;
+	default:
 		return;
-
-	ret = regmap_update_bits(rk808->regmap,
-				 RK808_DEVCTRL_REG,
-				 DEV_OFF_RST, DEV_OFF_RST);
-	if (ret)
-		dev_err(&rk808_i2c_client->dev, "Failed to shutdown device!\n");
-}
-
-static void rk818_device_shutdown(void)
-{
-	int ret;
-	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
-
-	if (!rk808)
-		return;
-
-	ret = regmap_update_bits(rk808->regmap,
-				 RK818_DEVCTRL_REG,
-				 DEV_OFF, DEV_OFF);
+	}
+	ret = regmap_update_bits(rk808->regmap, reg, bit, bit);
 	if (ret)
 		dev_err(&rk808_i2c_client->dev, "Failed to shutdown device!\n");
 }
@@ -592,7 +574,6 @@ static int rk808_probe(struct i2c_client *client,
 		nr_pre_init_regs = ARRAY_SIZE(rk805_pre_init_reg);
 		cells = rk805s;
 		nr_cells = ARRAY_SIZE(rk805s);
-		rk808->pm_pwroff_fn = rk805_device_shutdown;
 		rk808->pm_pwroff_prep_fn = rk805_device_shutdown_prepare;
 		break;
 	case RK808_ID:
@@ -602,7 +583,6 @@ static int rk808_probe(struct i2c_client *client,
 		nr_pre_init_regs = ARRAY_SIZE(rk808_pre_init_reg);
 		cells = rk808s;
 		nr_cells = ARRAY_SIZE(rk808s);
-		rk808->pm_pwroff_fn = rk808_device_shutdown;
 		break;
 	case RK818_ID:
 		rk808->regmap_cfg = &rk818_regmap_config;
@@ -611,7 +591,6 @@ static int rk808_probe(struct i2c_client *client,
 		nr_pre_init_regs = ARRAY_SIZE(rk818_pre_init_reg);
 		cells = rk818s;
 		nr_cells = ARRAY_SIZE(rk818s);
-		rk808->pm_pwroff_fn = rk818_device_shutdown;
 		break;
 	case RK809_ID:
 	case RK817_ID:
@@ -673,7 +652,7 @@ static int rk808_probe(struct i2c_client *client,
 
 	if (of_property_read_bool(np, "rockchip,system-power-controller")) {
 		rk808_i2c_client = client;
-		pm_power_off = rk808->pm_pwroff_fn;
+		pm_power_off = rk808_pm_power_off;
 		pm_power_off_prepare = rk808->pm_pwroff_prep_fn;
 	}
 
@@ -694,7 +673,7 @@ static int rk808_remove(struct i2c_client *client)
 	 * pm_power_off may points to a function from another module.
 	 * Check if the pointer is set by us and only then overwrite it.
 	 */
-	if (rk808->pm_pwroff_fn && pm_power_off == rk808->pm_pwroff_fn)
+	if (pm_power_off == rk808_pm_power_off)
 		pm_power_off = NULL;
 
 	/**
diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
index a59bf323f713..b038653fa87e 100644
--- a/include/linux/mfd/rk808.h
+++ b/include/linux/mfd/rk808.h
@@ -620,7 +620,6 @@ struct rk808 {
 	long				variant;
 	const struct regmap_config	*regmap_cfg;
 	const struct regmap_irq_chip	*regmap_irq_chip;
-	void				(*pm_pwroff_fn)(void);
 	void				(*pm_pwroff_prep_fn)(void);
 };
 #endif /* __LINUX_REGULATOR_RK808_H */
-- 
2.17.1

