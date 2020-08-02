Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A679EC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 09:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D697206F6
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 09:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="AbZWqsMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgHBJHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 05:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgHBJHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 05:07:02 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A150DC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 02:07:02 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y206so6335367pfb.10
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 02:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IwkEo+Y+nNktkFgA0PKMVU3fk9mleArWbJu+Ey7ijyo=;
        b=AbZWqsMz+j4O0ISeWj16aznaw7YuLorvfMagV0vvoXCz7Qki3G7lBG1Om+DNv2g03i
         O7kWLhzuw3asVdVpFKOIdrE6Yf9PpzHzjIg7OMp1NtRZ5LXPpmv1j4WcBj8WXniim4CH
         U3RYWEiOgKSnYWk7IjIpBeU9NzlJ/JCKdZnZhigjnsqqSsCiUa8i/TegWAyCfVMzt6UZ
         Ln0rojcH8rmbVzkmj+Gb4nD/xeVUlJNIG+7CnEFjlFDEkzwL7sZ45LnB4sniA0NbFRmS
         9pHGm/fxE2KHOwReZNWVFTn4vdHjfFSJswfGYA3Jz/fWyMKAtwv586SbRQFtBhcrL8Xy
         dxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IwkEo+Y+nNktkFgA0PKMVU3fk9mleArWbJu+Ey7ijyo=;
        b=Ab9m+5I44CTfxXKkDq96WvAkG6UY5eg6RO73QHJM7R77241rokzublwCUk3mvsBcJ5
         6ICFZukUfbArcRlCrtwD67Qb5yQgP6vWbYpguQV57xtEgQOeLQekTRmTdFtDMi0rM+TE
         hUk432lkzmGynU6sBbIg7uHByF1OegWDDlYuPTIN7bS/qDG9ne4fgdvxQ/4sHRCYoFN5
         +8Gn5adW37JGvIx3PsKZc/VnhRq4t9wwoMWE0bTKW64Wg/PsBOPBtXFE4Aib6VY3tOue
         UlDLZbEu7w3OUeyIZ4xKhNZa5rpmrfU4xVKrVuf8FHNgVTlNI+rlGGzFDrHz50Nbsma5
         TmMQ==
X-Gm-Message-State: AOAM531c/0Glipd5TSR9kOx8KN1Afag9drsO6wAnuvkOO1CpNEthpzp6
        5QNkGWihwb10zrkIZvXQeyWCMw==
X-Google-Smtp-Source: ABdhPJyqjWG+ZsxkjYQTgNv9OyVN0bFZwRKSbGlXZC1lo/gaUPCB5JCRfZow/zJy6xAFDq9uRIElmg==
X-Received: by 2002:a62:15d3:: with SMTP id 202mr10939698pfv.326.1596359221658;
        Sun, 02 Aug 2020 02:07:01 -0700 (PDT)
Received: from localhost.localdomain (36-239-219-92.dynamic-ip.hinet.net. [36.239.219.92])
        by smtp.gmail.com with ESMTPSA id e125sm11041630pfh.69.2020.08.02.02.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 02:07:00 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Daniel Jeong <gshark.jeong@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: lp8755: Get rid of lp8755_read/lp8755_write/lp8755_update_bits
Date:   Sun,  2 Aug 2020 17:06:38 +0800
Message-Id: <20200802090638.380589-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just use regmap_read/regmap_write/regmap_update_bits instead.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/lp8755.c | 82 ++++++++++----------------------------
 1 file changed, 21 insertions(+), 61 deletions(-)

diff --git a/drivers/regulator/lp8755.c b/drivers/regulator/lp8755.c
index 4291df077c39..8cc9963023f2 100644
--- a/drivers/regulator/lp8755.c
+++ b/drivers/regulator/lp8755.c
@@ -49,53 +49,15 @@ struct lp8755_chip {
 	struct regulator_dev *rdev[LP8755_BUCK_MAX];
 };
 
