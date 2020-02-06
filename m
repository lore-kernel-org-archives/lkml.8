Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C54C352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 04:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74ED220720
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 04:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCagjpxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgBFEgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 23:36:17 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44271 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbgBFEgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 23:36:17 -0500
Received: by mail-pl1-f195.google.com with SMTP id d9so1789341plo.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 20:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gPdvdOINV5KdEbblXYq9Y9a8LB18bMVj3SYD6IoaOG4=;
        b=eCagjpxLstAkSeNbFvjIaE9E7HMKm3eiG6pIY5P0mAmo/+C6Z5+oRIiiGfeqsSUoRh
         DoLKmf0jrEz/j1of418zOBLAXTlaBIbLuox3JpuHIPwrnhui+mZkWD3qqo12Yqr9wERg
         buTGEMNt4VO0o+xWEODcenUB/95+sgHuQFJWVWeii23RonPL/+LtKdPfhZdIiY1zJA13
         dK5s/Mj60FwMuXjhnb1jxJGUzuU3Aqi608iEOJDAd16L2wamZiVaA2nDqkJvu5sohiOn
         PIdw5EWfzQf92k/SqkVz2n5o9997Sw44STpI2euWG12J7ZnLBoN9O6DZhiKB+HxkuZnF
         R/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gPdvdOINV5KdEbblXYq9Y9a8LB18bMVj3SYD6IoaOG4=;
        b=LJz7XF+Y7eUnvzxG15wj4WMQpqnDJTff90mtX5yV7Tc0ZKWuws9x/QJQp6dNfemHyF
         4O2KiwESFgeyb68P6BmwKNiZGRmuDMBT+/zQKYGoBcSTe3EzD2YZ6udyJeesA44MfJJb
         EFLXfXyxRupIb0/jngfvDzzggGh4b5re21ssI6gaehd+IhCzLjFncd1l6lTHWcDFe6WV
         V1lK5lNsSbtfPVkO7erwfsMqojVy1Fy+Ac8lM7Dr9U8E9eg/tmugDrC60vEmMvl65OwS
         L1yLKmiGuuC4192PGDwsp7RvKgSjmCxqJDJC70NH/5Xl3NmmZlRLVEFKER2qdTNVypUr
         PCXw==
X-Gm-Message-State: APjAAAWvgTmQjy/GNHcbkt1KKaR0gOQyR9SLiZGjzzvC4YPFRMGwJvFr
        JHfFa00tOznI3K0yblwTUQc=
X-Google-Smtp-Source: APXvYqwRQZ3py5dPOwgEdHma0ZSKzj/+uH32+uloyAUk34j744jTMB/XQ7Ca2Y8oK/cMKRDShQ4ejA==
X-Received: by 2002:a17:902:b78b:: with SMTP id e11mr1765027pls.129.1580963776304;
        Wed, 05 Feb 2020 20:36:16 -0800 (PST)
Received: from localhost.localdomain ([49.207.56.20])
        by smtp.gmail.com with ESMTPSA id ci5sm1295454pjb.5.2020.02.05.20.36.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Feb 2020 20:36:15 -0800 (PST)
From:   Rishi Gupta <gupt21@gmail.com>
To:     support.opensource@diasemi.com, Adam.Thomson.Opensource@diasemi.com
Cc:     axel.lin@ingics.com, lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH] regulator: da9063: remove redundant return statement
Date:   Thu,  6 Feb 2020 10:06:01 +0530
Message-Id: <1580963761-24964-1-git-send-email-gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_request_threaded_irq() already returns 0 on success
and negative error code on failure. So return from this itself
can be used while preserving error log in case of failure.

This commit also fixes checkpatch.pl errors & warnings:
- WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
- WARNING: line over 80 characters
- ERROR: space prohibited before that ',' (ctx:WxW)
- ERROR: code indent should use tabs where possible
- WARNING: Block comments use * on subsequent lines

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
---
 drivers/regulator/da9063-regulator.c | 64 ++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 28 deletions(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 2aceb3b..aaa9942 100644
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
@@ -867,12 +877,10 @@ static int da9063_regulator_probe(struct platform_device *pdev)
 				NULL, da9063_ldo_lim_event,
 				IRQF_TRIGGER_LOW | IRQF_ONESHOT,
 				"LDO_LIM", regulators);
-	if (ret) {
+	if (ret)
 		dev_err(&pdev->dev, "Failed to request LDO_LIM IRQ.\n");
-		return ret;
-	}
 
-	return 0;
+	return ret;
 }
 
 static struct platform_driver da9063_regulator_driver = {
-- 
2.7.4

