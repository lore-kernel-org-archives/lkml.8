Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11203C33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 07:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3FD20684
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 07:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgATHcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 02:32:33 -0500
Received: from inva020.nxp.com ([92.121.34.13]:56870 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgATHcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 02:32:32 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EA2081A058C;
        Mon, 20 Jan 2020 08:32:30 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 77D441A02E4;
        Mon, 20 Jan 2020 08:32:27 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id EF3E8402C4;
        Mon, 20 Jan 2020 15:32:22 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, john.stultz@linaro.org
Subject: [PATCH] ASoC: soc-generic-dmaengine-pcm: Fix error handling
Date:   Mon, 20 Jan 2020 15:28:06 +0800
Message-Id: <1579505286-32085-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the return value checking, that is to align with the code
before adding snd_dmaengine_pcm_refine_runtime_hwparams function.

Otherwise it causes a regression on the HiKey board:

[   17.721424] hi6210_i2s f7118000.i2s: ASoC: can't open component f7118000.i2s: -6

Fixes: e957204e732b ("ASoC: pcm_dmaengine: Extract snd_dmaengine_pcm_refine_runtime_hwparams")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reported-by: John Stultz <john.stultz@linaro.org>
---
 sound/soc/soc-generic-dmaengine-pcm.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index a428ff393ea2..2b5f3b1b062b 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -117,7 +117,6 @@ dmaengine_pcm_set_runtime_hwparams(struct snd_soc_component *component,
 	struct dma_chan *chan = pcm->chan[substream->stream];
 	struct snd_dmaengine_dai_dma_data *dma_data;
 	struct snd_pcm_hardware hw;
-	int ret;
 
 	if (pcm->config && pcm->config->pcm_hardware)
 		return snd_soc_set_runtime_hwparams(substream,
@@ -138,12 +137,15 @@ dmaengine_pcm_set_runtime_hwparams(struct snd_soc_component *component,
 	if (pcm->flags & SND_DMAENGINE_PCM_FLAG_NO_RESIDUE)
 		hw.info |= SNDRV_PCM_INFO_BATCH;
 
-	ret = snd_dmaengine_pcm_refine_runtime_hwparams(substream,
-							dma_data,
-							&hw,
-							chan);
-	if (ret)
-		return ret;
+	/**
+	 * FIXME: Remove the return value check to align with the code
+	 * before adding snd_dmaengine_pcm_refine_runtime_hwparams
+	 * function.
+	 */
+	snd_dmaengine_pcm_refine_runtime_hwparams(substream,
+						  dma_data,
+						  &hw,
+						  chan);
 
 	return snd_soc_set_runtime_hwparams(substream, &hw);
 }
-- 
2.21.0

