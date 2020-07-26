Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB29C433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 16:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94943206D8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 16:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgGZQNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 12:13:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:38650 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgGZQNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 12:13:31 -0400
IronPort-SDR: gOPy6rNDnLt5QTCDYPnIFqs/BDrVESrejTS/z1MWUql4XTtWkLYDkBasgdaNweBCGie/YITFyU
 rZCJ4EbIVuYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="212439391"
X-IronPort-AV: E=Sophos;i="5.75,399,1589266800"; 
   d="scan'208";a="212439391"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2020 09:13:30 -0700
IronPort-SDR: yY+zWewQlmIQQ4SZm4+Nwpo6JVvW6PCWzRkaV6S7B8WFSsqloF5rtBvgtjoH2MxNNHuoXi08YD
 rVQppWcFXqng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,399,1589266800"; 
   d="scan'208";a="319798585"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
  by orsmga008.jf.intel.com with ESMTP; 26 Jul 2020 09:13:28 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Brent Lu <brent.lu@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: Intel: Atom: use hardware counter to update hw_ptr
Date:   Mon, 27 Jul 2020 00:08:47 +0800
Message-Id: <1595779727-31404-1-git-send-email-brent.lu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ring buffer counter runs faster than hardware counter if the
period size in hw_param is larger than 240. Although the differce is
not much (around 2k frames), it causes false underrun in CRAS
sometimes because it's using 256 frames as period size in hw_param.
Using the hardware counter could provide precise hw_ptr to user space
and avoid the false underrun in CRAS.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/atom/sst/sst_drv_interface.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_drv_interface.c b/sound/soc/intel/atom/sst/sst_drv_interface.c
index 7624953..1949ad9 100644
--- a/sound/soc/intel/atom/sst/sst_drv_interface.c
+++ b/sound/soc/intel/atom/sst/sst_drv_interface.c
@@ -485,7 +485,6 @@ static inline int sst_calc_tstamp(struct intel_sst_drv *ctx,
 		struct snd_pcm_substream *substream,
 		struct snd_sst_tstamp *fw_tstamp)
 {
-	size_t delay_bytes, delay_frames;
 	size_t buffer_sz;
 	u32 pointer_bytes, pointer_samples;
 
@@ -493,22 +492,14 @@ static inline int sst_calc_tstamp(struct intel_sst_drv *ctx,
 			fw_tstamp->ring_buffer_counter);
 	dev_dbg(ctx->dev, "mrfld hardware_counter %llu in bytes\n",
 			 fw_tstamp->hardware_counter);
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		delay_bytes = (size_t) (fw_tstamp->ring_buffer_counter -
-					fw_tstamp->hardware_counter);
-	else
-		delay_bytes = (size_t) (fw_tstamp->hardware_counter -
-					fw_tstamp->ring_buffer_counter);
-	delay_frames = bytes_to_frames(substream->runtime, delay_bytes);
+
 	buffer_sz = snd_pcm_lib_buffer_bytes(substream);
-	div_u64_rem(fw_tstamp->ring_buffer_counter, buffer_sz, &pointer_bytes);
+	div_u64_rem(fw_tstamp->hardware_counter, buffer_sz, &pointer_bytes);
 	pointer_samples = bytes_to_samples(substream->runtime, pointer_bytes);
 
-	dev_dbg(ctx->dev, "pcm delay %zu in bytes\n", delay_bytes);
-
 	info->buffer_ptr = pointer_samples / substream->runtime->channels;
+	info->pcm_delay = 0;
 
-	info->pcm_delay = delay_frames;
 	dev_dbg(ctx->dev, "buffer ptr %llu pcm_delay rep: %llu\n",
 			info->buffer_ptr, info->pcm_delay);
 	return 0;
-- 
2.7.4

