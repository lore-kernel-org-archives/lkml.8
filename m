Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDB5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE94D20801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgFLHtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 03:49:10 -0400
Received: from inva020.nxp.com ([92.121.34.13]:50668 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726475AbgFLHsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 03:48:54 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 20D9F1A0B79;
        Fri, 12 Jun 2020 09:48:51 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 07E061A0B77;
        Fri, 12 Jun 2020 09:48:46 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B54D1402FF;
        Fri, 12 Jun 2020 15:48:39 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lars@metafoo.de, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, broonie@kernel.org, timur@kernel.org,
        nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v3 3/4] ASoC: fsl_asrc_dma: Reuse the dma channel if available in Back-End
Date:   Fri, 12 Jun 2020 15:37:50 +0800
Message-Id: <3a79f0442cb4930c633cf72145cfe95a45b9c78e.1591947428.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1591947428.git.shengjiu.wang@nxp.com>
References: <cover.1591947428.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1591947428.git.shengjiu.wang@nxp.com>
References: <cover.1591947428.git.shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dma channel has been requested by Back-End cpu dai driver already.
If fsl_asrc_dma requests dma chan with same dma:tx symlink, then
there will be below warning with SDMA.

[   48.174236] fsl-esai-dai 2024000.esai: Cannot create DMA dma:tx symlink

So if we can reuse the dma channel of Back-End, then the issue can be
fixed.

In order to get the dma channel which is already requested in Back-End.
we use the exported two functions (snd_soc_lookup_component_nolocked
and soc_component_to_pcm). If we can get the dma channel, then reuse it,
if can't, then request a new one.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_asrc_dma.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
index d6a3fc5f87e5..d88e6343e0a2 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -135,6 +135,8 @@ static int fsl_asrc_dma_hw_params(struct snd_soc_component *component,
 	struct snd_dmaengine_dai_dma_data *dma_params_be = NULL;
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct fsl_asrc_pair *pair = runtime->private_data;
+	struct dma_chan *tmp_chan = NULL, *be_chan = NULL;
+	struct snd_soc_component *component_be = NULL;
 	struct fsl_asrc *asrc = pair->asrc;
 	struct dma_slave_config config_fe, config_be;
 	enum asrc_pair_index index = pair->index;
@@ -142,7 +144,6 @@ static int fsl_asrc_dma_hw_params(struct snd_soc_component *component,
 	int stream = substream->stream;
 	struct imx_dma_data *tmp_data;
 	struct snd_soc_dpcm *dpcm;
-	struct dma_chan *tmp_chan;
 	struct device *dev_be;
 	u8 dir = tx ? OUT : IN;
 	dma_cap_mask_t mask;
@@ -197,18 +198,30 @@ static int fsl_asrc_dma_hw_params(struct snd_soc_component *component,
 	dma_cap_set(DMA_SLAVE, mask);
 	dma_cap_set(DMA_CYCLIC, mask);
 
+	/*
+	 * The Back-End device might have already requested a DMA channel,
+	 * so try to reuse it first, and then request a new one upon NULL.
+	 */
+	component_be = snd_soc_lookup_component_nolocked(dev_be, SND_DMAENGINE_PCM_DRV_NAME);
+	if (component_be) {
+		be_chan = soc_component_to_pcm(component_be)->chan[substream->stream];
+		tmp_chan = be_chan;
+	}
+	if (!tmp_chan)
+		tmp_chan = dma_request_slave_channel(dev_be, tx ? "tx" : "rx");
+
 	/*
 	 * An EDMA DEV_TO_DEV channel is fixed and bound with DMA event of each
 	 * peripheral, unlike SDMA channel that is allocated dynamically. So no
-	 * need to configure dma_request and dma_request2, but get dma_chan via
-	 * dma_request_slave_channel directly with dma name of Front-End device
+	 * need to configure dma_request and dma_request2, but get dma_chan of
+	 * Back-End device directly via dma_request_slave_channel.
 	 */
 	if (!asrc->use_edma) {
 		/* Get DMA request of Back-End */
-		tmp_chan = dma_request_slave_channel(dev_be, tx ? "tx" : "rx");
 		tmp_data = tmp_chan->private;
 		pair->dma_data.dma_request = tmp_data->dma_request;
-		dma_release_channel(tmp_chan);
+		if (!be_chan)
+			dma_release_channel(tmp_chan);
 
 		/* Get DMA request of Front-End */
 		tmp_chan = asrc->get_dma_channel(pair, dir);
@@ -221,6 +234,8 @@ static int fsl_asrc_dma_hw_params(struct snd_soc_component *component,
 		pair->dma_chan[dir] =
 			dma_request_channel(mask, filter, &pair->dma_data);
 	} else {
+		if (!be_chan)
+			dma_release_channel(tmp_chan);
 		pair->dma_chan[dir] =
 			asrc->get_dma_channel(pair, dir);
 	}
-- 
2.21.0