-/**
- *lp8755_read : read a single register value from lp8755.
- *@pchip : device to read from
- *@reg   : register to read from
- *@val   : pointer to store read value
- */
-static int lp8755_read(struct lp8755_chip *pchip, unsigned int reg,
-		       unsigned int *val)
-{
-	return regmap_read(pchip->regmap, reg, val);
-}
-
-/**
- *lp8755_write : write a single register value to lp8755.
- *@pchip : device to write to
- *@reg   : register to write to
- *@val   : value to be written
- */
-static int lp8755_write(struct lp8755_chip *pchip, unsigned int reg,
-			unsigned int val)
-{
-	return regmap_write(pchip->regmap, reg, val);
-}
-
-/**
- *lp8755_update_bits : set the values of bit fields in lp8755 register.
- *@pchip : device to read from
- *@reg   : register to update
- *@mask  : bitmask to be changed
- *@val   : value for bitmask
- */
-static int lp8755_update_bits(struct lp8755_chip *pchip, unsigned int reg,
-			      unsigned int mask, unsigned int val)
-{
-	return regmap_update_bits(pchip->regmap, reg, mask, val);
-}
-
 static int lp8755_buck_enable_time(struct regulator_dev *rdev)
 {
 	int ret;
 	unsigned int regval;
 	enum lp8755_bucks id = rdev_get_id(rdev);
-	struct lp8755_chip *pchip = rdev_get_drvdata(rdev);
 
-	ret = lp8755_read(pchip, 0x12 + id, &regval);
+	ret = regmap_read(rdev->regmap, 0x12 + id, &regval);
 	if (ret < 0) {
-		dev_err(pchip->dev, "i2c access error %s\n", __func__);
+		dev_err(&rdev->dev, "i2c access error %s\n", __func__);
 		return ret;
 	}
 	return (regval & 0xff) * 100;
@@ -115,17 +77,17 @@ static int lp8755_buck_set_mode(struct regulator_dev *rdev, unsigned int mode)
 		break;
 	case REGULATOR_MODE_NORMAL:
 		/* enable automatic pwm/pfm mode */
-		ret = lp8755_update_bits(pchip, 0x08 + id, 0x20, 0x00);
+		ret = regmap_update_bits(rdev->regmap, 0x08 + id, 0x20, 0x00);
 		if (ret < 0)
 			goto err_i2c;
 		break;
 	case REGULATOR_MODE_IDLE:
 		/* enable automatic pwm/pfm/lppfm mode */
-		ret = lp8755_update_bits(pchip, 0x08 + id, 0x20, 0x20);
+		ret = regmap_update_bits(rdev->regmap, 0x08 + id, 0x20, 0x20);
 		if (ret < 0)
 			goto err_i2c;
 
-		ret = lp8755_update_bits(pchip, 0x10, 0x01, 0x01);
+		ret = regmap_update_bits(rdev->regmap, 0x10, 0x01, 0x01);
 		if (ret < 0)
 			goto err_i2c;
 		break;
@@ -135,12 +97,12 @@ static int lp8755_buck_set_mode(struct regulator_dev *rdev, unsigned int mode)
 		regbval = (0x01 << id);
 	}
 
-	ret = lp8755_update_bits(pchip, 0x06, 0x01 << id, regbval);
+	ret = regmap_update_bits(rdev->regmap, 0x06, 0x01 << id, regbval);
 	if (ret < 0)
 		goto err_i2c;
 	return ret;
 err_i2c:
-	dev_err(pchip->dev, "i2c access error %s\n", __func__);
+	dev_err(&rdev->dev, "i2c access error %s\n", __func__);
 	return ret;
 }
 
@@ -149,9 +111,8 @@ static unsigned int lp8755_buck_get_mode(struct regulator_dev *rdev)
 	int ret;
 	unsigned int regval;
 	enum lp8755_bucks id = rdev_get_id(rdev);
-	struct lp8755_chip *pchip = rdev_get_drvdata(rdev);
 
-	ret = lp8755_read(pchip, 0x06, &regval);
+	ret = regmap_read(rdev->regmap, 0x06, &regval);
 	if (ret < 0)
 		goto err_i2c;
 
@@ -159,7 +120,7 @@ static unsigned int lp8755_buck_get_mode(struct regulator_dev *rdev)
 	if (regval & (0x01 << id))
 		return REGULATOR_MODE_FAST;
 
-	ret = lp8755_read(pchip, 0x08 + id, &regval);
+	ret = regmap_read(rdev->regmap, 0x08 + id, &regval);
 	if (ret < 0)
 		goto err_i2c;
 
@@ -171,7 +132,7 @@ static unsigned int lp8755_buck_get_mode(struct regulator_dev *rdev)
 	return REGULATOR_MODE_NORMAL;
 
 err_i2c:
