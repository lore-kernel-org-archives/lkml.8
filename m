Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10098C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 06:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF840208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 06:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731411AbgGaGcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 02:32:42 -0400
Received: from inva021.nxp.com ([92.121.34.21]:36526 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731224AbgGaGcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 02:32:42 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A71972003B3;
        Fri, 31 Jul 2020 08:32:40 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3CEF52003BA;
        Fri, 31 Jul 2020 08:32:36 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 6B8BE402BF;
        Fri, 31 Jul 2020 08:32:30 +0200 (CEST)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_sai: Fix value of FSL_SAI_CR1_RFW_MASK
Date:   Fri, 31 Jul 2020 14:28:15 +0800
Message-Id: <1596176895-28724-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fifo_depth is 64 on i.MX8QM/i.MX8QXP, 128 on i.MX8MQ, 16 on
i.MX7ULP.

Original FSL_SAI_CR1_RFW_MASK value 0x1F is not suitable for
these platform, the FIFO watermark mask should be updated
according to the fifo_depth.

Fixes: a860fac42097 ("ASoC: fsl_sai: Add support for imx7ulp/imx8mq")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 5 +++--
 sound/soc/fsl/fsl_sai.h | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index a22562f2df47..cdff739924e2 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -680,10 +680,11 @@ static int fsl_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 	regmap_write(sai->regmap, FSL_SAI_RCSR(ofs), 0);
 
 	regmap_update_bits(sai->regmap, FSL_SAI_TCR1(ofs),
-			   FSL_SAI_CR1_RFW_MASK,
+			   FSL_SAI_CR1_RFW_MASK(sai->soc_data->fifo_depth),
 			   sai->soc_data->fifo_depth - FSL_SAI_MAXBURST_TX);
 	regmap_update_bits(sai->regmap, FSL_SAI_RCR1(ofs),
-			   FSL_SAI_CR1_RFW_MASK, FSL_SAI_MAXBURST_RX - 1);
+			   FSL_SAI_CR1_RFW_MASK(sai->soc_data->fifo_depth),
+			   FSL_SAI_MAXBURST_RX - 1);
 
 	snd_soc_dai_init_dma_data(cpu_dai, &sai->dma_params_tx,
 				&sai->dma_params_rx);
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index 76b15deea80c..6aba7d28f5f3 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -94,7 +94,7 @@
 #define FSL_SAI_CSR_FRDE	BIT(0)
 
 /* SAI Transmit and Receive Configuration 1 Register */
-#define FSL_SAI_CR1_RFW_MASK	0x1f
+#define FSL_SAI_CR1_RFW_MASK(x)	((x) - 1)
 
 /* SAI Transmit and Receive Configuration 2 Register */
 #define FSL_SAI_CR2_SYNC	BIT(30)
-- 
2.27.0

