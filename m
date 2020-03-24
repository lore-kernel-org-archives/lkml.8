Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860E7C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B802051A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585070197;
	bh=sBmIAZrMd5INuP5Ib+0t5c6nERa/j5osdrx/0Fmnc3Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=zvGlwFdGNCkCd2QjTJ1L6R0pKPukC0zCRAq0IM3Z26fciq5sucN4PfY0adaAD0WvT
	 sxZS/Kt0Ekj2RlpDYsf7qT0fhpVIAJwUxNTC+7BaW4yQ9Ou6lXYjv7KOt1AsLiNbEN
	 EJoHDz28qSX0UpRerTMR/oDVnUwcGo9ultaFT3tk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgCXRQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 13:16:36 -0400
Received: from foss.arm.com ([217.140.110.172]:38544 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727383AbgCXRQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 13:16:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FFF21045;
        Tue, 24 Mar 2020 10:16:35 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04EF33F71F;
        Tue, 24 Mar 2020 10:16:34 -0700 (PDT)
Date:   Tue, 24 Mar 2020 17:16:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: wm8974: remove unused variables" to the asoc tree
In-Reply-To:  <20200324070615.16248-1-yuehaibing@huawei.com>
Message-Id:  <applied-20200324070615.16248-1-yuehaibing@huawei.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: wm8974: remove unused variables

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

From 6b877cf8bc98e6c574a6d763943c4a92592e431c Mon Sep 17 00:00:00 2001
From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 24 Mar 2020 15:06:15 +0800
Subject: [PATCH] ASoC: wm8974: remove unused variables

sound/soc/codecs/wm8974.c:200:38: warning:
 wm8974_aux_boost_controls defined but not used [-Wunused-const-variable=]
sound/soc/codecs/wm8974.c:204:38: warning:
 wm8974_mic_boost_controls defined but not used [-Wunused-const-variable=]

commit 8a123ee2a46d ("ASoC: WM8974 DAPM cleanups")
left behind this, remove them.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20200324070615.16248-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8974.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/soc/codecs/wm8974.c b/sound/soc/codecs/wm8974.c
index dc4fe4f5239d..06ba36595ddd 100644
--- a/sound/soc/codecs/wm8974.c
+++ b/sound/soc/codecs/wm8974.c
@@ -196,14 +196,6 @@ SOC_DAPM_SINGLE("MicN Switch", WM8974_INPUT, 1, 1, 0),
 SOC_DAPM_SINGLE("MicP Switch", WM8974_INPUT, 0, 1, 0),
 };
 
-/* AUX Input boost vol */
-static const struct snd_kcontrol_new wm8974_aux_boost_controls =
-SOC_DAPM_SINGLE("Aux Volume", WM8974_ADCBOOST, 0, 7, 0);
-
-/* Mic Input boost vol */
-static const struct snd_kcontrol_new wm8974_mic_boost_controls =
-SOC_DAPM_SINGLE("Mic Volume", WM8974_ADCBOOST, 4, 7, 0);
-
 static const struct snd_soc_dapm_widget wm8974_dapm_widgets[] = {
 SND_SOC_DAPM_MIXER("Speaker Mixer", WM8974_POWER3, 2, 0,
 	&wm8974_speaker_mixer_controls[0],
-- 
2.20.1

