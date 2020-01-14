Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8452BC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4C9222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579018223;
	bh=8crW1OAi6MSweKEuuQl46Dary7LFxeaOKeVvRa1JGUw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=PgvU9mEinHtHQnouteptiTrtMBIjZ/NlS/YhPMEbnkWroRFeU1iHgP0YneSZYoK4S
	 4H1aI2RWsVxXf7sfEn4yp7CpivRqHhJIpH8X61viH3c/tkEFVvzMflSr0zYnY2yvqL
	 rQqeKQNfTF/4CNvEzaRxRCCpEPY3xvfBq22zGT1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgANQKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 11:10:22 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37472 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728924AbgANQJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:09:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=sUkVs/vQmUNKNub3sETR9FpuLNm+g8pTLv6JEXdmdpw=; b=Kmh+aKkTxGXP
        QYYESH5uaK9Qx7CymklJ8A4pxAEhOc0akcBYjDAzrs8hhhZxPHphgu/Or2z/ApepdPg/XboCnOTYP
        QZUUmaSOzKQ8Gtfrm+LslPR2LGl3Fb/+NB5ssu4gf5AMG4zzNcHDFbyxNGrkWMq8FzLuY4tGCLCG0
        Os36k=;
Received: from fw-tnat-cam7.arm.com ([217.140.106.55] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1irOkp-0001YX-Uj; Tue, 14 Jan 2020 16:09:19 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id A497AD02C7C; Tue, 14 Jan 2020 16:09:19 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: Applied "regulator: mpq7920: Remove unneeded fields from struct mpq7920_regulator_info" to the regulator tree
In-Reply-To: <20200114124449.28408-1-axel.lin@ingics.com>
Message-Id: <applied-20200114124449.28408-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Date:   Tue, 14 Jan 2020 16:09:19 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: mpq7920: Remove unneeded fields from struct mpq7920_regulator_info

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.6

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

From 489d6954acabe71d22ba0033fe85822742364915 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 14 Jan 2020 20:44:48 +0800
Subject: [PATCH] regulator: mpq7920: Remove unneeded fields from struct
 mpq7920_regulator_info

Both *dev and *rdev are only used in .probe, so use local variable instead.
Also remove mpq7920_regulator_register() because it is so trivial and
there is only one caller.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Link: https://lore.kernel.org/r/20200114124449.28408-1-axel.lin@ingics.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/mpq7920.c | 41 ++++++++++++-------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/drivers/regulator/mpq7920.c b/drivers/regulator/mpq7920.c
index 80f3131f0d1b..b133bab514a9 100644
--- a/drivers/regulator/mpq7920.c
+++ b/drivers/regulator/mpq7920.c
@@ -92,9 +92,7 @@ enum mpq7920_regulators {
 };
 
 struct mpq7920_regulator_info {
-	struct device *dev;
 	struct regmap *regmap;
-	struct regulator_dev *rdev[MPQ7920_MAX_REGULATORS];
 	struct regulator_desc *rdesc;
 };
 
@@ -262,40 +260,21 @@ static void mpq7920_parse_dt(struct device *dev,
 	of_node_put(np);
 }
 
-static inline int mpq7920_regulator_register(
-				struct mpq7920_regulator_info *info,
-				struct regulator_config *config)
-{
-	int i;
-	struct regulator_desc *rdesc;
-
-	for (i = 0; i < MPQ7920_MAX_REGULATORS; i++) {
-		rdesc = &info->rdesc[i];
-
-		info->rdev[i] = devm_regulator_register(info->dev, rdesc,
-					 config);
-		if (IS_ERR(info->rdev[i]))
-			return PTR_ERR(info->rdev[i]);
-	}
-
-	return 0;
-}
-
 static int mpq7920_i2c_probe(struct i2c_client *client,
 				    const struct i2c_device_id *id)
 {
 	struct device *dev = &client->dev;
 	struct mpq7920_regulator_info *info;
 	struct regulator_config config = { NULL, };
+	struct regulator_dev *rdev;
 	struct regmap *regmap;
-	int ret;
+	int i;
 
 	info = devm_kzalloc(dev, sizeof(struct mpq7920_regulator_info),
 				GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
-	info->dev = dev;
 	info->rdesc = mpq7920_regulators_desc;
 	regmap = devm_regmap_init_i2c(client, &mpq7920_regmap_config);
 	if (IS_ERR(regmap)) {
@@ -308,15 +287,21 @@ static int mpq7920_i2c_probe(struct i2c_client *client,
 	if (client->dev.of_node)
 		mpq7920_parse_dt(&client->dev, info);
 
-	config.dev = info->dev;
+	config.dev = dev;
 	config.regmap = regmap;
 	config.driver_data = info;
 
-	ret = mpq7920_regulator_register(info, &config);
-	if (ret < 0)
-		dev_err(dev, "Failed to register regulator!\n");
+	for (i = 0; i < MPQ7920_MAX_REGULATORS; i++) {
+		rdev = devm_regulator_register(dev,
+					       &mpq7920_regulators_desc[i],
+					       &config);
+		if (IS_ERR(rdev)) {
+			dev_err(dev, "Failed to register regulator!\n");
+			return PTR_ERR(rdev);
+		}
+	}
 
-	return ret;
+	return 0;
 }
 
 static const struct of_device_id mpq7920_of_match[] = {
-- 
2.20.1

