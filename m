Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB056C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA50214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578928406;
	bh=sSmZRR/wZMtfYB0HeWO9KJTpYdrz75vnztJPs6g+PiI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=ZVDtBIdML4QGs4matrJ2lOX7zNIdQUAksTxJgdUgahaJ4Om487OKRMuOJrm/g16Vw
	 uQmb5lZnXj7+RKDxz4q79YbDoUYbZHoQ+AbMJGGVTqWnKss4GzURNXQCK8GmuTCjFn
	 Uu4wenzQyv4x+YpoAnjk9MzLk7gma1cNZp/VrAys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgAMPN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 10:13:26 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35788 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728984AbgAMPNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=tlixcOKneo9O/YYLNit+XgxZ/59MVwRcpvHUMhzFhK8=; b=canBesDYGQvh
        mP0iOfQh3HizOaT7JsXiEu4MjGeZ4GlBOlyG1Dlu2oHj8EdM9vnDL5RnHGJ6WhL0wKkAo2IVRj74n
        Y267WhG3i83kDdhqhNFOjS+kdaYHVM8nNpDyzExzpc43enaIG/hiObItsdsEoLlMjSEWTnS42LDB7
        1qsy8=;
Received: from fw-tnat-cam7.arm.com ([217.140.106.55] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ir1P8-0003NS-IZ; Mon, 13 Jan 2020 15:13:22 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 4ACE7D01965; Mon, 13 Jan 2020 15:13:22 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Applied "regulator: bd718x7: Simplify the code by removing struct bd718xx_pmic_inits" to the regulator tree
In-Reply-To: <20200108014256.11282-1-axel.lin@ingics.com>
Message-Id: <applied-20200108014256.11282-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Date:   Mon, 13 Jan 2020 15:13:22 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: bd718x7: Simplify the code by removing struct bd718xx_pmic_inits

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

From b389ceae4a8fa4c91dd3543516cdfd49ece7e4ba Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 8 Jan 2020 09:42:55 +0800
Subject: [PATCH] regulator: bd718x7: Simplify the code by removing struct
 bd718xx_pmic_inits

Nowdays ROHM_CHIP_TYPE_AMOUNT includes not only BD71837/BD71847 but also
BD70528/BD71828 which are not supported by this driver. So it seems not
necessay to have pmic_regulators[ROHM_CHIP_TYPE_AMOUNT] as mapping table.
Simplify the code by removing struct bd718xx_pmic_inits and
pmic_regulators[ROHM_CHIP_TYPE_AMOUNT].

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Link: https://lore.kernel.org/r/20200108014256.11282-1-axel.lin@ingics.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/bd718x7-regulator.c | 34 +++++++++++----------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index 13a43eee2e46..8f9b2d8eaf10 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -1142,28 +1142,14 @@ static const struct bd718xx_regulator_data bd71837_regulators[] = {
 	},
 };
 
-struct bd718xx_pmic_inits {
-	const struct bd718xx_regulator_data *r_datas;
-	unsigned int r_amount;
-};
-
 static int bd718xx_probe(struct platform_device *pdev)
 {
 	struct bd718xx *mfd;
 	struct regulator_config config = { 0 };
-	struct bd718xx_pmic_inits pmic_regulators[ROHM_CHIP_TYPE_AMOUNT] = {
-		[ROHM_CHIP_TYPE_BD71837] = {
-			.r_datas = bd71837_regulators,
-			.r_amount = ARRAY_SIZE(bd71837_regulators),
-		},
-		[ROHM_CHIP_TYPE_BD71847] = {
-			.r_datas = bd71847_regulators,
-			.r_amount = ARRAY_SIZE(bd71847_regulators),
-		},
-	};
-
 	int i, j, err;
 	bool use_snvs;
+	const struct bd718xx_regulator_data *reg_data;
+	unsigned int num_reg_data;
 
 	mfd = dev_get_drvdata(pdev->dev.parent);
 	if (!mfd) {
@@ -1172,8 +1158,16 @@ static int bd718xx_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	if (mfd->chip.chip_type >= ROHM_CHIP_TYPE_AMOUNT ||
-	    !pmic_regulators[mfd->chip.chip_type].r_datas) {
+	switch (mfd->chip.chip_type) {
+	case ROHM_CHIP_TYPE_BD71837:
+		reg_data = bd71837_regulators;
+		num_reg_data = ARRAY_SIZE(bd71837_regulators);
+		break;
+	case ROHM_CHIP_TYPE_BD71847:
+		reg_data = bd71847_regulators;
+		num_reg_data = ARRAY_SIZE(bd71847_regulators);
+		break;
+	default:
 		dev_err(&pdev->dev, "Unsupported chip type\n");
 		err = -EINVAL;
 		goto err;
@@ -1215,13 +1209,13 @@ static int bd718xx_probe(struct platform_device *pdev)
 		}
 	}
 
-	for (i = 0; i < pmic_regulators[mfd->chip.chip_type].r_amount; i++) {
+	for (i = 0; i < num_reg_data; i++) {
 
 		const struct regulator_desc *desc;
 		struct regulator_dev *rdev;
 		const struct bd718xx_regulator_data *r;
 
-		r = &pmic_regulators[mfd->chip.chip_type].r_datas[i];
+		r = &reg_data[i];
 		desc = &r->desc;
 
 		config.dev = pdev->dev.parent;
-- 
2.20.1

