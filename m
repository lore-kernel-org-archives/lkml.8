Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C99C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C66520870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581436103;
	bh=5EjXcOSWk2j2P9pWbnS8ZBOvLgZxSpHoEqhOkXT3uyo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=o7Gq7XxNuAItYhFtTXx/RggQWej4LfYb/rPwBapJ4KAsEPOakFgH96tSQ2qteUfFQ
	 VVkT5cDKfnfyGvh8tC76+Z+VPs+pXr9hESq1ubqCeNW11sRd2ax5Ou6xip9PvZTOJJ
	 GH0MSMVqe7tqB4lS5z98RcnepxDjrvKsirHITnkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbgBKPsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:48:22 -0500
Received: from foss.arm.com ([217.140.110.172]:48156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729058AbgBKPsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:48:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73FB730E;
        Tue, 11 Feb 2020 07:48:21 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB56D3F68E;
        Tue, 11 Feb 2020 07:48:20 -0800 (PST)
Date:   Tue, 11 Feb 2020 15:48:19 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, perex@perex.cz,
        tiwai@suse.com, vkoul@kernel.org
Subject: Applied "ALSA: dmaengine_pcm: Consider DMA cache caused delay in pointer callback" to the asoc tree
In-Reply-To: <20200210153336.10218-1-peter.ujfalusi@ti.com>
Message-Id: <applied-20200210153336.10218-1-peter.ujfalusi@ti.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ALSA: dmaengine_pcm: Consider DMA cache caused delay in pointer callback

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.7

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

From 9d789dc047e32fb0f85ff192f883a534017512a2 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Mon, 10 Feb 2020 17:33:36 +0200
Subject: [PATCH] ALSA: dmaengine_pcm: Consider DMA cache caused delay in
 pointer callback

Some DMA engines can have big FIFOs which adds to the latency.
The DMAengine framework can report the FIFO utilization in bytes. Use this
information for the delay reporting.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20200210153336.10218-1-peter.ujfalusi@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/core/pcm_dmaengine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index d8be7b488162..6852bb670b4e 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -240,6 +240,7 @@ EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_pointer_no_residue);
 snd_pcm_uframes_t snd_dmaengine_pcm_pointer(struct snd_pcm_substream *substream)
 {
 	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct dma_tx_state state;
 	enum dma_status status;
 	unsigned int buf_size;
@@ -257,7 +258,7 @@ snd_pcm_uframes_t snd_dmaengine_pcm_pointer(struct snd_pcm_substream *substream)
 						 state.in_flight_bytes);
 	}
 
-	return bytes_to_frames(substream->runtime, pos);
+	return bytes_to_frames(runtime, pos);
 }
 EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_pointer);
 
-- 
2.20.1

