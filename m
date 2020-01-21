Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7485CC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B932206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579627744;
	bh=cVVVG3LcU8AlGGgiouFRNnJHszYmYRkNwl5nMatz09c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=cntWKJ8VVM5T7eYwVdidABQM7IjZgg2OwnFfEdSV0GY+UC5uxdD8ST5aScx3YRVKU
	 fbQ6TUth1r0hjgXXhBxvJDuIEN4abaR570L1hRzcgMQF//Mz5lMh5hTaEdGMyLAUY/
	 zGFOS86Pgn6MmZjvupJavHsSIFobQvlivopM+FJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgAUR3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 12:29:03 -0500
Received: from foss.arm.com ([217.140.110.172]:46528 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728186AbgAUR3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 12:29:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56D5D328;
        Tue, 21 Jan 2020 09:29:01 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C94B63F6C4;
        Tue, 21 Jan 2020 09:29:00 -0800 (PST)
Date:   Tue, 21 Jan 2020 17:28:59 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        perex@perex.cz, tiwai@suse.com
Subject: Applied "ASoC: soc-pcm: crash in snd_soc_dapm_new_dai" to the asoc tree
In-Reply-To: <1579443563-12287-1-git-send-email-spujar@nvidia.com>
Message-Id: <applied-1579443563-12287-1-git-send-email-spujar@nvidia.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: soc-pcm: crash in snd_soc_dapm_new_dai

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

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

From af4bac11531fbc0b5955fdccbe3f5ea265cd7374 Mon Sep 17 00:00:00 2001
From: Sameer Pujar <spujar@nvidia.com>
Date: Sun, 19 Jan 2020 19:49:23 +0530
Subject: [PATCH] ASoC: soc-pcm: crash in snd_soc_dapm_new_dai

Crash happens in snd_soc_dapm_new_dai() when substream->private_data
access is made and substream is NULL here. This is seen for DAIs where
only playback or capture stream is defined. This seems to be happening
for codec2codec DAI link.

Both playback and capture are 0 during soc_new_pcm(). This is probably
happening because cpu_dai and codec_dai are both validated either for
SNDRV_PCM_STREAM_PLAYBACK or SNDRV_PCM_STREAM_CAPTURE.

Shouldn't be playback = 1 when,
 - playback stream is available for codec_dai AND
 - capture stream is available for cpu_dai

and vice-versa for capture = 1?

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Link: https://lore.kernel.org/r/1579443563-12287-1-git-send-email-spujar@nvidia.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index b78f6ff2b1d3..f70bec7815ee 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2916,10 +2916,10 @@ int soc_new_pcm(struct snd_soc_pcm_runtime *rtd, int num)
 
 		for_each_rtd_codec_dai(rtd, i, codec_dai) {
 			if (snd_soc_dai_stream_valid(codec_dai, SNDRV_PCM_STREAM_PLAYBACK) &&
-			    snd_soc_dai_stream_valid(cpu_dai,   SNDRV_PCM_STREAM_PLAYBACK))
+			    snd_soc_dai_stream_valid(cpu_dai,   SNDRV_PCM_STREAM_CAPTURE))
 				playback = 1;
 			if (snd_soc_dai_stream_valid(codec_dai, SNDRV_PCM_STREAM_CAPTURE) &&
-			    snd_soc_dai_stream_valid(cpu_dai,   SNDRV_PCM_STREAM_CAPTURE))
+			    snd_soc_dai_stream_valid(cpu_dai,   SNDRV_PCM_STREAM_PLAYBACK))
 				capture = 1;
 		}
 
-- 
2.20.1

