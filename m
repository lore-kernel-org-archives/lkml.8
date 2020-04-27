Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F6FC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33CBE2098B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgD0Ina (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 04:43:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:49908 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbgD0In3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:43:29 -0400
IronPort-SDR: W3GgC9Vpu28NMePxsVhYrOBWuffcLy7cOXqMRVlvouIIU1Q/nAV6IgOxwLYK1xHccRSj6Eki4x
 pj2Oc1OC+JGA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 01:43:29 -0700
IronPort-SDR: W70FpfbFGXv4Y15djW/k2nA39A02axB8Ze4UMVrqXxjarL2+9R+SQnaYfuJDlmdIsDLkTx6wbH
 3IID+bCEHg/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,323,1583222400"; 
   d="scan'208";a="431673902"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
  by orsmga005.jf.intel.com with ESMTP; 27 Apr 2020 01:43:26 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Ben Zhang <benzh@chromium.org>,
        Mac Chiang <mac.chiang@intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Brent Lu <brent.lu@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ASoC: bdw-rt5677: channel constraint support
Date:   Mon, 27 Apr 2020 16:37:16 +0800
Message-Id: <1587976638-29806-2-git-send-email-brent.lu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587976638-29806-1-git-send-email-brent.lu@intel.com>
References: <1587976638-29806-1-git-send-email-brent.lu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BDW boards using this machine driver supports only stereo capture and
playback. Implement a constraint to enforce it.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/boards/bdw-rt5677.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/sound/soc/intel/boards/bdw-rt5677.c b/sound/soc/intel/boards/bdw-rt5677.c
index cc41a34..7963cae 100644
--- a/sound/soc/intel/boards/bdw-rt5677.c
+++ b/sound/soc/intel/boards/bdw-rt5677.c
@@ -22,6 +22,8 @@
 
 #include "../../codecs/rt5677.h"
 
+#define DUAL_CHANNEL 2
+
 struct bdw_rt5677_priv {
 	struct gpio_desc *gpio_hp_en;
 	struct snd_soc_component *component;
@@ -222,6 +224,36 @@ static int bdw_rt5677_rtd_init(struct snd_soc_pcm_runtime *rtd)
 }
 #endif
 
+static const unsigned int channels[] = {
+	DUAL_CHANNEL,
+};
+
+static const struct snd_pcm_hw_constraint_list constraints_channels = {
+	.count = ARRAY_SIZE(channels),
+	.list = channels,
+	.mask = 0,
+};
+
+static int bdw_fe_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	/*
+	 * On this platform for PCM device we support,
+	 * stereo audio
+	 */
+
+	runtime->hw.channels_max = DUAL_CHANNEL;
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+					   &constraints_channels);
+
+	return 0;
+}
+
+static const struct snd_soc_ops bdw_rt5677_fe_ops = {
+	.startup = bdw_fe_startup,
+};
+
 static int bdw_rt5677_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct bdw_rt5677_priv *bdw_rt5677 =
@@ -321,6 +353,7 @@ static struct snd_soc_dai_link bdw_rt5677_dais[] = {
 		},
 		.dpcm_capture = 1,
 		.dpcm_playback = 1,
+		.ops = &bdw_rt5677_fe_ops,
 		SND_SOC_DAILINK_REG(fe, dummy, platform),
 	},
 
-- 
2.7.4

