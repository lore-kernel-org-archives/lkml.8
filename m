Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9698FC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 13:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701C620848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 13:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583414144;
	bh=KOksV8eVyBP8koJL1LGAUBzTM6x0CS5AIJrBtFiNDbc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=T0Xf3MyhDCCXFWZKNpvNsjTYqr8U7IeE0ugS7eyVoNmv1u6BeQ26LfSy9Rhhr8u1Y
	 fMmc2ZQLRZ4HjRWesl4PyW1fcWAvGEvQjZjDg4leB2hPoaIh1dctS/HSkdggKD6DnD
	 QZuXJp+YOTfC+0QV7SxZxquu1PCOU0ze7xV/S6XM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgCENPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 08:15:43 -0500
Received: from foss.arm.com ([217.140.110.172]:48432 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbgCENPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 08:15:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4EE04B2;
        Thu,  5 Mar 2020 05:15:42 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39CE13F6CF;
        Thu,  5 Mar 2020 05:15:42 -0800 (PST)
Date:   Thu, 05 Mar 2020 13:15:40 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: tlv320adcx140: Fix mic_bias and vref device tree verification" to the asoc tree
In-Reply-To:  <20200304193427.16886-1-dmurphy@ti.com>
Message-Id:  <applied-20200304193427.16886-1-dmurphy@ti.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: tlv320adcx140: Fix mic_bias and vref device tree verification

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

From 2e4249f58074ec93746df3a902d1835b7edfef49 Mon Sep 17 00:00:00 2001
From: Dan Murphy <dmurphy@ti.com>
Date: Wed, 4 Mar 2020 13:34:27 -0600
Subject: [PATCH] ASoC: tlv320adcx140: Fix mic_bias and vref device tree
 verification

Fix the range verification check for the mic_bias and vref device tree
entries.

Fixes 37bde5acf040 ("ASoC: tlv320adcx140: Add the tlv320adcx140 codec driver family")
Signed-off-by: Dan Murphy <dmurphy@ti.com>
Link: https://lore.kernel.org/r/20200304193427.16886-1-dmurphy@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320adcx140.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 93a0cb8e662c..38897568ee96 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -748,9 +748,8 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 	if (ret)
 		bias_source = ADCX140_MIC_BIAS_VAL_VREF;
 
-	if (bias_source != ADCX140_MIC_BIAS_VAL_VREF &&
-	    bias_source != ADCX140_MIC_BIAS_VAL_VREF_1096 &&
-	    bias_source != ADCX140_MIC_BIAS_VAL_AVDD) {
+	if (bias_source < ADCX140_MIC_BIAS_VAL_VREF ||
+	    bias_source > ADCX140_MIC_BIAS_VAL_AVDD) {
 		dev_err(adcx140->dev, "Mic Bias source value is invalid\n");
 		return -EINVAL;
 	}
@@ -760,9 +759,8 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 	if (ret)
 		vref_source = ADCX140_MIC_BIAS_VREF_275V;
 
-	if (vref_source != ADCX140_MIC_BIAS_VREF_275V &&
-	    vref_source != ADCX140_MIC_BIAS_VREF_25V &&
-	    vref_source != ADCX140_MIC_BIAS_VREF_1375V) {
+	if (vref_source < ADCX140_MIC_BIAS_VREF_275V ||
+	    vref_source > ADCX140_MIC_BIAS_VREF_1375V) {
 		dev_err(adcx140->dev, "Mic Bias source value is invalid\n");
 		return -EINVAL;
 	}
-- 
2.20.1

