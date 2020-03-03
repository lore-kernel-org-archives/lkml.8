Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC94AC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8623D20870
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583255294;
	bh=JX+qYb6OOGojM/R1LEfPEZpjwInAUG9E0ZibHGRdrnc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=OTtBueczZ7bz4X5F91kcebd9KGG/9IakxzhI2cAPs7lnJhblrhBsXRTJIswdRyLQq
	 rJl/Wl02JBDWZTOCKvAmI5YHFY1Qn41ftnTrpwrVDzaGAte55LWEXHL6VflL6X+Rtg
	 jI9NmjM6x6aOM5ZONGDPkPj+ruwdq2WYfyRMglKw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbgCCRIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:08:13 -0500
Received: from foss.arm.com ([217.140.110.172]:49984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730600AbgCCRIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:08:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E899C2F;
        Tue,  3 Mar 2020 09:08:12 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C57A3F534;
        Tue,  3 Mar 2020 09:08:12 -0800 (PST)
Date:   Tue, 03 Mar 2020 17:08:10 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, Linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regulator: anatop: Lower error message level for -EPROBE_DEFER" to the regulator tree
In-Reply-To:  <1583243052-1930-1-git-send-email-Anson.Huang@nxp.com>
Message-Id:  <applied-1583243052-1930-1-git-send-email-Anson.Huang@nxp.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: anatop: Lower error message level for -EPROBE_DEFER

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

From 788bfc6eb6912df40a31245566b3e5c99ea7a66a Mon Sep 17 00:00:00 2001
From: Anson Huang <Anson.Huang@nxp.com>
Date: Tue, 3 Mar 2020 21:44:12 +0800
Subject: [PATCH] regulator: anatop: Lower error message level for
 -EPROBE_DEFER

devm_regulator_register() could return -EPROBE_DEFER when trying to
get init data and NOT all resources are available at that time, for
this case, error message is better to be present for debug level ONLY.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Link: https://lore.kernel.org/r/1583243052-1930-1-git-send-email-Anson.Huang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/anatop-regulator.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/anatop-regulator.c b/drivers/regulator/anatop-regulator.c
index 754739d004e5..ca92b3de0e9c 100644
--- a/drivers/regulator/anatop-regulator.c
+++ b/drivers/regulator/anatop-regulator.c
@@ -305,9 +305,13 @@ static int anatop_regulator_probe(struct platform_device *pdev)
 	/* register regulator */
 	rdev = devm_regulator_register(dev, rdesc, &config);
 	if (IS_ERR(rdev)) {
-		dev_err(dev, "failed to register %s\n",
-			rdesc->name);
-		return PTR_ERR(rdev);
+		ret = PTR_ERR(rdev);
+		if (ret == -EPROBE_DEFER)
+			dev_dbg(dev, "failed to register %s, deferring...\n",
+				rdesc->name);
+		else
+			dev_err(dev, "failed to register %s\n", rdesc->name);
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, rdev);
-- 
2.20.1

