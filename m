Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A2CC3B186
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE82120656
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581436297;
	bh=3Obk80pF9KC892msPVa+eywOQTiSHimCNodBuTxSaCo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=lvG7WwpTRGn5Wibon6hOMkccbLP1q02pmisldRzfFawW2/40XGrR8Wm/Bd+vxto4y
	 d5qcnRovzYg8eAebYuA2y3MeTFCNZVZfZ2/FPgUx2ZZsI7oQTbsIGfiE0GfLz1amg2
	 RKSSRA+POHoqs1UbR9wS+chT8fR2d4LvITkukRkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbgBKPvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:51:36 -0500
Received: from foss.arm.com ([217.140.110.172]:48840 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730573AbgBKPvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:51:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8F9130E;
        Tue, 11 Feb 2020 07:51:31 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A2B23F68E;
        Tue, 11 Feb 2020 07:51:31 -0800 (PST)
Date:   Tue, 11 Feb 2020 15:51:29 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rishi Gupta <gupt21@gmail.com>
Cc:     Adam.Thomson.Opensource@diasemi.com, axel.lin@ingics.com,
        broonie@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        support.opensource@diasemi.com
Subject: Applied "regulator: da9063: fix code formatting warnings and errors" to the regulator tree
In-Reply-To: <1580996917-28494-1-git-send-email-gupt21@gmail.com>
Message-Id: <applied-1580996917-28494-1-git-send-email-gupt21@gmail.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: da9063: fix code formatting warnings and errors

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.7

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From a33b25f57ddeb8545dab6ffee6be0f38d89d42c6 Mon Sep 17 00:00:00 2001
From: Rishi Gupta <gupt21@gmail.com>
Date: Thu, 6 Feb 2020 19:18:37 +0530
Subject: [PATCH] regulator: da9063: fix code formatting warnings and errors

This commit fixes following errors & warnings in this driver
as reported by checkpatch.pl:

- WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
- WARNING: line over 80 characters
- ERROR: space prohibited before that ',' (ctx:WxW)
- ERROR: code indent should use tabs where possible
- WARNING: Block comments use * on subsequent lines

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
Link: https://lore.kernel.org/r/1580996917-28494-1-git-send-email-gupt21@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/da9063-regulator.c | 58 ++++++++++++++++------------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 2aceb3b7afc2..ae54c76a8580 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -66,7 +66,7 @@ struct da9063_regulator_data {
 };
 
 struct da9063_regulators_pdata {
-	unsigned			n_regulators;
+	unsigned int			n_regulators;
 	struct da9063_regulator_data	*regulator_data;
 };
 
