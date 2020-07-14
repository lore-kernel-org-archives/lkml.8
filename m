Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEB8C433ED
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7D48208FE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgGNJJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:09:34 -0400
Received: from inva021.nxp.com ([92.121.34.21]:39694 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgGNJJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:09:29 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3E3BF200F70;
        Tue, 14 Jul 2020 11:09:27 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B746C200179;
        Tue, 14 Jul 2020 11:09:20 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B3703402E4;
        Tue, 14 Jul 2020 17:09:12 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        broonie@kernel.org, kuninori.morimoto.gx@renesas.com,
        katsuhiro@katsuster.net, samuel@sholland.org,
        alsa-devel@alsa-project.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, timur@kernel.org,
        nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] ASoC: fsl-asoc-card: Support Headphone and Microphone Jack detection
Date:   Tue, 14 Jul 2020 17:05:36 +0800
Message-Id: <1594717536-5188-4-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594717536-5188-1-git-send-email-shengjiu.wang@nxp.com>
References: <1594717536-5188-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use asoc_simple_init_jack function from simple card to implement
the Headphone and Microphone detection.
Register notifier to disable Speaker when Headphone is plugged in
and enable Speaker when Headphone is unplugged.
Register notifier to disable Digital Microphone when Analog Microphone
is plugged in and enable DMIC when Analog Microphone is unplugged.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/Kconfig         |  1 +
 sound/soc/fsl/fsl-asoc-card.c | 69 ++++++++++++++++++++++++++++++++++-
 2 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index ea7b4787a8af..1c4ca5ec8caf 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -315,6 +315,7 @@ config SND_SOC_FSL_ASOC_CARD
 	depends on OF && I2C
 	# enforce SND_SOC_FSL_ASOC_CARD=m if SND_AC97_CODEC=m:
 	depends on SND_AC97_CODEC || SND_AC97_CODEC=n
+	select SND_SIMPLE_CARD_UTILS
 	select SND_SOC_IMX_AUDMUX
 	select SND_SOC_IMX_PCM_DMA
 	select SND_SOC_FSL_ESAI
diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index faac6ce9a82c..313058789ea9 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -15,6 +15,8 @@
 #endif
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/jack.h>
+#include <sound/simple_card_utils.h>
 
 #include "fsl_esai.h"
 #include "fsl_sai.h"
@@ -65,6 +67,8 @@ struct cpu_priv {
 /**
  * struct fsl_asoc_card_priv - Freescale Generic ASOC card private data
  * @dai_link: DAI link structure including normal one and DPCM link
+ * @hp_jack: Headphone Jack structure
+ * @mic_jack: Microphone Jack structure
  * @pdev: platform device pointer
  * @codec_priv: CODEC private data
  * @cpu_priv: CPU private data
@@ -79,6 +83,8 @@ struct cpu_priv {
 
 struct fsl_asoc_card_priv {
 	struct snd_soc_dai_link dai_link[3];
+	struct asoc_simple_jack hp_jack;
+	struct asoc_simple_jack mic_jack;
 	struct platform_device *pdev;
 	struct codec_priv codec_priv;
 	struct cpu_priv cpu_priv;
@@ -445,6 +451,44 @@ static int fsl_asoc_card_audmux_init(struct device_node *np,
 	return 0;
 }
 
+static int hp_jack_event(struct notifier_block *nb, unsigned long event,
+			 void *data)
+{
+	struct snd_soc_jack *jack = (struct snd_soc_jack *)data;
+	struct snd_soc_dapm_context *dapm = &jack->card->dapm;
+
+	if (event & SND_JACK_HEADPHONE)
+		/* Disable speaker if headphone is plugged in */
+		snd_soc_dapm_disable_pin(dapm, "Ext Spk");
+	else
+		snd_soc_dapm_enable_pin(dapm, "Ext Spk");
+
+	return 0;
+}
+
+static struct notifier_block hp_jack_nb = {
+	.notifier_call = hp_jack_event,
+};
+
+static int mic_jack_event(struct notifier_block *nb, unsigned long event,
+			  void *data)
+{
+	struct snd_soc_jack *jack = (struct snd_soc_jack *)data;
+	struct snd_soc_dapm_context *dapm = &jack->card->dapm;
+
+	if (event & SND_JACK_MICROPHONE)
+		/* Disable dmic if microphone is plugged in */
+		snd_soc_dapm_disable_pin(dapm, "DMIC");
+	else
+		snd_soc_dapm_enable_pin(dapm, "DMIC");
+
+	return 0;
+}
+
+static struct notifier_block mic_jack_nb = {
+	.notifier_call = mic_jack_event,
+};
+
 static int fsl_asoc_card_late_probe(struct snd_soc_card *card)
 {
 	struct fsl_asoc_card_priv *priv = snd_soc_card_get_drvdata(card);
@@ -745,8 +789,29 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	snd_soc_card_set_drvdata(&priv->card, priv);
 
 	ret = devm_snd_soc_register_card(&pdev->dev, &priv->card);
-	if (ret && ret != -EPROBE_DEFER)
-		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n", ret);
+		goto asrc_fail;
+	}
+
+	if (of_property_read_bool(np, "hp-det-gpio")) {
+		ret = asoc_simple_init_jack(&priv->card, &priv->hp_jack,
+					    1, NULL, "Headphone Jack");
+		if (ret)
+			goto asrc_fail;
+
+		snd_soc_jack_notifier_register(&priv->hp_jack.jack, &hp_jack_nb);
+	}
+
+	if (of_property_read_bool(np, "mic-det-gpio")) {
+		ret = asoc_simple_init_jack(&priv->card, &priv->mic_jack,
+					    0, NULL, "Mic Jack");
+		if (ret)
+			goto asrc_fail;
+
+		snd_soc_jack_notifier_register(&priv->mic_jack.jack, &mic_jack_nb);
+	}
 
 asrc_fail:
 	of_node_put(asrc_np);
-- 
2.27.0

