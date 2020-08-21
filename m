Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46ECFC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D05A214F1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Trkh8tzC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgHUHMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 03:12:17 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:3043 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbgHUHMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:12:15 -0400
IronPort-SDR: 2VXbvpM0wpDsnADs9ZVhZ6cgKIUMtgcaRhqz8Za8c/9zSkU7Y8y82HAThi5mMhwd9UfzZwvbeR
 7+ZQUzg8imTnmgzC3qV5dSItklz9GSCFruWyH+cxTarqseYt7T1wTgZKCnVuh8pFnRKNipf1Xn
 gHE68kwhcWKCOKHPWHeZHVelcbyfbTXK4T2OvAi7gPxF5gyZY6OmyqkdgjmtlQURxe+c6CnVdI
 b3qIimilR4NIZInlI9Akj2z2WU1unZT4LJqNSgTEfNSeqJ2fDnOd1cxAvImeCv2PKiwjiy+YQH
 5F4=
X-IronPort-AV: E=Sophos;i="5.76,335,1592863200"; 
   d="scan'208";a="13549139"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 21 Aug 2020 09:12:14 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 21 Aug 2020 09:12:14 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 21 Aug 2020 09:12:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1597993934; x=1629529934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=hsFilC0q1ryGsIIF62waCvhPyJEvTFWfBLAV0i0JgVU=;
  b=Trkh8tzC0ZhbKNS8pOevh3GZ/JkMriQfhfMOXHBeUHAABSmiycfY/WWY
   Bo8YaUF/Bo+5JSXNhP812g5tzKyp+JdUsq75gdqnnRN1U2cnZUFCw59Mr
   lJgigQpzfGsx2SOZsrzLSGdUEpXEs8Q8B0/y2ghKhe9fz1o1SWNuuwYCz
   xh4tKFfSQKyZhQ8s2SFRzNLM1PnpaLWjDFAMWmhM8yQ6yzo2WpI63knF7
   aSCC7v6/f87wtTxX353JcFVCfbbvZFfeFGY0EgU4SEiDtClIZs4Cz5+0a
   h5nDohwYTUotZ4GBWQLqjY7yGLyFw7fDMkbwH9tC1u2vjjXtI5JDi780A
   Q==;
IronPort-SDR: Zj2sok/VJ8Obs+mdkHurW+yviq9k9jfjO7VIKm2gnpRJvhaL3GvGHbVAPZCs6QBxmJ/RYzm1mh
 uvDTbhcWH595M9l3PTHxggtzHeGm0iQEwx0xo86ar9FggiH0NrkTa5mqi9Ib3+fEFtCO4tPIkM
 Uwsvt2p4sxGS5EN+dCmhcBfZmHMa4hV6TvWJzEF1ojUYJwg6aos0hWRTvgcyPHBdTdY7hRXRw1
 2Nppve+eskuJnLsaMRoRsOjNAu8alPc570Wy3mpHmcA54VU0WrMAOKfaGEPR5o1rM7FXMt0v98
 MXQ=
X-IronPort-AV: E=Sophos;i="5.76,335,1592863200"; 
   d="scan'208";a="13549138"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 21 Aug 2020 09:12:14 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id D9150280065;
        Fri, 21 Aug 2020 09:12:13 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 2/2] ASoC: fsl-asoc-card: add support for TLV320AIC32x4 codec
Date:   Fri, 21 Aug 2020 09:11:53 +0200
Message-Id: <20200821071153.7317-2-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200821071153.7317-1-matthias.schiffer@ew.tq-group.com>
References: <20200821071153.7317-1-matthias.schiffer@ew.tq-group.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TLV320AIC32x4 is commonly used on TQ-Systems starterkit mainboards
for i.MX-based SoMs (i.MX6Q/DL, i.MX6UL, i.MX7) and LS1021A.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 sound/soc/fsl/Kconfig         | 2 +-
 sound/soc/fsl/fsl-asoc-card.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 1c4ca5ec8caf..3f76ff71ea47 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -324,7 +324,7 @@ config SND_SOC_FSL_ASOC_CARD
 	help
 	 ALSA SoC Audio support with ASRC feature for Freescale SoCs that have
 	 ESAI/SAI/SSI and connect with external CODECs such as WM8962, CS42888,
-	 CS4271, CS4272 and SGTL5000.
+	 CS4271, CS4272, SGTL5000 and TLV320AIC32x4.
 	 Say Y if you want to add support for Freescale Generic ASoC Sound Card.
 
 config SND_SOC_IMX_AUDMIX
diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 32f8f756e6bb..a2dd3b6b7fec 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -617,6 +617,9 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		codec_dai_name = "sgtl5000";
 		priv->codec_priv.mclk_id = SGTL5000_SYSCLK;
 		priv->dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
+	} else if (of_device_is_compatible(np, "fsl,imx-audio-tlv320aic32x4")) {
+		codec_dai_name = "tlv320aic32x4-hifi";
+		priv->dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
 	} else if (of_device_is_compatible(np, "fsl,imx-audio-wm8962")) {
 		codec_dai_name = "wm8962";
 		priv->codec_priv.mclk_id = WM8962_SYSCLK_MCLK;
@@ -860,6 +863,7 @@ static const struct of_device_id fsl_asoc_card_dt_ids[] = {
 	{ .compatible = "fsl,imx-audio-ac97", },
 	{ .compatible = "fsl,imx-audio-cs42888", },
 	{ .compatible = "fsl,imx-audio-cs427x", },
+	{ .compatible = "fsl,imx-audio-tlv320aic32x4", },
 	{ .compatible = "fsl,imx-audio-sgtl5000", },
 	{ .compatible = "fsl,imx-audio-wm8962", },
 	{ .compatible = "fsl,imx-audio-wm8960", },
-- 
2.17.1