@@ -131,7 +131,7 @@ struct da9063_regulator_info {
 /* Defines asignment of regulators info table to chip model */
 struct da9063_dev_model {
 	const struct da9063_regulator_info	*regulator_info;
-	unsigned				n_regulators;
+	unsigned int				n_regulators;
 	enum da9063_type			type;
 };
 
@@ -150,7 +150,7 @@ struct da9063_regulator {
 
 /* Encapsulates all information for the regulators driver */
 struct da9063_regulators {
-	unsigned				n_regulators;
+	unsigned int				n_regulators;
 	/* Array size to be defined during init. Keep at end. */
 	struct da9063_regulator			regulator[0];
 };
@@ -165,38 +165,46 @@ enum {
 
 /* Regulator operations */
 
-/* Current limits array (in uA) for BCORE1, BCORE2, BPRO.
-   Entry indexes corresponds to register values. */
+/*
+ * Current limits array (in uA) for BCORE1, BCORE2, BPRO.
+ * Entry indexes corresponds to register values.
+ */
 static const unsigned int da9063_buck_a_limits[] = {
 	 500000,  600000,  700000,  800000,  900000, 1000000, 1100000, 1200000,
 	1300000, 1400000, 1500000, 1600000, 1700000, 1800000, 1900000, 2000000
 };
 
-/* Current limits array (in uA) for BMEM, BIO, BPERI.
-   Entry indexes corresponds to register values. */
+/*
+ * Current limits array (in uA) for BMEM, BIO, BPERI.
+ * Entry indexes corresponds to register values.
+ */
 static const unsigned int da9063_buck_b_limits[] = {
 	1500000, 1600000, 1700000, 1800000, 1900000, 2000000, 2100000, 2200000,
 	2300000, 2400000, 2500000, 2600000, 2700000, 2800000, 2900000, 3000000
 };
 
-/* Current limits array (in uA) for merged BCORE1 and BCORE2.
-   Entry indexes corresponds to register values. */
+/*
+ * Current limits array (in uA) for merged BCORE1 and BCORE2.
+ * Entry indexes corresponds to register values.
+ */
 static const unsigned int da9063_bcores_merged_limits[] = {
 	1000000, 1200000, 1400000, 1600000, 1800000, 2000000, 2200000, 2400000,
 	2600000, 2800000, 3000000, 3200000, 3400000, 3600000, 3800000, 4000000
 };
 
-/* Current limits array (in uA) for merged BMEM and BIO.
-   Entry indexes corresponds to register values. */
+/*
+ * Current limits array (in uA) for merged BMEM and BIO.
+ * Entry indexes corresponds to register values.
+ */
 static const unsigned int da9063_bmem_bio_merged_limits[] = {
 	3000000, 3200000, 3400000, 3600000, 3800000, 4000000, 4200000, 4400000,
 	4600000, 4800000, 5000000, 5200000, 5400000, 5600000, 5800000, 6000000
 };
 
-static int da9063_buck_set_mode(struct regulator_dev *rdev, unsigned mode)
+static int da9063_buck_set_mode(struct regulator_dev *rdev, unsigned int mode)
 {
 	struct da9063_regulator *regl = rdev_get_drvdata(rdev);
-	unsigned val;
+	unsigned int val;
 
 	switch (mode) {
 	case REGULATOR_MODE_FAST:
@@ -221,7 +229,7 @@ static int da9063_buck_set_mode(struct regulator_dev *rdev, unsigned mode)
  * There are 3 modes to map to: FAST, NORMAL, and STANDBY.
  */
 
-static unsigned da9063_buck_get_mode(struct regulator_dev *rdev)
+static unsigned int da9063_buck_get_mode(struct regulator_dev *rdev)
 {
 	struct da9063_regulator *regl = rdev_get_drvdata(rdev);
 	struct regmap_field *field;
@@ -271,10 +279,10 @@ static unsigned da9063_buck_get_mode(struct regulator_dev *rdev)
  * There are 2 modes to map to: NORMAL and STANDBY (sleep) for each state.
  */
 
-static int da9063_ldo_set_mode(struct regulator_dev *rdev, unsigned mode)
+static int da9063_ldo_set_mode(struct regulator_dev *rdev, unsigned int mode)
 {
 	struct da9063_regulator *regl = rdev_get_drvdata(rdev);
-	unsigned val;
+	unsigned int val;
 
 	switch (mode) {
 	case REGULATOR_MODE_NORMAL:
@@ -290,7 +298,7 @@ static int da9063_ldo_set_mode(struct regulator_dev *rdev, unsigned mode)
 	return regmap_field_write(regl->sleep, val);
 }
 
-static unsigned da9063_ldo_get_mode(struct regulator_dev *rdev)
+static unsigned int da9063_ldo_get_mode(struct regulator_dev *rdev)
 {
 	struct da9063_regulator *regl = rdev_get_drvdata(rdev);
 	struct regmap_field *field;
@@ -383,7 +391,8 @@ static int da9063_suspend_disable(struct regulator_dev *rdev)
 	return regmap_field_write(regl->suspend, 0);
 }
 
-static int da9063_buck_set_suspend_mode(struct regulator_dev *rdev, unsigned mode)
+static int da9063_buck_set_suspend_mode(struct regulator_dev *rdev,
+				unsigned int mode)
 {
 	struct da9063_regulator *regl = rdev_get_drvdata(rdev);
 	int val;
@@ -405,10 +414,11 @@ static int da9063_buck_set_suspend_mode(struct regulator_dev *rdev, unsigned mod
 	return regmap_field_write(regl->mode, val);
 }
 
-static int da9063_ldo_set_suspend_mode(struct regulator_dev *rdev, unsigned mode)
+static int da9063_ldo_set_suspend_mode(struct regulator_dev *rdev,
+				unsigned int mode)
 {
 	struct da9063_regulator *regl = rdev_get_drvdata(rdev);
-	unsigned val;
+	unsigned int val;
 
 	switch (mode) {
 	case REGULATOR_MODE_NORMAL:
@@ -593,7 +603,7 @@ static irqreturn_t da9063_ldo_lim_event(int irq, void *data)
 	struct da9063_regulators *regulators = data;
 	struct da9063 *hw = regulators->regulator[0].hw;
 	struct da9063_regulator *regl;
-	int bits, i , ret;
+	int bits, i, ret;
 
 	ret = regmap_read(hw->regmap, DA9063_REG_STATUS_D, &bits);
 	if (ret < 0)
@@ -605,10 +615,10 @@ static irqreturn_t da9063_ldo_lim_event(int irq, void *data)
 			continue;
 
 		if (BIT(regl->info->oc_event.lsb) & bits) {
-		        regulator_lock(regl->rdev);
+			regulator_lock(regl->rdev);
 			regulator_notifier_call_chain(regl->rdev,
 					REGULATOR_EVENT_OVER_CURRENT, NULL);
-		        regulator_unlock(regl->rdev);
+			regulator_unlock(regl->rdev);
 		}
 	}
 
@@ -833,7 +843,7 @@ static int da9063_regulator_probe(struct platform_device *pdev)
 
 		if (regl->info->suspend_sleep.reg) {
 			regl->suspend_sleep = devm_regmap_field_alloc(&pdev->dev,
-					da9063->regmap, regl->info->suspend_sleep);
+				da9063->regmap, regl->info->suspend_sleep);
 			if (IS_ERR(regl->suspend_sleep))
 				return PTR_ERR(regl->suspend_sleep);
 		}
-- 
2.20.1

