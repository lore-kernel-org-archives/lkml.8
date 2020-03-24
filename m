Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47958C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6E620774
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585068760;
	bh=m3Z+53mzM3UV6WJ6Vdwrpv06/Gdrmrk0ZMMTj6vnQw0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=wU4D6uO6pny5ilWNU9iLMHlYYQuv+azYGl+gmFJp9LmlsXLDpQW24WrE75bAuGssg
	 ykCI3eDj+fc0kq73FGS/tJrRVeDgthANB/qxT+p53YCJY2BAvAbGvb8RhaFxvoblRC
	 aPAYhjVCIVSHG/ivh1976qzbXp6YB8zLtBwrpB8E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgCXQwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:52:38 -0400
Received: from foss.arm.com ([217.140.110.172]:38244 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727303AbgCXQwi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:52:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE2D31FB;
        Tue, 24 Mar 2020 09:52:37 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A74A3F71F;
        Tue, 24 Mar 2020 09:52:37 -0700 (PDT)
Date:   Tue, 24 Mar 2020 16:52:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Applied "regulator: da9063: Fix get_mode() functions to read sleep field" to the regulator tree
In-Reply-To:  <20200324092516.60B5C3FB8D@swsrvapps-01.diasemi.com>
Message-Id:  <applied-20200324092516.60B5C3FB8D@swsrvapps-01.diasemi.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: da9063: Fix get_mode() functions to read sleep field

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

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

From fc69bab1ec382d16210ef6bb2d3f117a37169de2 Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Tue, 24 Mar 2020 09:25:16 +0000
Subject: [PATCH] regulator: da9063: Fix get_mode() functions to read sleep
 field

get_mode() is used to retrieve the active mode state. Settings-A
config is used during active state, whilst Settings-B is for
suspend. This means we only need to check the sleep field of each
buck and LDO as that field solely relates to Settings-A config.

This change is a clone of the get_mode() update which was committed
as part of:
 - regulator: da9062: fix suspend_enable/disable preparation
   [a72865f057820ea9f57597915da4b651d65eb92f]

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Link: https://lore.kernel.org/r/20200324092516.60B5C3FB8D@swsrvapps-01.diasemi.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/da9063-regulator.c | 28 ++--------------------------
 1 file changed, 2 insertions(+), 26 deletions(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 46b7301efcd6..6d07e6864173 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -226,7 +226,6 @@ static int da9063_buck_set_mode(struct regulator_dev *rdev, unsigned mode)
 static unsigned da9063_buck_get_mode(struct regulator_dev *rdev)
 {
 	struct da9063_regulator *regl = rdev_get_drvdata(rdev);
-	struct regmap_field *field;
 	unsigned int val;
 	int ret;
 
@@ -247,18 +246,7 @@ static unsigned da9063_buck_get_mode(struct regulator_dev *rdev)
 		return REGULATOR_MODE_NORMAL;
 	}
 
-	/* Detect current regulator state */
-	ret = regmap_field_read(regl->suspend, &val);
-	if (ret < 0)
-		return 0;
-
-	/* Read regulator mode from proper register, depending on state */
-	if (val)
-		field = regl->suspend_sleep;
-	else
-		field = regl->sleep;
-
-	ret = regmap_field_read(field, &val);
+	ret = regmap_field_read(regl->sleep, &val);
 	if (ret < 0)
 		return 0;
 
@@ -295,21 +283,9 @@ static int da9063_ldo_set_mode(struct regulator_dev *rdev, unsigned mode)
 static unsigned da9063_ldo_get_mode(struct regulator_dev *rdev)
 {
 	struct da9063_regulator *regl = rdev_get_drvdata(rdev);
-	struct regmap_field *field;
 	int ret, val;
 
-	/* Detect current regulator state */
-	ret = regmap_field_read(regl->suspend, &val);
-	if (ret < 0)
-		return 0;
-
-	/* Read regulator mode from proper register, depending on state */
-	if (val)
-		field = regl->suspend_sleep;
-	else
-		field = regl->sleep;
-
-	ret = regmap_field_read(field, &val);
+	ret = regmap_field_read(regl->sleep, &val);
 	if (ret < 0)
 		return 0;
 
-- 
2.20.1

