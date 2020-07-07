Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBDAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6DCA2075B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgGGI6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 04:58:49 -0400
Received: from inva021.nxp.com ([92.121.34.21]:50506 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727072AbgGGI6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 04:58:48 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B08D22015DF;
        Tue,  7 Jul 2020 10:58:46 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6068E2015EC;
        Tue,  7 Jul 2020 10:58:42 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C7669402F7;
        Tue,  7 Jul 2020 16:58:36 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ASoC: fsl_spdif: Add kctl for configuring TX validity bit
Date:   Tue,  7 Jul 2020 16:54:26 +0800
Message-Id: <1594112066-31297-3-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594112066-31297-1-git-send-email-shengjiu.wang@nxp.com>
References: <1594112066-31297-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add one kctl for configuring TX validity bit from user
space.

The type of this kctl is boolean:
on - Outgoing validity always set
off - Outgoing validity always clear

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_spdif.c | 47 +++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 576370dc6e70..37053e8f29d0 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -776,8 +776,8 @@ static int fsl_spdif_vbit_info(struct snd_kcontrol *kcontrol,
 }
 
 /* Get valid good bit from interrupt status register */
-static int fsl_spdif_vbit_get(struct snd_kcontrol *kcontrol,
-				struct snd_ctl_elem_value *ucontrol)
+static int fsl_spdif_rx_vbit_get(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_dai *cpu_dai = snd_kcontrol_chip(kcontrol);
 	struct fsl_spdif_priv *spdif_priv = snd_soc_dai_get_drvdata(cpu_dai);
@@ -791,6 +791,35 @@ static int fsl_spdif_vbit_get(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
+static int fsl_spdif_tx_vbit_get(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dai *cpu_dai = snd_kcontrol_chip(kcontrol);
+	struct fsl_spdif_priv *spdif_priv = snd_soc_dai_get_drvdata(cpu_dai);
+	struct regmap *regmap = spdif_priv->regmap;
+	u32 val;
+
+	regmap_read(regmap, REG_SPDIF_SCR, &val);
+	val = (val & SCR_VAL_MASK) >> SCR_VAL_OFFSET;
+	val = 1 - val;
+	ucontrol->value.integer.value[0] = val;
+
+	return 0;
+}
+
+static int fsl_spdif_tx_vbit_put(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dai *cpu_dai = snd_kcontrol_chip(kcontrol);
+	struct fsl_spdif_priv *spdif_priv = snd_soc_dai_get_drvdata(cpu_dai);
+	struct regmap *regmap = spdif_priv->regmap;
+	u32 val = (1 - ucontrol->value.integer.value[0]) << SCR_VAL_OFFSET;
+
+	regmap_update_bits(regmap, REG_SPDIF_SCR, SCR_VAL_MASK, val);
+
+	return 0;
+}
+
 /* DPLL lock information */
 static int fsl_spdif_rxrate_info(struct snd_kcontrol *kcontrol,
 				struct snd_ctl_elem_info *uinfo)
@@ -948,11 +977,21 @@ static struct snd_kcontrol_new fsl_spdif_ctrls[] = {
 	/* Valid bit error controller */
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
-		.name = "IEC958 V-Bit Errors",
+		.name = "IEC958 RX V-Bit Errors",
 		.access = SNDRV_CTL_ELEM_ACCESS_READ |
 			SNDRV_CTL_ELEM_ACCESS_VOLATILE,
 		.info = fsl_spdif_vbit_info,
-		.get = fsl_spdif_vbit_get,
+		.get = fsl_spdif_rx_vbit_get,
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
+		.name = "IEC958 TX V-Bit",
+		.access = SNDRV_CTL_ELEM_ACCESS_READ |
+			SNDRV_CTL_ELEM_ACCESS_WRITE |
+			SNDRV_CTL_ELEM_ACCESS_VOLATILE,
+		.info = fsl_spdif_vbit_info,
+		.get = fsl_spdif_tx_vbit_get,
+		.put = fsl_spdif_tx_vbit_put,
 	},
 	/* DPLL lock info get controller */
 	{
-- 
2.21.0

