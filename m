Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58ABEC2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292E12076F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585067829;
	bh=z57hpe1IUusb/CPgsearl2ftWvBEMroUg9OEgRAwMIs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=MwSVRwcB5nurv/A88pXELi8r2Pt3VD62VB4J5/drekr+hSBSE2tWajuRA4fdhfppD
	 L2ODqDbUgx93sgdaypFfqyKBZDRzkvbNQBOzD/z1R5Xhj7mIdof8/J74Agyv0U7XYu
	 +nA632S4+QrF8P75CSovM/2AKfMMOrxpMbcLxBJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgCXQhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:37:08 -0400
Received: from foss.arm.com ([217.140.110.172]:38054 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbgCXQhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:37:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EAFF1FB;
        Tue, 24 Mar 2020 09:37:06 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20F393F52E;
        Tue, 24 Mar 2020 09:37:05 -0700 (PDT)
Date:   Tue, 24 Mar 2020 16:37:04 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jonghwan Choi <charlie.jh@kakaocorp.com>
Cc:     alsa-devel@alsa-project.org, Dan Murphy <dmurphy@ti.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
Subject: Applied "ASoC: tas2562: Fixed incorrect amp_level setting." to the asoc tree
In-Reply-To:  <20200319140043.GA6688@jhbirdchoi-MS-7B79>
Message-Id:  <applied-20200319140043.GA6688@jhbirdchoi-MS-7B79>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: tas2562: Fixed incorrect amp_level setting.

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

From eedf8a126629bf9db8ad3a2a5dc9dc1798fb2302 Mon Sep 17 00:00:00 2001
From: Jonghwan Choi <charlie.jh@kakaocorp.com>
Date: Thu, 19 Mar 2020 23:00:44 +0900
Subject: [PATCH] ASoC: tas2562: Fixed incorrect amp_level setting.

According to the tas2562 datasheet,the bits[5:1] represents the amp_level value.
So to set the amp_level value correctly,the shift value should be set to 1.

Signed-off-by: Jonghwan Choi <charlie.jh@kakaocorp.com>
Acked-by: Dan Murphy <dmurphy@ti.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200319140043.GA6688@jhbirdchoi-MS-7B79
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tas2562.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index be52886a5edb..fb2233ca9103 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -409,7 +409,7 @@ static const struct snd_kcontrol_new vsense_switch =
 			1, 1);
 
 static const struct snd_kcontrol_new tas2562_snd_controls[] = {
-	SOC_SINGLE_TLV("Amp Gain Volume", TAS2562_PB_CFG1, 0, 0x1c, 0,
+	SOC_SINGLE_TLV("Amp Gain Volume", TAS2562_PB_CFG1, 1, 0x1c, 0,
 		       tas2562_dac_tlv),
 };
 
-- 
2.20.1

