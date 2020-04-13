Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B915FC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 09:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AEBE20678
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 09:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgDMIfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 04:35:44 -0400
Received: from mga04.intel.com ([192.55.52.120]:60863 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727795AbgDMIez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 04:34:55 -0400
IronPort-SDR: odkCGTvyB8UjCzKWLrUJ3FfJP/p13xW+1OfF8VR58J2MkpPqiPebo3DuBHQMofM3IQmDbyAuUo
 lr63i/9XxwIg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 01:34:55 -0700
IronPort-SDR: XkPBaEPk3nYKkijQE0zTcybK4lHwfULNgyRdgi64MnHpbewtkjOe0HJmutO6/sflQDAWZZzaHC
 qF1yJLGFfZAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="252813717"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
  by orsmga003.jf.intel.com with ESMTP; 13 Apr 2020 01:34:52 -0700
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
Subject: [PATCH v2] ASoC: bdw-rt5650: remove 3-channel capture support
Date:   Mon, 13 Apr 2020 16:28:53 +0800
Message-Id: <1586766533-18557-1-git-send-email-brent.lu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a constrain to exclude 3-channel capture since only 2 and 4
channel capture are supported on the platform.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/boards/bdw-rt5650.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/sound/soc/intel/boards/bdw-rt5650.c b/sound/soc/intel/boards/bdw-rt5650.c
index af2f502..eedbdad 100644
--- a/sound/soc/intel/boards/bdw-rt5650.c
+++ b/sound/soc/intel/boards/bdw-rt5650.c
@@ -83,6 +83,36 @@ static struct snd_soc_jack_pin mic_jack_pin = {
 	.mask	= SND_JACK_MICROPHONE,
 };
 
+static const unsigned int channels[] = {
+	2, 4,
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
+	 * 2 or 4 channel capture
+	 */
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		snd_pcm_hw_constraint_list(runtime, 0,
+					   SNDRV_PCM_HW_PARAM_CHANNELS,
+					   &constraints_channels);
+
+	return 0;
+}
+
+static const struct snd_soc_ops bdw_rt5650_fe_ops = {
+	.startup = bdw_fe_startup,
+};
+
 static int broadwell_ssp0_fixup(struct snd_soc_pcm_runtime *rtd,
 			struct snd_pcm_hw_params *params)
 {
@@ -234,6 +264,7 @@ static struct snd_soc_dai_link bdw_rt5650_dais[] = {
 		.name = "System PCM",
 		.stream_name = "System Playback",
 		.dynamic = 1,
+		.ops = &bdw_rt5650_fe_ops,
 #if !IS_ENABLED(CONFIG_SND_SOC_SOF_BROADWELL)
 		.init = bdw_rt5650_rtd_init,
 #endif
-- 
2.7.4