-	dev_err(pchip->dev, "i2c access error %s\n", __func__);
+	dev_err(&rdev->dev, "i2c access error %s\n", __func__);
 	return 0;
 }
 
@@ -180,7 +141,6 @@ static int lp8755_buck_set_ramp(struct regulator_dev *rdev, int ramp)
 	int ret;
 	unsigned int regval = 0x00;
 	enum lp8755_bucks id = rdev_get_id(rdev);
-	struct lp8755_chip *pchip = rdev_get_drvdata(rdev);
 
 	/* uV/us */
 	switch (ramp) {
@@ -209,17 +169,17 @@ static int lp8755_buck_set_ramp(struct regulator_dev *rdev, int ramp)
 		regval = 0x00;
 		break;
 	default:
-		dev_err(pchip->dev,
+		dev_err(&rdev->dev,
 			"Not supported ramp value %d %s\n", ramp, __func__);
 		return -EINVAL;
 	}
 
-	ret = lp8755_update_bits(pchip, 0x07 + id, 0x07, regval);
+	ret = regmap_update_bits(rdev->regmap, 0x07 + id, 0x07, regval);
 	if (ret < 0)
 		goto err_i2c;
 	return ret;
 err_i2c:
-	dev_err(pchip->dev, "i2c access error %s\n", __func__);
+	dev_err(&rdev->dev, "i2c access error %s\n", __func__);
 	return ret;
 }
 
@@ -278,7 +238,7 @@ static int lp8755_init_data(struct lp8755_chip *pchip)
 	struct lp8755_platform_data *pdata = pchip->pdata;
 
 	/* read back  muti-phase configuration */
-	ret = lp8755_read(pchip, 0x3D, &regval);
+	ret = regmap_read(pchip->regmap, 0x3D, &regval);
 	if (ret < 0)
 		goto out_i2c_error;
 	pchip->mphase = regval & 0x0F;
@@ -356,11 +316,11 @@ static irqreturn_t lp8755_irq_handler(int irq, void *data)
 	struct lp8755_chip *pchip = data;
 
 	/* read flag0 register */
-	ret = lp8755_read(pchip, 0x0D, &flag0);
+	ret = regmap_read(pchip->regmap, 0x0D, &flag0);
 	if (ret < 0)
 		goto err_i2c;
 	/* clear flag register to pull up int. pin */
-	ret = lp8755_write(pchip, 0x0D, 0x00);
+	ret = regmap_write(pchip->regmap, 0x0D, 0x00);
 	if (ret < 0)
 		goto err_i2c;
 
@@ -377,11 +337,11 @@ static irqreturn_t lp8755_irq_handler(int irq, void *data)
 		}
 
 	/* read flag1 register */
-	ret = lp8755_read(pchip, 0x0E, &flag1);
+	ret = regmap_read(pchip->regmap, 0x0E, &flag1);
 	if (ret < 0)
 		goto err_i2c;
 	/* clear flag register to pull up int. pin */
-	ret = lp8755_write(pchip, 0x0E, 0x00);
+	ret = regmap_write(pchip->regmap, 0x0E, 0x00);
 	if (ret < 0)
 		goto err_i2c;
 
@@ -423,7 +383,7 @@ static int lp8755_int_config(struct lp8755_chip *pchip)
 		return 0;
 	}
 
-	ret = lp8755_read(pchip, 0x0F, &regval);
+	ret = regmap_read(pchip->regmap, 0x0F, &regval);
 	if (ret < 0) {
 		dev_err(pchip->dev, "i2c access error %s\n", __func__);
 		return ret;
@@ -502,7 +462,7 @@ static int lp8755_probe(struct i2c_client *client,
 err:
 	/* output disable */
 	for (icnt = 0; icnt < LP8755_BUCK_MAX; icnt++)
-		lp8755_write(pchip, icnt, 0x00);
+		regmap_write(pchip->regmap, icnt, 0x00);
 
 	return ret;
 }
@@ -513,7 +473,7 @@ static int lp8755_remove(struct i2c_client *client)
 	struct lp8755_chip *pchip = i2c_get_clientdata(client);
 
 	for (icnt = 0; icnt < LP8755_BUCK_MAX; icnt++)
-		lp8755_write(pchip, icnt, 0x00);
+		regmap_write(pchip->regmap, icnt, 0x00);
 
 	return 0;
 }
-- 
2.25.1

