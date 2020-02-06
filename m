Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63929C352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3073721741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+Wwbu51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgBFNsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 08:48:54 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40021 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgBFNsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 08:48:54 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so2373258plp.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 05:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PnrmPaZpBi5m5KEILmjcjBqcpE9VbTD+DkXq6otLtF4=;
        b=U+Wwbu51+BZonYrOctnjCDPMYlV5ATPk9vCLD/TwvgwMZgMdNbDh5YwYDSpP/RMiFK
         u7Y3AlHSYgmmGuFXzQWumHixfZHf3EcOHLFyn/n8a94PfDPMq2pvtmqdgIFPbzi2P7yw
         gA8y59Xi19CT9EbL5i7ENeHbyX/SBQo1oVKXA6Rc2/1IcPNlHvtb1tEQhwDjxpxBapLW
         9wRipKc3eDDK9c1tJ8vR4DerYbej+s16C9uhwUgOBWhgYmZK9Sx1kLmoPeDFbeBcR2+s
         Uh6lyVDM/Kb57ecRjeosLiBEuSVKcpg5rC9SDviKipdlJ0DJoQZYDxqgDi01kvcbCoqk
         V/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PnrmPaZpBi5m5KEILmjcjBqcpE9VbTD+DkXq6otLtF4=;
        b=mLOXeAcJGDzrd6SSlFoTwBATJoV3Qjk0lIYhQlJPylwztzKSU+Znc8Vwv7PyTd8CHU
         fEoXcuRkxWE23He1aK66IE+gccX0UJKWQN3zAQSGmTuxG07C+b2AgeWTHzkzEg/UmLhw
         qgu2nilozetYyEnJu5vjmGPOJLEEY1aMGoDR6Le2dtkCtARW+OjV3Gv4fgy9kjBNLEv5
         nLjTbJ3Y/8PF7Kmab27ggywvVBEhZbrIrgoRRezQShZm6LDbSuhboX5XzXzbPOmrm1X9
         63Bcwn6Ot/POPMntDyA1U6er77iyCsGXB/X7Znn9MykZA85YSWiTzkYt6wl49pmTOOgV
         Ev0w==
X-Gm-Message-State: APjAAAXBn0aou/rvmb5z0Lha4jlhaX7FYxGwOpv4M5qllDw5Kj8Rh93l
        ZMlpbUO6AWbuq450O+TT6pI=
X-Google-Smtp-Source: APXvYqz5JhRDtKMxbIe8JJOAv1E/O3xYv8mRCdXxNNPUoVjPmbDCn+AOGCcZqPHKXWJeuFeAIaw1fw==
X-Received: by 2002:a17:90a:c24c:: with SMTP id d12mr4416965pjx.113.1580996933118;
        Thu, 06 Feb 2020 05:48:53 -0800 (PST)
Received: from localhost.localdomain ([49.207.56.20])
        by smtp.gmail.com with ESMTPSA id a21sm3818757pgd.12.2020.02.06.05.48.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Feb 2020 05:48:52 -0800 (PST)
From:   Rishi Gupta <gupt21@gmail.com>
To:     support.opensource@diasemi.com, Adam.Thomson.Opensource@diasemi.com
Cc:     axel.lin@ingics.com, lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH] regulator: da9063: fix code formatting warnings and errors
Date:   Thu,  6 Feb 2020 19:18:37 +0530
Message-Id: <1580996917-28494-1-git-send-email-gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes following errors & warnings in this driver
as reported by checkpatch.pl:

- WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
- WARNING: line over 80 characters
- ERROR: space prohibited before that ',' (ctx:WxW)
- ERROR: code indent should use tabs where possible
- WARNING: Block comments use * on subsequent lines

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
---
 drivers/regulator/da9063-regulator.c | 58 +++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 70554b0..aaa9942 100644
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
2.7.4

