Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF81C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 04:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1189620853
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 04:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgFQEle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 00:41:34 -0400
Received: from inva020.nxp.com ([92.121.34.13]:60750 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbgFQElc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 00:41:32 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F21A31A09DA;
        Wed, 17 Jun 2020 06:41:29 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 817F41A09EC;
        Wed, 17 Jun 2020 06:41:24 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B2172402B3;
        Wed, 17 Jun 2020 12:41:17 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ASoC: fsl_spdif: Add support for imx6sx platform
Date:   Wed, 17 Jun 2020 12:30:17 +0800
Message-Id: <53a969a83999de91f3ff2809d78335c3f0cc1ee3.1592368322.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <feda3bb02296455d43aeebb7575918d9b28e1a3f.1592368322.git.shengjiu.wang@nxp.com>
References: <feda3bb02296455d43aeebb7575918d9b28e1a3f.1592368322.git.shengjiu.wang@nxp.com>
In-Reply-To: <feda3bb02296455d43aeebb7575918d9b28e1a3f.1592368322.git.shengjiu.wang@nxp.com>
References: <feda3bb02296455d43aeebb7575918d9b28e1a3f.1592368322.git.shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The one difference on imx6sx platform is that the root clock
is shared with ASRC module, so we add a new flags
"shared_root_clock" which means the root clock is independent,
then we will not do the clk_set_rate and clk_round_rate to avoid
impact ASRC module usage.

As add a new flags, we include the soc specific data struct.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
changes in v2
- use shared_root_clk instead ind_root_clk.
- add fsl_spdif_can_set_clk_rate function.

 sound/soc/fsl/fsl_spdif.c | 50 +++++++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 1b2e516f9162..8dc1959d0463 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -42,6 +42,18 @@ static u8 srpc_dpll_locked[] = { 0x0, 0x1, 0x2, 0x3, 0x4, 0xa, 0xb };
 
 #define DEFAULT_RXCLK_SRC	1
 
+/**
+ * struct fsl_spdif_soc_data: soc specific data
+ *
+ * @imx: for imx platform
+ * @shared_root_clock: flag of sharing a clock source with others;
+ *                     so the driver shouldn't set root clock rate
+ */
+struct fsl_spdif_soc_data {
+	bool imx;
+	bool shared_root_clock;
+};
+
 /*
  * SPDIF control structure
  * Defines channel status, subcode and Q sub
@@ -89,6 +101,7 @@ struct spdif_mixer_control {
  * @dma_params_rx: DMA parameters for receive channel
  */
 struct fsl_spdif_priv {
+	const struct fsl_spdif_soc_data *soc;
 	struct spdif_mixer_control fsl_spdif_control;
 	struct snd_soc_dai_driver cpu_dai_drv;
 	struct platform_device *pdev;
@@ -110,6 +123,28 @@ struct fsl_spdif_priv {
 	u32 regcache_srpc;
 };
 
+static struct fsl_spdif_soc_data fsl_spdif_vf610 = {
+	.imx = false,
+	.shared_root_clock = false,
+};
+
+static struct fsl_spdif_soc_data fsl_spdif_imx35 = {
+	.imx = true,
+	.shared_root_clock = false,
+};
+
+static struct fsl_spdif_soc_data fsl_spdif_imx6sx = {
+	.imx = true,
+	.shared_root_clock = true,
+};
+
+/* Check if clk is a root clock that does not share clock source with others */
+static inline bool fsl_spdif_can_set_clk_rate(struct fsl_spdif_priv *spdif,
+					      int clk)
+{
+	return (clk == STC_TXCLK_SPDIF_ROOT) && !spdif->soc->shared_root_clock;
+}
+
 /* DPLL locked and lock loss interrupt handler */
 static void spdif_irq_dpll_lock(struct fsl_spdif_priv *spdif_priv)
 {
@@ -421,7 +456,7 @@ static int spdif_set_sample_rate(struct snd_pcm_substream *substream,
 	sysclk_df = spdif_priv->sysclk_df[rate];
 
 	/* Don't mess up the clocks from other modules */
-	if (clk != STC_TXCLK_SPDIF_ROOT)
+	if (!fsl_spdif_can_set_clk_rate(spdif_priv, clk))
 		goto clk_set_bypass;
 
 	/* The S/PDIF block needs a clock of 64 * fs * txclk_df */
@@ -1186,7 +1221,7 @@ static int fsl_spdif_probe_txclk(struct fsl_spdif_priv *spdif_priv,
 			continue;
 
 		ret = fsl_spdif_txclk_caldiv(spdif_priv, clk, savesub, index,
-					     i == STC_TXCLK_SPDIF_ROOT);
+					     fsl_spdif_can_set_clk_rate(spdif_priv, i));
 		if (savesub == ret)
 			continue;
 
@@ -1230,6 +1265,12 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 
 	spdif_priv->pdev = pdev;
 
+	spdif_priv->soc = of_device_get_match_data(&pdev->dev);
+	if (!spdif_priv->soc) {
+		dev_err(&pdev->dev, "failed to get soc data\n");
+		return -ENODEV;
+	}
+
 	/* Initialize this copy of the CPU DAI driver structure */
 	memcpy(&spdif_priv->cpu_dai_drv, &fsl_spdif_dai, sizeof(fsl_spdif_dai));
 	spdif_priv->cpu_dai_drv.name = dev_name(&pdev->dev);
@@ -1359,8 +1400,9 @@ static const struct dev_pm_ops fsl_spdif_pm = {
 };
 
 static const struct of_device_id fsl_spdif_dt_ids[] = {
-	{ .compatible = "fsl,imx35-spdif", },
-	{ .compatible = "fsl,vf610-spdif", },
+	{ .compatible = "fsl,imx35-spdif", .data = &fsl_spdif_imx35, },
+	{ .compatible = "fsl,vf610-spdif", .data = &fsl_spdif_vf610, },
+	{ .compatible = "fsl,imx6sx-spdif", .data = &fsl_spdif_imx6sx, },
 	{}
 };
 MODULE_DEVICE_TABLE(of, fsl_spdif_dt_ids);
-- 
2.21.0

