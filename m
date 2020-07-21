Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5BFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 03:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3237020B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 03:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgGUDqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 23:46:01 -0400
Received: from inva021.nxp.com ([92.121.34.21]:59710 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbgGUDqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 23:46:01 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 61DC12003A3;
        Tue, 21 Jul 2020 05:45:58 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 25F1720038B;
        Tue, 21 Jul 2020 05:45:53 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id CA01C4030C;
        Tue, 21 Jul 2020 11:27:10 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ASoC: fsl-asoc-card: Support configuring dai fmt from DT
Date:   Tue, 21 Jul 2020 11:41:49 +0800
Message-Id: <1595302910-19688-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support same propeties as simple card for configuring fmt
from DT.
In order to make this change compatible with old DT, these
properties are optional.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index ee80d02b56c6..4848ba61d083 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -531,11 +531,14 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	struct device_node *cpu_np, *codec_np, *asrc_np;
 	struct device_node *np = pdev->dev.of_node;
 	struct platform_device *asrc_pdev = NULL;
+	struct device_node *bitclkmaster = NULL;
+	struct device_node *framemaster = NULL;
 	struct platform_device *cpu_pdev;
 	struct fsl_asoc_card_priv *priv;
 	struct device *codec_dev = NULL;
 	const char *codec_dai_name;
 	const char *codec_dev_name;
+	unsigned int daifmt;
 	u32 width;
 	int ret;
 
@@ -667,6 +670,31 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		goto asrc_fail;
 	}
 
+	/* Format info from DT is optional. */
+	daifmt = snd_soc_of_parse_daifmt(np, NULL,
+					 &bitclkmaster, &framemaster);
+	daifmt &= ~SND_SOC_DAIFMT_MASTER_MASK;
+	if (bitclkmaster || framemaster) {
+		if (codec_np == bitclkmaster)
+			daifmt |= (codec_np == framemaster) ?
+				SND_SOC_DAIFMT_CBM_CFM : SND_SOC_DAIFMT_CBM_CFS;
+		else
+			daifmt |= (codec_np == framemaster) ?
+				SND_SOC_DAIFMT_CBS_CFM : SND_SOC_DAIFMT_CBS_CFS;
+
+		/* Override dai_fmt with value from DT */
+		priv->dai_fmt = daifmt;
+	}
+
+	/* Change direction according to format */
+	if (priv->dai_fmt & SND_SOC_DAIFMT_CBM_CFM) {
+		priv->cpu_priv.sysclk_dir[TX] = SND_SOC_CLOCK_IN;
+		priv->cpu_priv.sysclk_dir[RX] = SND_SOC_CLOCK_IN;
+	}
+
+	of_node_put(bitclkmaster);
+	of_node_put(framemaster);
+
 	if (!fsl_asoc_card_is_ac97(priv) && !codec_dev) {
 		dev_err(&pdev->dev, "failed to find codec device\n");
 		ret = -EPROBE_DEFER;
-- 
2.27.0

