Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C089CC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 08:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B2C208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 08:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgBJIXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 03:23:16 -0500
Received: from mga06.intel.com ([134.134.136.31]:35363 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbgBJIXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 03:23:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 00:23:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,424,1574150400"; 
   d="scan'208";a="251116475"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
  by orsmga002.jf.intel.com with ESMTP; 10 Feb 2020 00:23:13 -0800
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        cychiang@google.com, mac.chiang@intel.com,
        Brent Lu <brent.lu@intel.com>
Subject: [PATCH] ASoC: da7219: check SRM lock in trigger callback
Date:   Mon, 10 Feb 2020 16:16:51 +0800
Message-Id: <1581322611-25695-1-git-send-email-brent.lu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel sst firmware turns on BCLK/WCLK in START Ioctl call which timing is
later than the DAPM SUPPLY event handler da7219_dai_event is called (in
PREPARED state). Therefore, the SRM lock check always fail.

Moving the check to trigger callback could ensure the SRM is locked before
DSP starts to process data and avoid possisble noise.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/codecs/da7219.c | 68 +++++++++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 23 deletions(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index f83a6ea..0fb5ea5 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -794,9 +794,7 @@ static int da7219_dai_event(struct snd_soc_dapm_widget *w,
 	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
 	struct da7219_priv *da7219 = snd_soc_component_get_drvdata(component);
 	struct clk *bclk = da7219->dai_clks[DA7219_DAI_BCLK_IDX];
-	u8 pll_ctrl, pll_status;
-	int i = 0, ret;
-	bool srm_lock = false;
+	int ret;
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
@@ -820,26 +818,6 @@ static int da7219_dai_event(struct snd_soc_dapm_widget *w,
 		/* PC synchronised to DAI */
 		snd_soc_component_update_bits(component, DA7219_PC_COUNT,
 				    DA7219_PC_FREERUN_MASK, 0);
-
-		/* Slave mode, if SRM not enabled no need for status checks */
-		pll_ctrl = snd_soc_component_read32(component, DA7219_PLL_CTRL);
-		if ((pll_ctrl & DA7219_PLL_MODE_MASK) != DA7219_PLL_MODE_SRM)
-			return 0;
-
-		/* Check SRM has locked */
-		do {
-			pll_status = snd_soc_component_read32(component, DA7219_PLL_SRM_STS);
-			if (pll_status & DA7219_PLL_SRM_STS_SRM_LOCK) {
-				srm_lock = true;
-			} else {
-				++i;
-				msleep(50);
-			}
-		} while ((i < DA7219_SRM_CHECK_RETRIES) && (!srm_lock));
-
-		if (!srm_lock)
-			dev_warn(component->dev, "SRM failed to lock\n");
-
 		return 0;
 	case SND_SOC_DAPM_POST_PMD:
 		/* PC free-running */
@@ -1658,12 +1636,56 @@ static int da7219_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static int da7219_set_dai_trigger(struct snd_pcm_substream *substream, int cmd,
+				  struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	u8 pll_ctrl, pll_status;
+	int i = 0;
+	bool srm_lock = false;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		/* Slave mode, if SRM not enabled no need for status checks */
+		pll_ctrl = snd_soc_component_read32(component, DA7219_PLL_CTRL);
+		if ((pll_ctrl & DA7219_PLL_MODE_MASK) != DA7219_PLL_MODE_SRM)
+			return 0;
+
+		/* Check SRM has locked */
+		do {
+			pll_status = snd_soc_component_read32(component,
+							DA7219_PLL_SRM_STS);
+			if (pll_status & DA7219_PLL_SRM_STS_SRM_LOCK) {
+				srm_lock = true;
+			} else {
+				++i;
+				msleep(50);
+			}
+		} while ((i < DA7219_SRM_CHECK_RETRIES) && (!srm_lock));
+
+		if (!srm_lock)
+			dev_warn(component->dev, "SRM failed to lock\n");
+
+		break;
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static const struct snd_soc_dai_ops da7219_dai_ops = {
 	.hw_params	= da7219_hw_params,
 	.set_sysclk	= da7219_set_dai_sysclk,
 	.set_pll	= da7219_set_dai_pll,
 	.set_fmt	= da7219_set_dai_fmt,
 	.set_tdm_slot	= da7219_set_dai_tdm_slot,
+	.trigger	= da7219_set_dai_trigger,
 };
 
 #define DA7219_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE |\
-- 
2.7.4

