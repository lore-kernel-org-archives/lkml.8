Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D139C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03EFD20738
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgD0RTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 13:19:53 -0400
Received: from mga04.intel.com ([192.55.52.120]:16042 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgD0RTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 13:19:52 -0400
IronPort-SDR: 7BF6iMFpRFjmHMTzozqjpLI1I4KOExEGhEQUlxZRmM/U8+he/Z7P4HpAPlFYIxqveFwyeX9KaT
 li8DtKr41XgQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 10:19:52 -0700
IronPort-SDR: qR4Kl7iDwe7OCTiKka/OGaDhPkyxZ18YZCLRxTbtSWsWKtqfp0T/neuElK3JEllXJqS27rrYAz
 ywtDQtVCwyAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,324,1583222400"; 
   d="scan'208";a="458932358"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
  by fmsmga006.fm.intel.com with ESMTP; 27 Apr 2020 10:19:49 -0700
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
Subject: [PATCH v2 3/3] ASoC: broadwell: add channel constraint
Date:   Tue, 28 Apr 2020 01:13:34 +0800
Message-Id: <1588007614-25061-4-git-send-email-brent.lu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588007614-25061-1-git-send-email-brent.lu@intel.com>
References: <1588007614-25061-1-git-send-email-brent.lu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BDW boards using this machine driver supports only stereo capture and
playback. Implement a constraint to enforce it.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/boards/broadwell.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/sound/soc/intel/boards/broadwell.c b/sound/soc/intel/boards/broadwell.c
index f9a8336..07b2cfd 100644
--- a/sound/soc/intel/boards/broadwell.c
+++ b/sound/soc/intel/boards/broadwell.c
@@ -143,6 +143,31 @@ static int broadwell_rtd_init(struct snd_soc_pcm_runtime *rtd)
 }
 #endif
 
+static const unsigned int channels[] = {
+	2,
+};
+
+static const struct snd_pcm_hw_constraint_list constraints_channels = {
+	.count = ARRAY_SIZE(channels),
+	.list = channels,
+	.mask = 0,
+};
+
+static int broadwell_fe_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	/* Board supports stereo configuration only */
+	runtime->hw.channels_max = 2;
+	return snd_pcm_hw_constraint_list(runtime, 0,
+					  SNDRV_PCM_HW_PARAM_CHANNELS,
+					  &constraints_channels);
+}
+
+static const struct snd_soc_ops broadwell_fe_ops = {
+	.startup = broadwell_fe_startup,
+};
+
 SND_SOC_DAILINK_DEF(system,
 	DAILINK_COMP_ARRAY(COMP_CPU("System Pin")));
 
@@ -180,6 +205,7 @@ static struct snd_soc_dai_link broadwell_rt286_dais[] = {
 		.init = broadwell_rtd_init,
 #endif
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
+		.ops = &broadwell_fe_ops,
 		.dpcm_playback = 1,
 		.dpcm_capture = 1,
 		SND_SOC_DAILINK_REG(system, dummy, platform),
-- 
2.7.4

