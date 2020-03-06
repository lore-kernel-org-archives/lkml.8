Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988C8C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 15:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 712D22084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 15:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583507034;
	bh=FY3u+WV0GytbAi8I5Sv52VY+RDCRUhthWj0EhuBZIm4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=QVuakoSb4+kBQV++Xf9GPG+0CZHzaaTl8DdtGo+EKYcFTLRpZRNiOVg2no7g/7uWy
	 DeJxSnaFAj1+pndHw2wGkvrm3I3IzA0CMl5KXL+HVqmWXDb8m1AheqD75qyTgNsOPX
	 8ISjPeJ0QGq/56PQYsEPQTHMZxX6jgO8yIuA9o1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgCFPDx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 10:03:53 -0500
Received: from foss.arm.com ([217.140.110.172]:35212 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgCFPDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 10:03:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49A1E30E;
        Fri,  6 Mar 2020 07:03:52 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C21B63F237;
        Fri,  6 Mar 2020 07:03:51 -0800 (PST)
Date:   Fri, 06 Mar 2020 15:03:50 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wcd934x: fix High Accuracy Buck enable" to the asoc tree
In-Reply-To:  <20200306132806.19684-2-srinivas.kandagatla@linaro.org>
Message-Id:  <applied-20200306132806.19684-2-srinivas.kandagatla@linaro.org>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: wcd934x: fix High Accuracy Buck enable

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From 820766c1e16651b46bfb771afae8d789da1986cf Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Fri, 6 Mar 2020 13:28:05 +0000
Subject: [PATCH] ASoC: wcd934x: fix High Accuracy Buck enable

High Accuracy buck is not applicable when we use RCO Band Gap source,
so move it back to correct place.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20200306132806.19684-2-srinivas.kandagatla@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wcd934x.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index aefaadfba8a1..83d643a07775 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -1202,11 +1202,6 @@ static int wcd934x_set_sido_input_src(struct wcd934x_codec *wcd, int sido_src)
 		regmap_update_bits(wcd->regmap, WCD934X_ANA_RCO,
 				   WCD934X_ANA_RCO_BG_EN_MASK, 0);
 		usleep_range(100, 110);
-	} else if (sido_src == SIDO_SOURCE_RCO_BG) {
-		regmap_update_bits(wcd->regmap, WCD934X_ANA_RCO,
-				   WCD934X_ANA_RCO_BG_EN_MASK,
-				   WCD934X_ANA_RCO_BG_ENABLE);
-		usleep_range(100, 110);
 		regmap_update_bits(wcd->regmap, WCD934X_ANA_BUCK_CTL,
 				   WCD934X_ANA_BUCK_PRE_EN1_MASK,
 				   WCD934X_ANA_BUCK_PRE_EN1_ENABLE);
@@ -1219,6 +1214,11 @@ static int wcd934x_set_sido_input_src(struct wcd934x_codec *wcd, int sido_src)
 				   WCD934X_ANA_BUCK_HI_ACCU_EN_MASK,
 				   WCD934X_ANA_BUCK_HI_ACCU_ENABLE);
 		usleep_range(100, 110);
+	} else if (sido_src == SIDO_SOURCE_RCO_BG) {
+		regmap_update_bits(wcd->regmap, WCD934X_ANA_RCO,
+				   WCD934X_ANA_RCO_BG_EN_MASK,
+				   WCD934X_ANA_RCO_BG_ENABLE);
+		usleep_range(100, 110);
 	}
 	wcd->sido_input_src = sido_src;
 
-- 
2.20.1

